#!/usr/bin/env bash -e

# Colours for output formatting
FGYellow='\e[33m'
FGGreen='\e[32m'
FGBlue='\e[34m'
FGRed='\e[31m'
FGreset='\e[39m'

# Confirmation check function - exists script if answered in the negative
function confirm () {
    # call with a prompt string or use a default
    read -r -p "? > Are you ready? [y/N] " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            exit 2
            ;;
    esac
}

# Boolean conversion function - takes y/n, Y/N, yes/no, Yes/No, YES/NO, answers and gives a boolean value - or exits
function boolean() {
  case $1 in
    y) echo true ;;
    Y) echo true ;;
    yes) echo true ;;
    Yes) echo true ;;
    YES) echo true ;;
    n) echo false ;;
    N) echo false ;;
    no) echo false ;;
    No) echo false ;;
    NO) echo false ;;
    *) echo "Err: Unknown boolean value \"$1\"" 1>&2; exit 2 ;;
   esac
}

# Introduction
printf "\n"
printf "${FGBlue}BAS Base Project (Pristine) - Base Flavour - Setup Script${FGreset}\n"
printf "\n"
printf "  This script will:\n"
printf "  + Remove origin project Git repository and init a new repository\n"
printf "  + Add an .gitignore entry for the setup script to prevent including in initial commits\n"
printf "  + Remove origin README and CHANGELOG and rename templates for these to replace them\n"
printf "  + Perform global find and replace operations\n"
printf "  + Commit changes to repository and create and checkout a develop branch\n"
printf "  + Delete this setup script\n"
printf "\n"
printf "  This script will NOT:\n"
printf "  - Perform find and replacements on '...' items\n"
printf "\n"
printf "  Notes:\n"
printf "  * This script is not designed as a robust or flexible solution - it is an aid only\n"
printf "  * This script is a prototype - please report bugs\n"
printf "  * This is useful for escaping URLs: 'http://www.freeformatter.com/javascript-escape.html'\n"
printf "\n"
printf "  Requirements:\n"
printf "  * Git\n"
printf "  * Find (likely installed)\n"
printf "  * Sed (likely installed)\n"
printf "\n"
printf "${FGYellow}  If you have not used this script before you *MUST* read the project README first!${FGreset} \n"

# Systems check
printf "\n"
printf "${FGBlue}== Systems check${FGreset}\n"

printf "\n"
if command -v git >/dev/null 2>&1; then
    printf "${FGGreen}<>${FGreset} 'git' command found\n"
else
    { printf >&2 "${FGRed}><${FGreset} 'git' command not found - aborting!\n"; exit 1; }
fi
printf "\n"
if command -v find >/dev/null 2>&1; then
    printf "${FGGreen}<>${FGreset} 'find' command found\n"
else
    { printf >&2 "${FGRed}><${FGreset} 'find' command not found - aborting!\n"; exit 1; }
fi
printf "\n"
if command -v sed >/dev/null 2>&1; then
    printf "${FGGreen}<>${FGreset} 'sed' command found\n"
else
    { printf >&2 "${FGRed}><${FGreset} 'sed' command not found - aborting!\n"; exit 1; }
fi

printf "\n"
printf "${FGGreen}All Systems Go!${FGreset}\n"

# Clean up old and setup new git repository in project
printf "\n"
printf "${FGBlue}== Git repository${FGreset}\n"

printf "\n"
printf "  This script will call 'rm -rf' with a relative path as:\n"
printf "  $ rm -rf .git"
printf "\n"
printf "  The current working directory is:\n"
pwd
printf "\n"
printf "${FGYellow}For safety, you need to confirm this action${FGreset}\n"
confirm

printf "\n"
rm -rf .git
printf "${FGGreen}<>${FGreset} old Git repository removed\n"

printf "\n"
git init
printf "${FGGreen}<>${FGreset} new Git repository created\n"

printf "\n" >> ./.gitignore
printf "# Pristine setup script\n" >> ./.gitignore
printf "setup.sh\n" >> ./.gitignore
printf "\n"
printf "${FGGreen}<>${FGreset} added temporary .gitignore entry for setup script\n"

printf "\n"
printf "${FGGreen}Git repository sorted${FGreset}\n"

# Clean up old and setup new README and CHANGELOG in project
printf "\n"
printf "${FGBlue}== README and CHANGELOG setup${FGreset}\n"

printf "\n"
rm ./README.md
mv ./README.template.md ./README.md
printf "${FGGreen}<>${FGreset} README sorted\n"

printf "\n"
rm ./CHANGELOG.md
mv ./CHANGELOG.template.md ./CHANAGELOG.md
printf "${FGGreen}<>${FGreset} README sorted\n"

