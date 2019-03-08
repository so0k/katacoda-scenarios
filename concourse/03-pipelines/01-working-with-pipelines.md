Pipelines are configured entirely via the fly CLI. There is no GUI.

Let's see how to upload a pipeline, run it and watch its executing all through the command line.

The provided `pipepline.yml`{{open}} (click to open) configuration defines a basic pipepline using the hello world task as covered in the scenario covering tasks. To submit a pipeline configuration to Concourse from a file on your local disk you use the `set-pipeline` (alias `sp`) command.

The `set-pipeline` command takes the name you want to store the pipeline as (`-p`) and the `yaml` configuration of the pipeline (`-c`):

```
fly -t tutorial sp -p hello-world -c pipeline.yml
```{{execute}}

You will be prompted to apply any configuration changes you made in the yaml file each time with a clear diff of what you changed.

```
apply configuration? [yN]:
```

Press `y`

**Note**: Unfortunetaly the link to view the pipeline won't work in this Katacoda learning environment and we will use the terminal only.

You should see:

```
pipeline created!
you can view your pipeline here: http://docker:8080/teams/main/pipelines/hello-world

the pipeline is currently paused. to unpause, either:
  - run the unpause-pipeline command
  - click play next to the pipeline in the web ui
```

New pipelines start paused as you might not yet be ready for triggers to fire and start jobs running.

To unpause use the `unpause-pipeline` (alias `up`):

```
fly -t tutorial up -p hello-world
```{{execute}}

Pipelines trigger jobs, to list the running jobs for a pipeline use the `builds` ( alias `bs`) command:

```
fly -t tutorial bs -p hello-world
```{{execute}}

To watch the output of our job, use the `watch` (alias `w`) command with the `-j` flag:

```
fly -t tutorial w -j hello-world/job-hello-world
```{{execute}}

To watch a particular build of a job, use the `watch` (alias `w`) command with the `-b` flag:

```
fly -t tutorial w -b 1
```{{execute}}

We have succesfully created, ran and watched our first basic pipeline, next step we will create more advanced pipelines.
