use Test::Most tests => 4;

require_ok('ReportRepair');

my $report = ReportRepair->new();

$report->load('t/day01_input0.txt');
ok($report->get_expense_count == 6, 'number of expenses');
ok($report->calc_double_product(2020) == 514579, 'double 2020 product');
ok($report->calc_triple_product(2020) == 241861950, 'triple 2020 product');

$report->load('t/day01_input1.txt');
note "Day 1a answer: ", $report->calc_double_product(2020);
note "Day 1b answer: ", $report->calc_triple_product(2020);
