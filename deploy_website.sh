#!/bin/bash

set -e # stop the script on errors
set -o pipefail # piping a failed process into a successful one is an error

rsync --exclude='.git/' --exclude='nm*.csv.gz' -az --compress-level=9 --stats -e 'ssh  -o StrictHostKeyChecking=no -i /root/.ssh/crimenmexico' --delete /root/new.crimenmexico  crimenmexico@"$IPADDRESS":/home/crimenmexico
# copy the csv.gz files to data.diegovalle.net
rsync --omit-dir-times -rz --compress-level=9 --stats -e 'ssh  -o StrictHostKeyChecking=no -i /root/.ssh/crimenmexico' /root/new.crimenmexico/data/  crimenmexico@"$IPADDRESS":/var/www/data.diegovalle.net/elcrimen

# Commit generated infographics
if [[ $(git status --porcelain elcri.men/static/e*) ]]; then
    git config --global user.email "$GITHUB_EMAIL"
    git config --global user.name "diego"
    git status --porcelain elcri.men/static/e* | sed  "s/^?? //g" | xargs --max-args 1 git add
    git commit -m "Add new png infographics [Skip CI]"
    git push -q https://"$GITHUB_TOKEN":x-oauth-basic@github.com/diegovalle/new.crimenmexico.git master
fi

#DATE=$(date +%Y-%m-%d-%H-%Z)
#LATEST_RELEASE=/var/www/bcrimenmexico.diegovalle.net/$DATE
#CURRENT_PATH=/var/www/elcri.men/public
#CURRENT_PATH_TMP=/var/www/bcrimenmexico.diegovalle.net/$DATE.tmp
#ssh -i /root/.ssh/crimenmexico crimenmexico@"$IPADDRESS" "mkdir -p $LATEST_RELEASE && cp -r /home/crimenmexico/new.crimenmexico/crimenmexico.diegovalle.net/* $LATEST_RELEASE && ln -s $LATEST_RELEASE $CURRENT_PATH_TMP && mv -T $CURRENT_PATH_TMP $CURRENT_PATH"

(cd ~/new.crimenmexico/elcri.men/public && netlify deploy --auth="$NETLIFYAPIKEY" --site=b399b452-d320-4949-8c4d-f32ea339db82 --dir=. --prod)
