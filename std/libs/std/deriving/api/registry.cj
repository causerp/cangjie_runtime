/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.api

import std.collection.*
import std.sync.AtomicInt64

/**
 * Does register Deriving implementation for all it's supported interfaces or
 * fails if there is already Deriving registered for one of the interfaces.
 */
public func registerDeriving(implementation: Deriving): Unit {
    let registration = Registration(implementation)
    let fqNames = implementation.supportedInterfaces

    for (name in fqNames) {
        if (let Some(existing) <- Registration.find(name)) {
            alreadyRegistered(name, implementation, existing)
        }
    }

    for (name in fqNames) {
        Registration.register(name, registration)
    }
}

/**
 * Finds deriving implementation for the specified interface name
 * or return None if no derivings registered for the interface
 */
public func findDeriving(name: QualifiedName): ?Deriving {
    Registration.find(name)?.deriving
}

/**
 * Finds deriving implementations for interfaces. Returns registered derivings with their
 * interfaces and an array of interfaces having no relevant derivings registered.
 */
public func findDerivings(
    names: Iterable<QualifiedName>
): (derivingsToRun: Array<(Deriving, Array<QualifiedName>)>, unresolved: Array<QualifiedName>) {
    let registrations = names |>
        map { name: QualifiedName => (name, Registration.find(name)) } |>
        collectHashMap

    let resolved = names |> groupBy<?Registration, QualifiedName> { name => registrations[name] } |>
        filter { it: (?Registration, Array<QualifiedName>) =>
            it[0].isSome()
        } |> map { it: (?Registration, Array<QualifiedName>) =>
            (it[0].getOrThrow().deriving, it[1])
        } |> collectArray

    let unresolved = registrations |> filter { it: (QualifiedName, ?Registration) => it[1].isNone() } |>
        map<(QualifiedName, ?Registration), QualifiedName> { pair => pair[0] } |>
        collectArray

    return (resolved, unresolved)
}

public func interfacesBySimpleName(simpleName: String): Array<QualifiedName> {
    Registration.find(simpleName).iterator()
        .flatMap { it => it.deriving.supportedInterfaces.iterator() }
        .filter { it => it.simpleName.value == simpleName } |>
        collectArray
}

struct Registration <: Equatable<Registration> & Hashable {
    Registration(
        let deriving: Deriving
    ) {}

    private let id = counter.fetchAdd(1)

    private static let all = HashMap<QualifiedName, Registration>()

    static func register(name: QualifiedName, candidate: Registration) {
        if (all.addIfAbsent(name, candidate).isSome()) {
            alreadyRegistered(name, candidate.deriving, all[name])
        }
    }

    static func find(name: QualifiedName): ?Registration {
        all.get(name)
    }

    static func find(simpleName: String): Array<Registration> {
        all.values().iterator()
            .filter { it => it.deriving.supportedInterfaces
                .iterator().any { iface => iface.simpleName.value == simpleName }
            } |>
            collectArray
    }

    public override operator func ==(other: Registration): Bool {
        id == other.id
    }

    public override operator func !=(other: Registration): Bool {
        id != other.id
    }

    public override func hashCode(): Int64 {
        id.hashCode()
    }

    private static let counter = AtomicInt64(0)
}

private func alreadyRegistered(
    name: QualifiedName,
    candidate: Deriving,
    alreadyExisting: Registration
): Nothing {
    throw IllegalArgumentException(
        "Deriving for type ${name} is already registered: " +
        "${alreadyExisting.deriving.name}, failed to register ${candidate.name}")
}

private func groupBy<K, V>(
    keyFor: (V) -> K
): (Iterable<V>) -> Iterable<(K, Array<V>)>
        where K <: Hashable & Equatable<K> {{ it =>
    let result = HashMap<K, ArrayList<V>>()
    func putValue(k: K, value: V): Unit {
        match (result.get(k)) {
            case Some(list) => list.add(value)
            case None => result.add(k, ArrayList<V>.of(value))
        }
    }

    for (value in it) {
        putValue(keyFor(value), value)
    }

    return result |> map<(K, ArrayList<V>), (K, Array<V>)> { pair =>
        let (k, list) = pair
        (k, list.toArray())
    }
}}
