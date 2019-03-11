Concourse supports `inputs` to pass files/folders for processing into tasks. 

This allows you to fetch artifacts at the start of a build pipeline or pass artifacts between tasks in a pipeline. Passing artifacts between pipeline steps will be covered during the pipelines scenario, right now we focus on how tasks themselves work with `inputs`.

Let's add an input configuration to our `task_ubuntu_ls.yml`{{open}} task.

For each input the `name` is required and determines the `path` artifacts are stored relative to the working directory of the task (you may override the `name` by setting `path` explicitly in the input configuration). By default an input is set `false` for `optional` and thus required.

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="replace">---
platform: linux

image_resource:
  type: registry-image
  source:
    repository: ubuntu

inputs:
- name: some-important-input

run:
  path: ls
  args: ['-alR']
</pre>

When inputs are defined by a task, not flagged as optional but not provided, the task will fail (as is the case here):

```
fly -t tutorial e -c task_ubuntu_ls.yml
```{{execute}}

We should see:

```
error: missing required input `some-important-input`
```

When executing a single task through the `execute` command, we will provide input through the `-i` flag:

```
fly -t tutorial e -c task_ubuntu_ls.yml -i some-important-input=.
```{{execute}}

To pass in a different directory as input, provide its absolute or relative path, for example:

```
fly -t tutorial e -c task_ubuntu_ls.yml -i some-important-input=task-scripts
```{{execute}}

The fly execute `-i` option can be removed if the current directory is the same name as the required input. For example, if we change the input name to match the parent directory name:

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="replace">---
platform: linux

image_resource:
  type: registry-image
  source:
    repository: ubuntu

inputs:
- name: tutorial

run:
  path: ls
  args: ['-alR']
</pre>

The task will have all files within its parent directory available during execution:

```
fly -t tutorial e -c task_ubuntu_ls.yml
```{{execute}}
