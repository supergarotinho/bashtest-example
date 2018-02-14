## Docker image of zeppelin notebook

```
[![Build Status](https://dockerbuildbadges.quelltext.eu/status.svg?organization=supergarotinho&repository=zeppelin)](https://hub.docker.com/r/supergarotinho/zeppelin/)
```

**Author:** [Anderson Santos](https://br.linkedin.com/in/andersonrss)

### Main features

* Command parsing
  * Parse commands in defferent orders
  * Check for required commands
  * Parse commands separated by space
* Testing
  * Generates code coverage
  * Runs linter and checker
* Build
  * Show elapsed time
  * **TODO:** fail if the coverage is bellow some threshold
* Special methods for logging

### TODO

* Tests if the commands are being parsed correctly
* Build with shippable
* Badges
  * Shippable
  * Code coverage
  * Tweet
  * License
* Table of contents
* Images
  * Testing results
  * Coverage report
* fail if the coverage is bellow some threshold

### Directory structure

* **src:** Script source files
* **tests:** The test files
* **build.sh:** The build script to run the tests

### How to use it

Download it; fork or clone it
