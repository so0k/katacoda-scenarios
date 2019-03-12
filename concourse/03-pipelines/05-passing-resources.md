In this step we will make an actual pipeline - one job passing results to another job upon success.

In all previous sections our pipelines have only had a single job. For all their wonderfulness, they haven't yet felt like actual pipelines. Jobs passing results between jobs. This is where Concourse shines even brighter.

Open the file: `pipeline_output_git.yml`{{open}} - which should be as follows:

<pre class="file" data-filename="pipeline_output_git.yml" data-target="replace">
resources:
- name: resource-git-sample
  type: git
  source:
    uri: http://git-server:8080/git-sample.git
    branch: master
- name: 2m
  type: time
  source:
    interval: 2m

jobs:
- name: job-bump-date
  serial: true
  plan:
  - get: resource-git-sample
  - get: 2m
    trigger: true
  - task: bump-timestamp-file
    file: resource-git-sample/ci/task-bump-timestamp.yml
  - put: resource-git-sample
    params:
      repository: updated-git-sample
</pre>

Add a second job `job-show-date` which will run whenever the first job successfully completes:

<pre class="file" data-filename="pipeline_output_git.yml" data-target="append">
- name: job-show-date
  plan:
  - get: resource-git-sample
    passed: [job-bump-date]
    trigger: true
  - task: show-date
    config:
      platform: linux
      image_resource:
        type: registry-image
        source: {repository: busybox}
      inputs:
        - name: resource-git-sample
      run:
        path: cat
        args: [resource-git-sample/bumpme]
</pre>

Update the `bump-date` pipeline configuration in Concourse:

```
fly -t tutorial sp -p bump-date -c pipeline_output_git.yml
```{{execute}}

And trigger the job with the `-w` flag to watch its progress:

```
fly -t tutorial tj -j bump-date/job-bump-date -w
```{{execute}}

The latest `resource-git-sample` commit fetched down in `job-show-date` will be the exact commit used in the last successful `job-bump-date` job. If you manually created and pushed a new git commit in the `git-sample` repository and manually ran the `job-show-date` job it would continue to use the previous commit it used, and ignore your new commit. This is the power of pipelines.

## Cleaning up

As this pipeline is triggered every 2 mintues, you may delete the `bump-date` pipeline (and lose all its build history) with the `destroy-pipeline` (alias `dp`) command:

```
fly -t tutorial dp -p bump-date
```{{execute}}
