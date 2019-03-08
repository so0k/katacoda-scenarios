echo "Standing up concourse playground"

# provision mock git remote
mkdir -p /mock/remote/sample
git clone --bare https://github.com/so0k/concourse-git-sample.git /mock/remote/git-sample
git clone /mock/remote/git-sample ~/tutorial/git-sample

# bootstrap concourse workers with access to mock remote repository
curl -Lo docker-compose.yml https://raw.githubusercontent.com/so0k/katacoda-scenarios/master/concourse/03-pipelines/assets/docker-compose.yml
docker-compose up -d > .concourse-up.log &

curl -Lo fly.tar.gz https://github.com/concourse/concourse/releases/download/v5.0.0/fly-5.0.0-linux-amd64.tgz
tar -xzf fly.tar.gz && rm fly.tar.gz
mv fly /usr/local/bin


curl -Lo pipeline.yml https://raw.githubusercontent.com/so0k/katacoda-scenarios/master/concourse/03-pipelines/assets/pipeline.yml

# provision simple input directory for step 3
mkdir -p task-scripts
cat << EOF > task-scripts/task_show_uname.sh
#!/bin/sh

uname -a
EOF
chmod +x task-scripts/ls.sh

while ! curl -sI http://docker:8080 >/dev/null 2>&1; do echo "Waiting for concourse to be online"; sleep 5; done

echo "Configuring concourse client"
fly -t tutorial login -c http://docker:8080 -u admin -p admin

echo "Terminal ready to use!"
