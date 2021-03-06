// Note this code was heavily borrowed from the javascript npm package chi-squared-test, chi-squared and gamma
// All credits for algorithms / implementation go to those authors

import 'dart:math';

import 'package:dart_statistics/dart_statistics.dart';
import 'package:test/test.dart';

void main() {
  group('Chi squared test', () {
    final expected = <double>[];
    final observed = <double>[];

    setUp(() {
      expected.addAll([2, 2, 2, 2, 2, 2]);
    });

    tearDown(() {
      expected.clear();
      observed.clear();
    });

    test('Chi Squared Test Disproves Hypotheses', () {
      observed.addAll([6, 3, 3, 0, 0, 0]);
      expect(
          chiSquaredTest(
            observed,
            expected,
          ).probability,
          const ApproxEqual(0.010362, 1e-6));
    });

    test('Chi Squared Test Inconclusive', () {
      observed.addAll([1, 2, 4, 4, 2, 1]);
      expect(
          chiSquaredTest(
            observed,
            expected,
          ).probability,
          const ApproxEqual(0.415881, 1e-6));
    });

    test('A few more test cases from the javascript chi-squared-test library',
        () {
      final testCases = [
        [
          <double>[1, 1],
          <double>[1, 1],
          false
        ],
        [
          <double>[6, 3, 3, 0, 0, 0],
          <double>[2, 2, 2, 2, 2, 2],
          true
        ],
        [
          <double>[2, 2, 4, 4, 2, 2],
          <double>[2, 2, 2, 2, 2, 2],
          false
        ]
      ];

      for (final test in testCases) {
        final result =
            chiSquaredTest(test[0] as List<double>, test[1] as List<double>);
        final p = result.probability;
        if (test[2] as bool) {
          expect(p <= 0.05, true, reason: 'Expected $p to be significant');
        } else {
          expect(p > 0.05, true, reason: 'Expected $p to not be significant');
        }
      }
    });
  });

  group('Chi library tests', () {
    test('chi', () {
      expect(chiPDF(0.5, 1), const ApproxEqual(0.4393912894677223, 1e-13));
      expect(chiPDF(2.3, 1.4), const ApproxEqual(0.11695769277348175, 1e-13));
    });

    test('chi cdf', () {
      expect(chiCDF(2, 2), const ApproxEqual(0.6321204474030797, 1e-13));
      expect(chiCDF(1, 3), const ApproxEqual(0.19874802827905516, 1e-13));
      expect(chiCDF(200, 256), const ApproxEqual(0.00399456708950239, 1e-13));
    });
  });

  group('Gamma tests', () {
    test('factorials', () {
      final facts = <double>[];
      var f = 1.0;
      for (var i = 1; i < 12; i++) {
        facts.add(f *= i);
      }
      for (var n = 0; n < facts.length; n++) {
        final res = gamma(n + 2.0);
        expect(facts[n], (res * 1e6).round() / 1e6);
      }
    });

    test('integrate', () {
      final zs = [0.84, 1.31, 2.54, 3.01, 5.2, 6.1];

      for (var i = 0; i < zs.length; i++) {
        // integration by rectangles
        var res = 0.0;
        const dx = 0.0001;
        for (var x = 0.000001; x < 40; x += dx) {
          res += exp(-x) * pow(x, zs[i] - 1) * dx;
        }
        expect((res * 10).round() / 10, (gamma(zs[i]) * 10).round() / 10,
            reason: 'z = ${zs[i]}');
      }
    });
  });
}

class ApproxEqual extends Matcher {
  const ApproxEqual(this.value, this.epsilon) : assert(epsilon >= 0);

  final double value;
  final double epsilon;

  @override
  bool matches(dynamic object, Map<dynamic, dynamic> matchState) {
    if (object is! double) {
      return false;
    }
    if (object == value) {
      return true;
    }
    final test = object;
    return (test - value).abs() <= epsilon;
  }

  @override
  Description describe(Description description) =>
      description.add('$value (±$epsilon)');

  @override
  Description describeMismatch(dynamic item, Description mismatchDescription,
          Map<dynamic, dynamic> matchState, bool verbose) =>
      super.describeMismatch(item, mismatchDescription, matchState, verbose)
        ..add('$item is not within $value (±$epsilon).');
}
