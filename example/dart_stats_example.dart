// Note this code was heavily borrowed from the javascript npm package chi-squared-test
// All credits for algorithms / implementation go to those authors

import 'package:dart_statistics/dart_statistics.dart';

void main() {
// We expect a fair die
  final expected = <double>[2, 2, 2, 2, 2, 2];

// Looks pretty unfair...
  final observed = <double>[6, 3, 3, 0, 0, 0];

// Reduction in degrees of freedom is 1, since knowing 5 categories determines the 6th
  final reduction = 1;

  var probability = chiSquaredTest(
    observed,
    expected,
    degreesOfFreedomReduction: reduction, // Default is actually one, so this isn't required
  ).probability;
  print(probability);
  assert(probability == 0.010362);
// Gives 0.010362, which indicates that it's unlikely the die is fair

// However, something a little more likely
  observed.clear();
  observed.addAll([1, 2, 4, 4, 2, 1]);
  probability = chiSquaredTest(
    observed,
    expected,
    degreesOfFreedomReduction: reduction, // Default is actually one, so this isn't required
  ).probability;
  print(probability);
  assert(probability == 0.414881);
// Gives back 0.415881, which is indicates that they did come from the same distribution (by most statistical standards)
}
