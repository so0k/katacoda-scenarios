echo "Standing up concourse playground"

echo "[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com" > test

# bootstrap concourse workers with access to mock remote repository
curl --connect-timeout 5 \
  --max-time 10 \
  --retry 5 \
  --retry-delay 0 \
  --retry-max-time 40 \
  -Lo docker-compose.yml https://raw.githubusercontent.com/so0k/katacoda-scenarios/master/concourse/03-pipelines/assets/docker-compose.yml
docker-compose up -d > .concourse-up.log &

curl --connect-timeout 5 \
  --max-time 10 \
  --retry 5 \
  --retry-delay 0 \
  --retry-max-time 40 \
  -Lo fly.tar.gz https://github.com/concourse/concourse/releases/download/v5.0.0/fly-5.0.0-linux-amd64.tgz
tar -xzf fly.tar.gz && rm fly.tar.gz
mv fly /usr/local/bin

curl --connect-timeout 5 \
  --max-time 10 \
  --retry 5 \
  --retry-delay 0 \
  --retry-max-time 40 \
  -Lo pipeline.yml https://raw.githubusercontent.com/so0k/katacoda-scenarios/master/concourse/03-pipelines/assets/pipeline.yml


while ! curl -sI http://docker:8080 >/dev/null 2>&1; do echo "Waiting for concourse to be online"; sleep 5; done

echo "Configuring concourse client"
fly -t tutorial login -c http://docker:8080 -u admin -p admin

# provision sample git remotes on docker host
ssh root@host01 "git clone --bare https://github.com/so0k/concourse-git-sample.git /repositories/git-sample.git" </dev/null

# clone sample git repositories to client
git clone http://docker:9080/git-sample.git ~/tutorial/git-sample

echo "Terminal ready to use!"
