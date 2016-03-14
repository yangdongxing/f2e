#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi

# Push Hugo content
git add -A
git commit -m '$msg'
git push origin master

rm -rf public
# Build the project.
hugo

# Add changes to git.
git add -A

git commit -m "$msg"

# Push the public subtree to the gh-pages branch
git subtree push --prefix=public git@github.com:dxy-developer/f2e.git gh-pages
