## Single Setup Script

### Running with Git

    git clone https://github.com/donnemartin/dev-setup.git && cd dev-setup

Run the dots Script with Command Line Arguments

Since you probably don't want to install every section, the dots script supports command line arguments to run only specified sections. Simply pass in the scripts that you want to install. Below are some examples.

For more customization, you can clone or fork the repo and tweak the dots script and its associated components to suit your needs.

Run all:

    ./dots all

Run bootstrap.sh, osxprep.sh, brew.sh, and osx.sh:

    curl -O https://raw.githubusercontent.com/markbahnman/dev-setup/master/dots && /dots [Add ARGS Here]
