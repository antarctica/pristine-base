# BAS Base Project (Pristine) - Base Flavour - Change log

All notable changes to this project will be documented in this file.
This role adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased][unreleased]

### Changed - BREAKING!

* `files/certificates` removed as this pre-deposes a project to using TLS certificates - see the Web BARC flavour if 
this is needed

### Added

* Setup script to automate setting up new instances of this project template
* Template `README` and `CHANGELOG`, which were previously tracked as documentation appendices

## Fixed

* Local development playbooks insufficiently specified that they are for 'local development', not 'development'
* GitHub language statistics now ignore provisioning files
### Removed

* Terraform state files to ensure new projects start with a blank state and won't track unrelated infrastructure

## 0.1.0 - 07/03/2016

### Added

* Initial version based on an earlier 'Web-Applications-Project-Template'
