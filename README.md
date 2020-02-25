A dart library for statistics

## Usage

A simple usage example:

```dart
import 'package:dart_stats/dart_stats.dart';


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
    degreesOfFreedomReduction: reduction,
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
    degreesOfFreedomReduction: reduction,
  ).probability;
  print(probability);
  assert(probability == 0.414881);
// Gives back 0.415881, which is indicates that they did come from the same distribution (by most statistical standards)
}

```

## Features and bugs

Please file feature requests and bugs on github, I will gladly accept pull requests and changes, this is not a library that I'm actively developing. If anyone would like to take over the library that is also fine.
