echo "Standing up concourse playground"
docker-compose up -d

echo "Waiting for concourse server"
curl --connect-timeout 5 \
  --max-time 10 \
  --retry 5 \
  --retry-connrefuse \
  --retry-delay 0 \
  --retry-max-time 40  \
  -so fly http://docker:8080/api/v1/cli?arch=amd64&platform=linux

chmod +x fly
mv fly /usr/local/bin

echo "Configuring concourse client"
set -x
fly -t tutorial login -c http://docker:8080 -u admin -p admin

set +x
