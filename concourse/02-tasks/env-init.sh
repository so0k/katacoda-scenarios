echo "Standing up concourse playground"
curl -Lo docker-compose.yml https://raw.githubusercontent.com/so0k/katacoda-scenarios/master/concourse/02-tasks/assets/docker-compose.yml
docker-compose up -d

curl -Lo fly.tar.gz https://github.com/concourse/concourse/releases/download/v5.0.0/fly-5.0.0-linux-amd64.tgz
tar -xzf fly.tar.gz && rm fly.tar.gz
mv fly /usr/local/bin

while ! curl -sI http://docker:8080 >/dev/null 2>&1; do echo "Waiting for concourse to be online"; sleep 1; done

echo "Configuring concourse client"
set -x
fly -t tutorial login -c http://docker:8080 -u admin -p admin

set +x
