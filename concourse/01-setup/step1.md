To run Concourse we need postgres and some basic configuration, we can launch both using the `docker-compose` file provided and docker-compose command.

Refer to the Docker courses to learn more about Docker.

You should see postgres and concourse being started using `docker-compose up -d`{{execute terminal}}

After a while, you should see the concourse dashboard in the upper frame.

You may log in with:

User: `admin`{{copy}}
Password: `admin`{{copy}}

Download the command line client:

```
curl -Lo fly http://localhost:8080/api/v1/cli?arch=amd64&platform=linux
```{{execute}}

Make it executable

```
chmod +x fly
```{{execute}}

And put it on the PATH

```
mv fly ~/usr/local/bin/
```{{execute}}

Next we will configure our command line client.
