
To run Concourse we need postgres and some basic configuration, we can launch both using the `docker-compose` file provided and docker-compose command below.

Refer to the Docker courses to learn more about Docker.

For the purpose of this scenario, we need to provide the concourse with a valid external URL of this learning environment:

```
echo "CONCOURSE_EXTERNAL_URL=https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com" >> concourse.env
```{{execute}}

Next, stand up both Postgres and Concourse in quickstart mode with:

```
docker-compose up -d
```{{execute}}

You may review the configuration used here:

```
cat concourse.env
```{{execute}}

After a while, you should see the concourse dashboard appear in the upper frame.

You may log in with:

- User: `admin`{{copy}}
- Password: `admin`{{copy}}

Download the command line client:

```
curl -Lo fly.tar.gz https://github.com/concourse/concourse/releases/download/v5.0.0/fly-5.0.0-linux-amd64.tgz
```{{execute}}

Make it executable

```
tar -xzf fly.tar.gz && rm fly.tar.gz
```{{execute}}

And put it on the PATH

```
mv fly /usr/local/bin/
```{{execute}}

Next we will configure our command line client.
