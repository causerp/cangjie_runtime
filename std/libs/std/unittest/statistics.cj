/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file contains implementation of statistical calculations required for benchmark analysis.
 */
package std.unittest

import std.collection.*
import std.math.*
import std.random.Random
import std.sort.SortExtension
import std.sync.*
import std.unittest.common.DataStrategy
import std.unittest.diff.AssertPrintable
import std.unittest.prop_test.ShrinkHelpers

class Sample {
    Sample(let data: ArrayList<Float64>) {
        // sorted to easily get percentiles
        this.data.removeIf { x => x.isNaN() }
        this.data.sort()
    }

    prop size: Int64 {
        get() { data.size }
    }

    func mean(): Float64 {
        let sum = data |> fold(0.0) { a, b => a + b }
        sum / Float64(data.size)
    }

    func percentile(ratio: Float64): Float64 {
        if (this.data.size == 0) {
            return Float64.NaN
        }
        let x = clamp(Float64(this.data.size - 1) * ratio, 0.0, Float64(this.data.size - 1))
        (this.data[Int64(ceil(x))] + this.data[Int64(floor(x))]) / 2.0
    }

    static func create(data: ArrayList<Float64>): Sample {
        Sample(data)
    }


    // kernel density estimation
    func kde(kdeThroughput: Float64): ArrayList<(Float64, Float64)> {
        let result = ArrayList<(Float64, Float64)>()

        let range = max(this.percentile(0.99) - this.percentile(0.01), 0.01)
        let bins = pow(Float64(data.size), 1.0/5.0) / kdeThroughput
        let windowLen = range / bins
        let minStep = max(windowLen / 4.0, range / 200.0)

        var point = data[0] - minStep * 1.5
        var i = 0
        while (i < data.size || point < data[data.size - 1] + minStep * 1.5) {

            point = if (i < data.size && data[i] <= point+minStep) {
                i += 1
                // very crude optimization to take generally less than quadratic time to build kde
                // otherwise its BOOTSTRAP_ITERATIONS^2 = 2000*2000 iterations of quite slow normalDist functions.
                // and we need to calculate quite a lot of kde
                if (data[i - 1] <= point+minStep / 3.0) {
                    continue
                }

                data[i - 1]
            } else {
                point + minStep
            }

            var value = 0.0

            func normalDist(x: Float64, sigma: Float64): Float64 {
                let s2 = sigma * sigma
                exp(-x * x * 0.5 / s2) / sqrt(2.0 * Float64.GetPI() * s2)
            }
            for (x in data) {
                value += normalDist(point - x, windowLen / 6.0) / Float64(data.size)
            }

            if (point <= this.percentile(0.99) + minStep && point >= this.percentile(0.01) - minStep) {
                result.add((point, value))
            }
        }
        return result

    }
}

/* coefficient corresponding to 95% confidence interval for median */
let MEDIAN_CI_95_COEFF: Float64 = 1.96
/* coefficient corresponding to 99% confidence interval for median */
let MEDIAN_CI_99_COEFF: Float64 = 2.58
let MEDIAN_CI_999_COEFF: Float64 = 3.291
// simple epsilon to compare floats
let EPSILON: Float64 = 0.0001

class Measurements {
    Measurements(
        private let data: Array<(Float64,Float64)>
    ) {}

    var slopes: Sample = Sample(ArrayList())
    var mainSlope: Float64 = 0.0
    var intercept: Float64 = 0.0
    var errorEst: Float64 = 0.0
    var r2: Float64 = 0.0

    // Calculates slope and 95% confidence interval(CI) according to Theil-Sen linear regression.
    //
    // Algorithm is to calculate slopes of lines passing through every pair of points.
    // And the median of these slopes is the linear regression we are searching for.
    // And CI for it is calculated with a simple formula, no need for bootstrapping or other complex statistical calculations
    func calculateMedian(): This {
        this.calcSlopes()

        this.mainSlope = this.slopes.percentile(0.5)

        let intercepts = ArrayList<Float64>()
        for ((x, y) in data) {
            intercepts.add(y - x * this.mainSlope)
        }
        this.intercept = Sample(intercepts).percentile(0.5)

        let absErrs = this.slopes.data |>
            map<Float64, Float64>({ x => abs(this.mainSlope - x) }) |>
            collectArrayList<Float64> |>
            Sample.create

        //to indicate big error if sample size is very small
        absErrs.data.add(this.mainSlope)

        let n = Float64(absErrs.size)
        // this is formula for index offset from n/2 at which CI boundaries are located in both directions
        let medianCIOffset = MEDIAN_CI_999_COEFF * sqrt(n) * 0.5 / n
        // however for simplicity we want to give user a single number as an error estimation
        // so we are going to the same offset but for absolute deviation,
        // doubling it because we are going in one direction here
        this.errorEst = absErrs.percentile(2.0 * medianCIOffset)
        this
    }

    func calcSlopes() {
        let slopes = ArrayList<Float64>()

        let slopes2 = ArrayList<Float64>()
        for ((x1, y1) in data) {
            for ((x2, y2) in data) {
                if (abs(x1 - x2) > 0.0001) {
                    let slope = (y1 - y2) / (x1 - x2)
                    slopes2.add(slope)
                }
            }
            slopes.add(Sample(slopes2).percentile(0.5))
            slopes2.clear()
        }

        this.slopes = Sample(slopes)
    }

    // Calculates mean slope according to ordinary least squares linear regression.
    func calculateMean(): This {
        let sumx = data.iterator().map {p => p[0]}.sum()
        let sumy = data.iterator().fold(0.0) {acc, p => p[1] + acc}
        let sumx2 = data.iterator().fold(0.0) {acc, p => p[0] * p[0] + acc}
        let sumxy = data.iterator().fold(0.0) {acc, p => p[0] * p[1] + acc}

        let n = Float64(data.size)

        this.mainSlope = (n * sumxy - sumx * sumy) / (n * sumx2 - sumx * sumx)

        this.intercept = (sumy - this.mainSlope * sumx) / n

        // we know apriori that under our model negative intercept or slope should not be possible
        // so we fall back to regressing to a line with zero intercept or zero slope in that case
        // choosing the one with lower MSE
        if (mainSlope < 0.0 || intercept < 0.0) {
            let slope = sumxy / sumx2
            let zeroInterceptMSE = data.iterator().map {p: (Float64, Float64) => pow(p[1] - p[0] * slope, 2)}.sum() /
                Float64(data.size)

            let intercept = sumy / n
            let zeroSlopeMSE = data.iterator().map {p: (Float64, Float64) => pow(p[1] - intercept, 2)}.sum() / Float64(
                data.size)

            if (zeroSlopeMSE < zeroInterceptMSE) {
                this.intercept = intercept
                this.mainSlope = 0.0
            } else {
                this.intercept = 0.0
                this.mainSlope = slope
            }
        }

        let sumres = data.iterator().fold(0.0) { acc, p => pow(p[0] * mainSlope + intercept - p[1], 2.0) + acc }
        let sumtot = data.iterator().fold(0.0) { acc, p => pow(sumy / n - p[1], 2.0) + acc }
        this.r2 = 1.0 - sumres / sumtot

        this
    }
}

interface AsFloat {
    func asFloat(): Float64
}

extend Float64 <: AsFloat {
    public func asFloat(): Float64 {
        this
    }
}

extend<T> Iterator<T> where T <: AsFloat {
    @Frozen
    func sum(): Float64 {
        this.filterMap{ x => x.asFloat() }.fold(0.0) { acc, p => acc + p }
    }
}
