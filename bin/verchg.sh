#!/bin/bash

#
# Simple script to update the version in the package.json as well as
# adding a new entry in the CHANGELOG.md for the release notes to be
# added. The arguments to this script are:
#
# $1 = mode (major, minor, patch)
#

#
# This function takes a version number, and the mode to bump it, and
# increments (and resets) the proper components so that the result is
# placed in the variable `new_version` for use by the caller.
#
# $1 = mode (major, minor, patch, push)
# $2 = version (x.y.z)
#
function bump {
  local mode="$1"
  local old="$2"
  # find out the three components of the current version...
  local parts=( ${old//./ } )
  # now bump it up based on the mode...
  case "$1" in
    major|maj)
      local bv=$((parts[0] + 1))
      new_version="${bv}.0.0"
      ;;
    minor|min)
      local bv=$((parts[1] + 1))
      new_version="${parts[0]}.${bv}.0"
      ;;
    bugfix|patch|fix|bug)
      local bv=$((parts[2] + 1))
      new_version="${parts[0]}.${parts[1]}.${bv}"
      ;;
    push|nothing)
      new_version=${old}
      ;;
  esac
}


#
# Function to read the existing package name and version number from the
# package.json, and webpack.config.js file, and populate the following
# variables with these values:
#
# $version = "1.54.3"
# $package = "handbrake"
# $filename = "my-component"
# $module = "my-module"
# $today = "2016 Apr 14"
#
function pull_values {
  package=`grep '"name":' $pkg | sed -e 's/^.*: "//g' -e 's/",$//g'`
  version=`grep '"version":' $pkg | sed -e 's/^.*: "//g' -e 's/",$//g'`
  filename=`grep 'const FILE_NAME' $webpk | sed -e "s/^.* = '//g" -e "s/';//g"`
  module=`grep 'const MODULE_NAME' $webpk | sed -e "s/^.* = '//g" -e "s/';//g"`
  today=$(date +"%Y %b %-d")
}


#
# Function to update the package.json file with the new version by a
# simple exchange.
#
function update_code {
  sed -e "1s/${version}/${new_version}/" ${pkg} > p.tmp && mv p.tmp ${pkg}
}


#
# Function to update the CHANGELOG.md file to add in the new template
# for the release notes.
#
function update_docs {
  sed -e "s/\${NAME}/$package/g" \
	  -e "s/\${VER}/$new_version/g" \
    -e "s/\${FILE_NAME}/$filename/g" \
    -e "s/\${MODULE_NAME}/$module/g" \
	  -e "s/\${DATE}/$today/g" $style | cat - $log > cl.tmp && mv cl.tmp $log
}

#
# Set up the defaults for the script
#
pkg="package.json"
webpk="webpack.config.js"
log="CHANGELOG.md"
style="doc/templates/changelog_entry.md"

# run through all the steps to get the job done.
pull_values
bump $1 ${version}
update_code
update_docs
echo "Project is now at ${new_version}"
