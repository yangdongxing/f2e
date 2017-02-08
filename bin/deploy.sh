echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# commit message
msg="rebuilding site `date`"

if [ $# -eq 1 ]
  then msg="$1"
fi

# update from remote origin
git stash
git fetch --all && git reset --hard gitlab/master
git stash pop

# rebuild
rm -rf public
hugo

# push to gitlab
git add -A
git commit -m "$msg"
git push origin master -f

# push to github
git push origin --delete gh-pages
git subtree push --prefix=public git@github.com:dxy-developer/f2e.git gh-pages -f
