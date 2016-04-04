
# £PROJECT-TITLE-CASE

£PROJECT-ONE-LINE-DESCRIPTION

**This project uses version £PRISTINE-VERSION of the £PRISTINE-FLAVOUR flavour of the BAS Base Project - Pristine**.

**This project is tracked in the BAS Systems Inventory.**
See the *BAS Systems Inventory* section for more information.

## Overview

* ...

## BAS Systems Inventory

This project is tracked in the BAS Systems Inventory as: **£BSI-SYSTEM-ID**.

THe Systems Inventory provides more information on the background of this project,
its intended users and who is responsible for it.

It also lists the environments (instances) this project is used in and the resources which make up these environments.

## Setup

To bring up a local development environment:

1. Ensure you meet all the
[requirements](https://paper.dropbox.com/doc/BAS-Base-Project-Pristine-Base-Flavour-Usage-ZdMdHHzf8xB4HjxcNuDXa#:h=Environment---local-developmen)
to bring up a local development environment
2. Checkout this project locally `$ git clone £PROJECT-REPOSITORY`
3. `$ cd £PROJECT-LOWER-CASE/provisioning/site-development-local`
4. `$ vagrant up`
5. `$ cd ..`
6. `$ ansible-playbook site-development-local.yml`

To bring up the production environment:

1. Ensure you meet all the
[requirements](https://paper.dropbox.com/doc/BAS-Base-Project-Pristine-Base-Flavour-Usage-ZdMdHHzf8xB4HjxcNuDXa#:h=Environment---production)
to bring up a production environment
2. Checkout this project locally `$ git clone £PROJECT-REPOSITORY`
3. `$ cd £PROJECT-LOWER-CASE/provisioning/site-production`
4. `$ terraform plan`
5. `$ terraform apply`
6. `$ cd ..`
7. `$ ansible-playbook site-production.yml`
8. Commit Terraform state to project repository

## Usage

To deploy changes to a local development environment:

* No action is needed as the project is mounted within the local virtual machine

To deploy changes to a production environment:

1. Commit project changes to project repository
2. `$ ansible-playbook app-deploy-production.yml`

## Developing

### Version control

This project uses version control. The project repository is located at:
`£PROJECT-REPOSITORY`

Write access to this repository is restricted. Contact the project maintainer to request access.

### Tests

This project uses manual testing only.

## Feedback

The maintainer of this project is £MAINTAINER-DESCRIPTION, they can be contacted at: £MAINTAINER-EMAIL.

This uses issue tracking for feedback. The project issue tracker is located at:
`£PROJECT-ISSUE-TRACKER`

## Licence

Copyright 2016 NERC BAS.

Unless stated otherwise, all documentation is licensed under the Open Government License - version 3.
All code is licensed under the MIT license.

Copies of these licenses are included within this project.
