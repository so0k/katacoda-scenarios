echo "Standing up concourse playground"
curl -Lo docker-compose.yml https://raw.githubusercontent.com/so0k/katacoda-scenarios/master/concourse/02-tasks/assets/docker-compose.yml
docker-compose up -d > .concourse-up.log &

curl --connect-timeout 5 \
  --max-time 10 \
  --retry 5 \
  --retry-delay 0 \
  --retry-max-time 40 \
  -Lo fly.tar.gz https://github.com/concourse/concourse/releases/download/v5.0.0/fly-5.0.0-linux-amd64.tgz
  
tar -xzf fly.tar.gz && rm fly.tar.gz
mv fly /usr/local/bin

# provision step 1 sample task
curl --connect-timeout 5 \
  --max-time 10 \
  --retry 5 \
  --retry-delay 0 \
  --retry-max-time 40 \
  -Lo task_hello_world.yml https://raw.githubusercontent.com/so0k/katacoda-scenarios/master/concourse/02-tasks/assets/task_hello_world.yml

# provision simple input directory for step 3
mkdir -p task-scripts
curl --connect-timeout 5 \
  --max-time 10 \
  --retry 5 \
  --retry-delay 0 \
  --retry-max-time 40 \
  -Lo task-scripts/task_show_uname.sh https://raw.githubusercontent.com/so0k/katacoda-scenarios/master/concourse/02-tasks/assets/task_show_uname.sh

chmod +x task-scripts/task_show_uname.sh

while ! curl -sI http://docker:8080 >/dev/null 2>&1; do echo "Waiting for concourse to be online"; sleep 5; done

echo "Configuring concourse client"
fly -t tutorial login -c http://docker:8080 -u admin -p admin

echo "Terminal ready to use!"
