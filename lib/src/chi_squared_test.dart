// Note this code was heavily borrowed from the javascript npm package chi-squared-test
// All credits for algorithms / implementation go to those authors

import 'dart:math';
import 'package:meta/meta.dart';
import 'chi_squared.dart';

/// Calculates the difference squared divided by the expectation
double calculateSingleChiSquaredTerm(double observed, double expected) =>
    pow(observed - expected, 2) / expected;

/// Calculates all terms of the chi-squared distribution
Result calculateChiSquaredStatistic(
    List<double> observations, List<double> expectations) {
  final result = Result(chiSquared: 0, terms: []);
  final n = observations.length;

  for (var i = 0; i < n; i++) {
    final singleTerm =
        calculateSingleChiSquaredTerm(observations[i], expectations[i]);
    result.terms.add(singleTerm);
    result.chiSquared += singleTerm;
  }
  return result;
}

/// Runs a chi-squared test and returns the chi-squared results for each term, the total, as well as the probability
Result chiSquaredTest(List<double> observations, List<double> expectations,
    {int degreesOfFreedomReduction = 1}) {
  final degreesOfFreedom = observations.length - degreesOfFreedomReduction;
  final result = calculateChiSquaredStatistic(observations, expectations);
  result.probability = 1 - chiCDF(result.chiSquared, degreesOfFreedom);
  return result;
}

/// The [Result] of a chi-squared test
class Result {
  /// The [Result] of a chi-squared test
  Result({@required this.chiSquared, @required this.terms});

  /// Chi squared result
  double /*!*/ chiSquared;

  /// Each term of the distribution
  List<double> /*!*/ terms;

  /// The p value of the chi-squared test
  double probability = 0;
}
