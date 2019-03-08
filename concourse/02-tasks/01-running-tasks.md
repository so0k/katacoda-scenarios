A basic Hello World task has been created for you. To run tasks directly from the command line use the following command:

```
fly -t tutorial execute -c task_hello_world.yml
```{{execute terminal}}

Every task in Concourse runs within a "container" (as best available on the target platform). The `task_hello_world.yml` configuration shows that we are running on a `linux` platform using the `busybox` container image. You will see it downloading a Docker image `busybox`. It will only need to do this once; though will recheck every time that it has the latest `busybox` image.

Within this container it will run the command `echo hello world`.

You may see the task status via [http://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/builds/1](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/builds/1)

We will dive deeper into the configuration of a task in the next step
