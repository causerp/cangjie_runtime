# Copyright © 2025 Huawei Technologies Co., Ltd. All Rights Reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(UNITTEST_SRCS
    api.cj
    assert.cj
    assert_exception.cj
    bench_apis.cj
    bench_executor.cj
    bench_table.cj
    bench_test_case.cj
    check_result.cj
    csv_strategy.cj
    custom_assertion.cj
    default_configuration.cj
    entry_main.cj
    execution.cj
    fail.cj
    filtration.cj
    framework.cj
    id.cj
    json_strategy.cj
    options.cj
    parallel.cj
    parameter_test_case.cj
    platform_specific.cj
    power_assert_diagram_builder.cj
    pretty_console.cj
    pretty_table.cj
    process.cj
    reexport.cj
    render_exception.cj
    report_bench_csv.cj
    reporter_api.cj
    reporter_progress.cj
    reporter_progress_tests.cj
    report_stats.cj
    report_unittest_xml.cj
    result.cj
    result_serialize.cj
    statistics.cj
    strategy_processor.cj
    suite_executor.cj
    tempdir.cj
    test_case_executor.cj
    test_code.cj
    text_report.cj
    timeout.cj
    transport.cj
    unittest_exception.cj
    util.cj
    CACHE INTERNAL "")
add_subdirectory(native)
