Concourse supports `inputs` into tasks to pass in files/folders for processing. This allows you to fetch artifacts at the start of a build pipeline or pass artifacts between tasks in a pipeline. We will cover this when looking into pipelines.

Let's add an input configuration. for each input the `name` and will determine the `path` relative to the working directory of the task (unless explicitly set). By default `optional` is `false`.

<pre class="file" data-filename="hello-world/task_ubuntu_ls.yml" data-target="replace">---
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

When inputs are defined by a task but not provided, the task will fail.

```
fly -t tutorial e -c task_ubuntu_ls.yml
```{{execute terminal}}

We will use the ability to provide input when executing a single task through the `-i` flag of the `execute` command.


```
fly -t tutorial e -c task_ubuntu_ls.yml -i some-important-input=.
```{{execute terminal}}

To pass in a different directory as an input, provide its absolute or relative path:


```
fly -t tutorial e -c task_ubuntu_ls.yml -i some-important-input=..
```{{execute terminal}}

The fly execute -i option can be removed if the current directory is the same name as the required input. For example, if we change the input name to match the parent directory name:

<pre class="file" data-filename="hello-world/task_ubuntu_ls.yml" data-target="replace">---
platform: linux

image_resource:
  type: docker-image
  source:
    repository: ubuntu

inputs:
- name: hello-world

run:
  path: ls
  args: ['-alR']
</pre>


```
fly -t tutorial e -c task_ubuntu_ls.yml
```{{execute terminal}}
