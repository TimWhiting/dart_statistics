// Note this code was heavily borrowed from the javascript npm package chi-squared-test
// All credits for algorithms / implementation go to those authors

import 'dart:math';
import 'chi_squared.dart';

double calculateSingleChiSquaredTerm(double observed, double expected) {
  return pow(observed - expected, 2) / expected;
}

Result calculateChiSquaredStatistic(List<double> observations, List<double> expectations) {
  final result = Result(chiSquared: 0, terms: []);
  final n = observations.length;
  for (var i = 0; i < n; i++) {
    final singleTerm = calculateSingleChiSquaredTerm(observations[i], expectations[i]);
    result.terms.add(singleTerm);
    result.chiSquared += singleTerm;
  }
  return result;
}

Result chiSquaredTest(List<double> observations, List<double> expectations, {int degreesOfFreedomReduction = 1}) {
  final degreesOfFreedom = observations.length - degreesOfFreedomReduction;
  final result = calculateChiSquaredStatistic(observations, expectations);
  result.probability = 1 - chiCDF(result.chiSquared, degreesOfFreedom);
  return result;
}

class Result {
  double/*!*/ chiSquared;
  List<double>/*!*/ terms;
  double probability = 0;
  Result({this.chiSquared, this.terms});
}
