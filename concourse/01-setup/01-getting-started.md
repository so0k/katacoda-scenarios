
To run Concourse we need postgres and some basic configuration, we can launch both using the `docker-compose` file provided and docker-compose commands further down below.

Refer to the Docker courses to learn more about Docker.

For the purpose of this scenario, we need to provide concourse with a valid external URL of this learning environment:

```
echo "CONCOURSE_EXTERNAL_URL=https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com" >> concourse.env
```{{execute}}

You may review the configuration used here:

```
cat concourse.env
```{{execute}}

Next, stand up both Postgres and Concourse in quickstart mode with:

```
docker-compose up -d
```{{execute}}

Wait for compose to pull the docker images and stand up the database as well as the concourse UI / scheduler and workers.

```shell
...
Status: Downloaded newer image for postgres:latest
Pulling concourse (concourse/concourse:5.0.0)...
5.0.0: Pulling from concourse/concourse
6cf436f81810: Pull complete
987088a85b96: Pull complete
b4624b3efe06: Extracting [==================================================>]     516B/516B
d42beb8ded59: Download complete
f51b97ce0afa: Download complete
b2b35a4bcc62: Downloading [==========>                                        ]  115.5MB/532.4MB
```

After the compose process finished, it may still take a minute for the concourse dashboard to appear in the upper frame.

If the terminal is available, let's download the command line client while waiting for the UI:

```
curl -Lo fly.tar.gz https://github.com/concourse/concourse/releases/download/v5.0.0/fly-5.0.0-linux-amd64.tgz
```{{execute}}

Extract

```
tar -xzf fly.tar.gz && rm fly.tar.gz
```{{execute}}

And put under `/usr/local/bin` which is by default on `$PATH`

```
mv fly /usr/local/bin/
```{{execute}}

If the dashboard became available, use the following credentials to log in with a local user (as you may have guessed from reviewing the `concourse.env` file earlier):

- User: `admin`{{copy}}
- Password: `admin`{{copy}}

For more advance configuration of authentication with identity providers such as GitHub, GitLab, BitBucket, LDAP or generic OIDC ...  refer to the [Authentication](https://concourse-ci.org/configuring-auth.html) documentation which is out of scope for this course.

Next we will configure our command line client to work with our local concourse instance.
