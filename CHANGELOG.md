# BAS Base Project (Pristine) - Base Flavour - Change log

All notable changes to this project will be documented in this file.
This role adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased][unreleased]

### Added

* Missing git ignore entry for Ansible playbook retry files

### Fixed

* Removing project specific handlers, which were accidentally included
* Removing leading white-space in README
* Renaming Terraform dynamic inventory to specify the environment, to allow other Terraform managed environments to be
supported

### Removed

* Unused rsync based production deployment strategy

## 0.3.0 - 04/07/2016

### Added

* A migration guide now documents how to move between versions of this project
* BARC user groups Ansible role

### Fixed

* Fixing typo in name of templated change log file
* Fixing broken Vagrant Ansible dynamic inventory where Vagrant machines are not running

### Changed

* Updated production environment provisioning to use updated BAS AWS remote state and outputs
* Updated Ansible roles to latest versions to address Ansible 2.0 compatibility

## 0.2.0 - 13/06/2016

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

### Changed

* Updating dynamic inventories to remove debug code and improve stability
* Updating production environment Terraform configuration to follow BAS-AWS project conventions

### Removed

* Removing references to the BAS Systems Inventory - this will be added back once it has been further developed

## 0.1.0 - 07/03/2016

### Added

* Initial version based on an earlier 'Web-Applications-Project-Template'
