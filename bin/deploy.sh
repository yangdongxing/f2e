# #!/bin/bash

# echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# commit message
msg="rebuilding site `date`"

if [ $# -eq 1 ]
  then msg="$1"
fi

# # update from remote origin
# git stash
# git fetch --all && git reset --hard gitlab/master
# git stash pop

# # rebuild
# rm -rf public
# hugo

# # push to gitlab
# git add -A
# git commit -m "$msg"
# git push origin master -f

# # push to github
# git push origin --delete gh-pages
# git subtree add --prefix=public git@github.com:dxy-developer/f2e.git gh-pages --squash
# git subtree push --prefix=public git@github.com:dxy-developer/f2e.git gh-pages


# Remove the public folder to make room for the gh-pages subtree
rm -rf public

# Add the gh-pages branch of the repository. It will look like a folder named public
git subtree add --prefix=public git@github.com:dxy-developer/f2e.git gh-pages --squash

# Pull down the file we just committed. This helps avoid merge conflicts
git subtree pull --prefix=public git@github.com:dxy-developer/f2e.git gh-pages

# Run hugo. Generated site will be placed in public directory (or omit -t ThemeName if you're not using a theme)
hugo

# Add everything
git add -A

# Commit and push to master
git commit -m "$msg" && git push origin master

# Push the public subtree to the gh-pages branch
git subtree push --prefix=public git@github.com:dxy-developer/f2e.git gh-pages