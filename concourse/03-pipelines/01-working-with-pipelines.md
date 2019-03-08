Pipelines are configured entirely via the fly CLI. There is no GUI.

Let's see how to upload a pipeline, run it and watch its executing all through the command line.

The provided `pipeline.yml`{{open}} (click to open) configuration defines a basic pipepline using the hello world task as covered in the scenario covering tasks. To submit a pipeline configuration to Concourse from a file on your local disk you use the `set-pipeline` (alias `sp`) command.

This first pipeline is unimpressive - a single job job-hello-world with no inputs from the left and no outputs to its right, no jobs feeding into it, nor jobs feeding from it and no triggers to kick of the job. It is the most basic pipeline.

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

To view all defined pipelines use the `pipeplines` (alias `ps`) command:

```
fly -t tutorial ps
```{{execute}}

To unpause the pipeline use the `unpause-pipeline` (alias `up`):

```
fly -t tutorial up -p hello-world
```{{execute}}

As our pipeline did not define any triggers for the job, we need to manually trigger the job, this will queue the job for execution.

**Note**: Triggering a job in a paused pipeline will keep the job pending until the pipeline itself is unpaused!

Use the `trigger-job` (alias `tj`) command to trigger the `job-hello-world` in our `hello-world` pipeline. We may pass in the `-w` flag to monitor the execution of the job:

```
fly -t tutorial tj -j hello-world/job-hello-world -w
```{{execute}}

Once the job has completed, we may list all the builds for a pipeline use the `builds` ( alias `bs`) command with the `-p` flag:

```
fly -t tutorial bs -p hello-world
```{{execute}}

To review the output of the last build of our job, use the `watch` (alias `w`) command with the `-j` flag:

```
fly -t tutorial w -j hello-world/job-hello-world
```{{execute}}

To review the output of a particular build of our job add the `-b` flag:

```
fly -t tutorial w -j hello-world/job-hello-world -b 1
```{{execute}}

We have succesfully created, ran and watched our first basic pipeline, next we will create more advanced pipelines.
