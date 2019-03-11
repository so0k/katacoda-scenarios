So far we have mainly triggered jobs manually through the `fly trigger-job` command.

Other options are:

- Use the Concourse Web UI: click the `+` button on a job
- Sending `POST` request to Concourse API
- Trigger jobs using resources

The primary way that Concourse jobs will be triggered to run will be by resources changing. A `git` repo has a new commit? Run a job to test it. A GitHub project cuts a new release? Run a job to pull down its attached files and do something with them.

As mentioned in Step 4 of this scenario, triggering is controlled by the steps in the build plan. A `get` step may use its resource `check` method to trigger depending jobs.

The [`time resource`](https://github.com/concourse/time-resource) comes with Concourse out of the box and is meant mainly to satisfy "trigger this build at least once every 5 minutes" type of requirements.

Open the file: `pipeline_output_git.yml`{{open}}

Add the `timer` resource named `2m` with an `interval` of 2 minutes and use it in a triggering `get` step:

<pre class="file" data-filename="pipeline_output_git.yml" data-target="replace">
resources:
- name: resource-git-sample
  type: git
  source:
    uri: http://git-server:8080/git-sample.git
    branch: master
- name: 2m
  type: timer
  source:
    interval: 2m

jobs:
- name: job-bump-date
  serial: true
  plan:
  - get: resource-git-sample
  - get: 2m
    trigger: true              # trigger job every 2 minutes
  - task: bump-timestamp-file
    file: resource-git-sample/ci/task-bump-timestamp.yml
  - put: resource-git-sample
    params:
      repository: updated-git-sample
</pre>

Update the `bump-date` pipeline configuration in Concourse:

```
fly -t tutorial sp -p bump-date -c pipeline_output_git.yml
```{{execute}}

You may watch the builds to see the bump-date pipeline run every 2 minutes

```
watch fly -t tuturial bs -p bump-date
```{{execute}}

**Note**: Press `CTRL`+`C` to stop the watch

Why does `time` resource configured with `interval: 2m` trigger "approximately" every 2 minutes?

> "resources are checked every minute, but there's a shorter (10sec) interval for determining when a build should run; time resource is to just ensure a build runs on some rough periodicity; we use it to e.g. continuously run integration/acceptance tests to weed out flakiness" - alex

The net result is that a timer of `2m` will trigger every 2 to 3 minutes.
