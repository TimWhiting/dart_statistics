// Note this code was heavily borrowed from the javascript npm package chi-squared
// All credits for algorithms / implementation go to those authors

import 'dart:math';
import 'gamma.dart';

double chiPDF(double x, double k_) {
  if (x < 0) return 0;
  var k = k_ / 2;
  return 1 / (pow(2, k) * gamma(k)) * pow(x, k - 1) * exp(-x / 2);
}

double chiGCF(double x, double a) {
  // Good for X>A+1
  var a0 = 0.0;
  var b0 = 1.0;
  var a1 = 1.0;
  var b1 = x;
  var aOld = 0.0;
  var n = 0.0;
  while (((a1 - aOld) / a1).abs() > .00001) {
    aOld = a1;
    n = n + 1;
    a0 = a1 + (n - a) * a0;
    b0 = b1 + (n - a) * b0;
    a1 = x * a0 + n * a1;
    b1 = x * b0 + n * b1;
    a0 = a0 / b1;
    b0 = b0 / b1;
    a1 = a1 / b1;
    b1 = 1;
  }
  var Prob = exp(a * log(x) - x - lngamma(a)) * a1;
  return 1 - Prob;
}

double chiGser(double x, double a) {
  // Good for X<A+1.
  var t9 = 1 / a;
  var g = t9;
  var i = 1.0;
  while (t9 > g * .00001) {
    t9 = t9 * x / (a + i);
    g = g + t9;
    i = i + 1;
  }
  g = g * exp(a * log(x) - x - lngamma(a));
  return g;
}

double gammaCDF(double x, double a) {
  double gi;
  if (x <= 0) {
    gi = 0;
  } else if (x < a + 1) {
    gi = chiGser(x, a);
  } else {
    gi = chiGCF(x, a);
  }
  return gi;
}

double chiCDF(double z, int df) {
  if (df <= 0) {
    throw Exception('Degrees of freedom must be positive');
  }
  return gammaCDF(z / 2.0, df / 2.0);
}
