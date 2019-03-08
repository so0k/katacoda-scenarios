Every task in Concourse runs within a "container" (as best available on the target platform). 

The `task_hello_world.yml`{{open}} (click to open) configuration defines a task for the `linux` platform which uses the `busybox` container image to provide the filesystem and dependencies for the task (busybox being a minimal linux distribution of only 4Mb).

When executed, you will see it downloading this `busybox` Docker image. It will only need to do download this base image once; though will recheck every time that the concourse worker running the task has the latest `busybox` image available prior to executing the task.

As soon as our local concourse instance is online, run `task_hello_world.yml` directly from the command line with the following `fly` command:

```
fly -t tutorial execute -c task_hello_world.yml
```{{execute}}

The task will run the command `echo hello world` within the `busybox` container.

Notice that consecutive runs of the task configurations using the same `busybox` image execute faster

```
fly -t tutorial execute -c task_hello_world.yml
```{{execute}}

We will dive deeper into the configuration of a task in next.
