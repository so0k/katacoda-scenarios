Create a new task configuration via the CLI: `touch task_ubuntu_ls.yml`{{execute}}

Open the file: `task_ubuntu_ls.yml`{{open}}

First we need to specify the `platform` which is required and determines the pool of workers the task can run against. The base deployment provides Linux workers. Traditionally other options are `windows` or `darwin` depending on your workers available.

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="replace">---
platform: linux
</pre>

Next we define the base image for the containerized workspace the task will run in. This is done through the `image_resource` configuration. 

Defining the base image allows your task to have any prepared dependencies that it needs to run pre-baked instead of installing dependencies each time running a task, thus making your tasks run faster.

The `image_resource` configuration field only requires `type` and `source` fields. As for the underlying system preparing the task execution environment, concourse has very [basic requirements](https://concourse-ci.org/tasks.html#task-image-resource) and the reference implementation is the [`registry-image`](https://github.com/concourse/registry-image-resource) (a newer version of [`docker-image`](https://github.com/concourse/docker-image-resource)).

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="append">
image_resource:
  type: registry-image
  source:</pre>

The `registry-image` resource type only requires the `repository` to be specified, the `tag` is optional and is `latest` by default. A future scenario will look into building and using your own Docker images. For this exercise we will use the `ubuntu` docker image readily available from the [Docker Hub](https://hub.docker.com/_/ubuntu):

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="append">    repository: ubuntu
</pre>

Finally we define the command to execute in the container using the `run` configuration. Only `path` is required (commonly a script or command) a string array of arguments is optionally provided through `args`.

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="append">
run:
  path: ls
  args:
  - "-alR"
</pre>

Run this task as follows:

```
fly -t tutorial e -c task_ubuntu_ls.yml
```{{execute}}

Note: `e` is the alias for `execute`
