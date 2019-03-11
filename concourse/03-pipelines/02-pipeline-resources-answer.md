The `resource-git-sample` resource was not available to the task as it was not defined as an input to the task. To fix this we need to define the inputs for our task configuration.

Add the `inputs` key to the task configuration, making our final pipeline become this:

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
      inputs:
      - name: resource-git-sample # use the external git resource
      run:
        path: ls
        args: ['-alR']
</pre>

Apply the changes with the `set-pipeline` command:

```
fly -t tutorial sp -p hello-world -c pipeline.yml
```{{execute}}

And confirm the pipeline now lists the contents of `resource-git-sample` by triggering the job and watching the output:

```
fly -t tutorial tj -j hello-world/job-hello-world -w
```{{execute}}
