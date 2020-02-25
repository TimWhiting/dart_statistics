## 0.0.1

- Initial version, created by Tim Whiting, borrowed heavily from javascript npm packages [chi-squared-test](https://www.npmjs.com/package/chi-squared-test), [chi-squared](https://www.npmjs.com/package/chi-squared) and [gamma](https://www.npmjs.com/package/gamma)


## 0.0.2

- Changed optional parameter of degrees of freedom reduction to be 1, since a lot of applications will require the frequencies / probabilities to sum to one. And a reduction of 0 would cause an exception anyways