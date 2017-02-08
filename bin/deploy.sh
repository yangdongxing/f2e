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

# test



# Push source and build repos.
git push origin master -f
# Push the public subtree to the gh-pages branch
# git subtree push --prefix=public git@github.com:dxy-developer/f2e.git gh-pages

# 貌似搞得太复杂了，不会解决冲突问题.. 直接删除从来
git push origin --delete gh-pages
git subtree push --prefix=public git@github.com:dxy-developer/f2e.git gh-pages