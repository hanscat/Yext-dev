#!/bin/bash
echo "Please specify your absolute repo path under home directory (i.e. 'repos' for '~/repos'; default 'repos')->"
read path

echo -e "Please enter the repo link ->"
read store

echo -e "-> cloning repo '$store'"
if
  [[ $path = "" ]]
then
  cd ~/repos && git clone $store || { echo "repo not exist"; exit 1; }
else
  echo
  echo "This is path"
  echo $path
  cd ~/$path && git clone $store || { echo "repo not exist"; exit 1; }
fi

echo -e "-> Opening repo in SourceTree"
re="([^/]+)\.([^/]+)\.com"
if
  [[ $store =~ $re ]];
then
  open -a SourceTree ~/repos/${BASH_REMATCH} && echo -e "-> Opening project in atom" && atom ~/repos/${BASH_REMATCH} && echo -e "-> cd into /src" && cd ~/repos/${BASH_REMATCH}/src && echo -e "-> pull develop and master branches" && git checkout --track origin/develop > /dev/null || echo -e "develop branch already pulled" && git checkout --track origin/master > /dev/null || echo -e "master branch already pulled" && echo -e "please enter your feature name->" && read feature && git flow init && git flow feature start $feature && echo -e "feature branch created, now begin yarn && bower install" && yarn && bower install && open -a Terminal "`cd ~/repos/${BASH_REMATCH}/src`" && open -a Terminal "`cd ~/repos/${BASH_REMATCH}`" ;
else
  echo "no matching repo"
  exit 1
fi


echo -e "preparation finished!"