printf "\n"
printf "${FGGreen}README and CHANGELOG sorted${FGreset}\n"

# Find and replace tasks
printf "\n"
printf "${FGBlue}== Find and Replace${FGreset}\n"
printf "\n"

printf "\n"

read -r -p "? [01/10] > Which version of Pristine are you using? " VAR_pristine_version
read -r -p "? [02/10] > Which flavour of Pristine are you using? " VAR_pristine_flavour
read -r -p "? [03/10] > What's a one line description for this project? " VAR_project_oneline
read -r -p "? [04/10] > What's the name of this project in snake case (like-this)? " VAR_project_name_lower
read -r -p "? [05/10] > What's the name of this project in title case (Like This)? " VAR_project_name_title
read -r -p "? [06/10] > What's the email address of the maintainer of this project? " VAR_project_maintainer_name
read -r -p "? [07/10] > What's the description for the maintainer of this project (e.g. Name or Team)? " VAR_project_maintainer_description
read -r -p "? [08/10] > What's the URL for the repository for this project? (Escape slashes!) " VAR_project_repo
read -r -p "? [09/10] > What's the URL for the issue tracker for this project? (Escape slashes!) " VAR_project_issues
read -r -p "? [10/10] > What's the ID of the system this project is associated with in the BAS Systems Inventory? " VAR_project_bassys

printf "\n"

printf "\n"
printf "${FGYellow}Answer no if you aren't happy with any of your answers?${FGreset}\n"
confirm

mv ./provisioning/group_vars/project--£PROJECT-LOWER-CASE.yml ./provisioning/group_vars/project--$VAR_project_name_lower.yml

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£PRISTINE-VERSION/$VAR_pristine_version/g" {} +
printf "${FGGreen}<>${FGreset} [01/10] Pristine version set\n"

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£PRISTINE-FLAVOUR/$VAR_pristine_flavour/g" {} +
printf "${FGGreen}<>${FGreset} [02/10] Pristine flavour set\n"

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£PROJECT-ONE-LINE-DESCRIPTION/$VAR_project_oneline/" {} +
printf "${FGGreen}<>${FGreset} [03/10] Project one-line description set\n"

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£PROJECT-LOWER-CASE/$VAR_project_name_lower/g" {} +
printf "${FGGreen}<>${FGreset} [04/10] Project name (snake-case) set\n"

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£PROJECT-TITLE-CASE/$VAR_project_name_title/g" {} +
printf "${FGGreen}<>${FGreset} [05/10] Project name (title case) set\n"

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£MAINTAINER-EMAIL/$VAR_project_maintainer_name/g" {} +
printf "${FGGreen}<>${FGreset} [06/10] Project maintainer (name) set\n"

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£MAINTAINER-DESCRIPTION/$VAR_project_maintainer_description/g" {} +
printf "${FGGreen}<>${FGreset} [07/10] Project maintainer (description) set\n"

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£PROJECT-REPOSITORY/$VAR_project_repo/g" {} +
printf "${FGGreen}<>${FGreset} [08/10] Project repository set\n"

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£PROJECT-ISSUE-TRACKER/$VAR_project_issues/g" {} +
printf "${FGGreen}<>${FGreset} [09/10] Project issue tracker set\n"

printf "\n"
LC_ALL=C find . -type f -exec sed -i '' -e "s/£BSI-System-ID/$VAR_project_bassys/g" {} +
printf "${FGGreen}<>${FGreset} [10/10] BAS Systems Inventory system association set\n"

printf "\n"
printf "${FGGreen}Find and replace's sorted${FGreset}\n"

# Make initial commit and create develop branch
printf "\n"
printf "${FGBlue}== Make initial commit and create develop branch${FGreset}\n"

printf "\n"
git add --all
git commit -m "Initial commit - auto-generated by Pristine setup script"
printf "${FGGreen}<>${FGreset} initial commit done\n"

printf "\n"
git checkout -b develop
printf "${FGGreen}<>${FGreset} Develop branch made and checked out\n"

printf "\n"
printf "${FGGreen}Initial commit complete${FGreset}\n"

# Finish by deleting this script
printf "\n"
printf "${FGBlue}== Clean up setup script${FGreset}\n"

printf "\n"
rm ./setup.sh
printf "${FGGreen}<>${FGreset} Setup script removed\n"

printf "\n"
sed -i '' -e '$ d' ./.gitignore
sed -i '' -e '$ d' ./.gitignore
sed -i '' -e '$ d' ./.gitignore
printf "${FGGreen}<>${FGreset} removing temporary .gitignore entry for setup script\n"

printf "\n"
printf "${FGGreen}All done - bye bye${FGreset}\n"
