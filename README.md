<h1 align="center">Testing example for bash scripts &nbsp; <a href="https://twitter.com/intent/tweet?text=Execute%20and%20generate%20bash%20testing%20report%20with%20supergarotinho%2Fbashtest%20image!&amp;url=https://www.gruponeuro.com.br&amp;via=supergarotinho&amp;hashtags=docker,bash,test,testing,report,coverage,shunit2,kcov" rel="nofollow"><img src="https://camo.githubusercontent.com/83d4084f7b71558e33b08844da5c773a8657e271/68747470733a2f2f696d672e736869656c64732e696f2f747769747465722f75726c2f687474702f736869656c64732e696f2e7376673f7374796c653d736f6369616c" alt="Tweet" data-canonical-src="https://img.shields.io/twitter/url/http/shields.io.svg?style=social" style="max-width:100%;"></a>
</h1>
<div align="center">
  <strong>Fun programming with bash and writing tests</strong>
</div>
<div align="center">
  A testing example for bash scripts
</div>

<br />

<div align="center">

  <!-- Build Status -->
  <a href="https://travis-ci.org/supergarotinho/bashtest-example">
    <img src="https://travis-ci.org/supergarotinho/ambari-mongodb.svg?branch=master"
      alt="Build Status" />
  </a>
  <!-- Coverage Status -->
  <a href="https://coveralls.io/github/supergarotinho/bashtest-example?branch=master">
    <img src="https://coveralls.io/repos/github/supergarotinho/bashtest-example/badge.svg?branch=master"
      alt="Coverage Status" />
  </a>
  <!-- Price -->
  <a href="https://github.com/supergarotinho/bashtest-example/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/price-FREE-0098f7.svg"
      alt="Price" />
  </a>
  <!-- License: BSD-3 -->
  <a href="https://github.com/supergarotinho/bashtest-example/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/license-BSD3-blue.svg"
      alt="License: BSD-3" />
  </a>
  <!-- Contributions welcome -->
  <img src="https://img.shields.io/badge/contributions-welcome-orange.svg"
    alt="Contributions welcome" />
</div>

<br/>

<div align="center">
  <strong>Author:</strong> <a href="https://br.linkedin.com/in/andersonrss">Anderson Santos</a>
</div>

<div align="center">
  <sub>Built with ❤︎ by
  <a href="https://br.linkedin.com/in/andersonrss">Anderson Santos</a> and
  <a href="https://github.com/supergarotinho/bashtest-example/graphs/contributors">
    contributors
  </a>
</div>

## Table of contents

- [Features](#features)
- [TODO](#todo)
- [Getting Started](#getting-started)
  - [How to use it](#how-to-use-it)
- [Running the tests](#running-the-tests)
- [Built With](#built-with)
- [Authors](#authors)
- [Community](#community)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Features

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

## TODO

* Tests if the commands are being parsed correctly
* Build with jenkins
* Table of contents
* Images
  * Testing results
  * Coverage report
* fail if the coverage is bellow some threshold

## Getting Started

* **src:** Script source files
* **tests:** The test files
* **build.sh:** The build script to run the tests

Structure:

```
project/
├── src/
├── test/
│   │── functional-tests.html
│   │── unit-tests.html
└── build.sh
```

### How to use it

Download it; fork or clone it

## Running the tests

Just call:

```bash
./build.sh
```
It will execute all tests inside test dir and generate a coverage report at: ```test/coverage``` folder

## Built With

* [Shunit2](https://github.com/kward/shunit2) - The bash testing framework
* [kcov](https://github.com/SimonKagstrom/kcov) - Code coverage tool for compiled programs, Python and Bash which uses debugging information to collect and report data without special compilation options
* [shellcheck](https://www.shellcheck.net/) - Bash checker

## Authors

* **Anderson Santos** - *Initial work* - [supergarotinho](https://github.com/supergarotinho)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the BSD-3 License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

We use ```koalaman/shellcheck``` image to run shellcheck
