Concourse supports `inputs` into tasks to pass in files/folders for processing. This allows you to fetch artifacts at the start of a build pipeline or pass artifacts between tasks in a pipeline. Passing artifacts between pipeline steps will be covered during the pipelines scenario, this step covers how tasks themselves work with inputs.

Let's add an input configuration. for each input the `name` and will determine the `path` relative to the working directory of the task (unless explicitly set). By default `optional` is `false`.

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="replace">---
platform: linux

image_resource:
  type: docker-image
  source:
    repository: ubuntu

inputs:
- name: some-important-input

run:
  path: ls
  args: ['-alR']
</pre>

When inputs are defined by a task and not flagged as option, yet not provided, the task will fail.

```
fly -t tutorial e -c task_ubuntu_ls.yml
```{{execute}}

As expected, we see `error: missing required input ``some-important-input```

When executing a single task through the `execute` command, we will provide input through the `-i` flag:

```
fly -t tutorial e -c task_ubuntu_ls.yml -i some-important-input=.
```{{execute}}

To pass in a different directory as input, provide its absolute or relative path:

```
fly -t tutorial e -c task_ubuntu_ls.yml -i some-important-input=sample
```{{execute}}

The fly execute -i option can be removed if the current directory is the same name as the required input. For example, if we change the input name to match the parent directory name:

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="replace">---
platform: linux

image_resource:
  type: docker-image
  source:
    repository: ubuntu

inputs:
- name: tutorial

run:
  path: ls
  args: ['-alR']
</pre>


```
fly -t tutorial e -c task_ubuntu_ls.yml
```{{execute}}
