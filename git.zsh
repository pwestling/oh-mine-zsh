
track-remote () {
  git branch --track $1 origin/$1
}

git-owned-lines () {
  git ls-tree -r -z --name-only HEAD | xargs -0 -n1 git blame \
  --line-porcelain HEAD |grep  "^author "|sort|uniq -c|sort -nr
}

git-changed-lines () {
  git log --author="$1" --pretty=tformat: --numstat | awk -v name=$1 '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "%s added lines: %s, removed lines: %s, total lines: %s\n", name, add, subs, loc }' -
}

git-owned-commits () {
  git shortlog -sne
}

git-clean-branches () {
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

github-remote(){
  git remote rm origin
  git remote add origin git@github.com:LiveRamp/$(basename $(pwd)).git
}
