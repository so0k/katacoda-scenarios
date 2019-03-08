
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

After a while (may take up to 5 minutes), you should see the concourse dashboard appear in the upper frame.

In the mean time let's download the command line client:

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
