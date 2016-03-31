#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi

git stash
git fetch --all && git reset --hard gitlab/master
git stash pop
rm -rf public

# Build the project.
hugo

# Add changes to git.
git add -A

git commit -m "$msg"

# Push source and build repos.
git push origin master -f
# Push the public subtree to the gh-pages branch
git subtree push --prefix=public git@github.com:dxy-developer/f2e.git gh-pages
