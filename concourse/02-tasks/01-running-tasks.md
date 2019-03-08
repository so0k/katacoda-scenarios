Every task in Concourse runs within a "container" (as best available on the target platform). 

The `task_hello_world.yml`{{open}} configuration shows that we are running on a `linux` platform using the `busybox` container image. You will see it downloading a Docker image `busybox`. It will only need to do this once; though will recheck every time that it has the latest `busybox` image.

Using the basic Hello World task, run it directly from the command line with the following command:

```
fly -t tutorial execute -c task_hello_world.yml
```{{execute}}

The task will run the command `echo hello world` within this container.

We will dive deeper into the configuration of a task in next.
