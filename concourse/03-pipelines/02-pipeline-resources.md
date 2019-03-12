Resources are the heart and soul of Concourse. They represent all external inputs to and outputs of jobs in the pipeline and define methods of periodically checking the external input for changes. As such resources have an `in` method to defining how external data is fetched, an `out` method for publishing the data and a `check` method to periodically check the external data for changes.

Resources are listed under the `resources:` key in the pipeline configuration.

Resources have 2 mandatory fields:
- `name`: short and simple, will be referenced by build plans of jobs in the pipeline
- `type`: determines how the pipeline interacts with external resources. Out of the box, Concourse comes with a few ["base" resource types](https://concourse-ci.org/included-resource-types.html) to cover common CI use cases like dealing with Git repositories and S3 buckets. Beyond these core types, each pipeline can configure its own resource types by specifying the top level `resource_types` key see [using resource types](https://concourse-ci.org/resource-types.html).

As part of this tutorial environment, our concourse workers have access to a `git-sample` git repository at `http://git-server:8080/git-sample.git`

To pull in the Git repository into the pipeline, we edit `pipeline.yml`{{open}} and add a top-level section `resources`:

<pre class="file" data-filename="pipeline.yml" data-target="prepend">resources:
- name: resource-git-sample
  type: git
  source:
    uri: http://git-server:8080/git-sample.git
    branch: master
</pre>

Our pipeline consists of `jobs` and each job has a single build plan. A build `plan` is a sequence of `steps` to execute.

The 3 basic types of `step` are:
- `get`: Get a resource defined in the `resoures:` key and make it available to subsequent steps via the given name. These `get` steps can trigger the job plan when its resource check determines it. The flag to control this is `trigger` and it is `false` by default.
- `task`: Execute a task
- `put`: Pushes to the given resource. All artifacts collected during the plan's execution will be available in the working directory.

These steps may fetch down or update Resources, or execute Tasks. Once the resource has been defined, we can use it in our job steps

We add this `get` step to our job plan, making our final pipeline become this: 

<pre class="file" data-filename="pipeline.yml" data-target="replace">resources:
- name: resource-git-sample
  type: git
  source:
    uri: http://git-server:8080/git-sample.git
    branch: master

jobs:
- name: job-hello-world
  public: true
  plan:
  - get: resource-git-sample # get external git resource
  - task: hello-world
    config:
      platform: linux
      image_resource:
        type: registry-image
        source: {repository: busybox}
      run:
        path: ls
        args: ['-alR']
</pre>

Apply the changes with the `set-pipeline` command:

```
fly -t tutorial sp -p hello-world -c pipeline.yml
```{{execute}}

Notice the clear overview of changes we made to the pipeline

```
apply configuration? [yN]:
```

Press `y`

Force a resource check (alias `cr`) for the git resource to validate the configuration:

```
fly -t tutorial cr -r hello-world/resource-git-sample
```{{execute}}

And test the pipeline by triggering the job and watching the output

```
fly -t tutorial tj -j hello-world/job-hello-world -w
```{{execute}}

**Question: Did the `resource-git-sample` show up in the task directory listing?**

If not, can you think of a reason why and the way to fix it?
