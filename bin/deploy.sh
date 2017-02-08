# #!/bin/bash

echo -e "\033[0;32mpublish to gitHub...\033[0m"

# commit message
msg="rebuilding site `date`"

if [ $# -eq 1 ]
  then msg="$1"
fi

# push to gitlab
git add -A

git commit -m "$msg" && git push origin master

# build
rm -rf public

hugo

# push to github
cd public

git init

git remote add origin git@github.com:dxy-developer/f2e.git

git add -A

git commit -m "build success"

git push origin master:gh-pages --force