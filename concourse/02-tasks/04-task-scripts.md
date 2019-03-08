A common pattern is for Concourse tasks to `run:` complex shell scripts rather than directly invoking commands as we did so far.

We will use the task script `task-scripts/task_show_uname.sh`{{open}} in our next task configuration,

Create a new task configuration via the CLI: `touch task-scripts/task_show_uname.yml`{{execute}}

Open the file: `task-scripts/task_show_uname.yml`{{open}}

And add the following:

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="replace">---
platform: linux

image_resource:
  type: docker-image
  source:
    repository: ubuntu

inputs:
- name: task-scripts
</pre>

Add the following `run:` configuration:

<pre class="file" data-filename="task_ubuntu_ls.yml" data-target="replace">
run:
  path: ./task-scripts/task_show_uname.sh
</pre>

```
cd tasks-scripts
fly -t tutorial e -c task_show_uname.yml
```{{execute}}

This works because the task defines `task-scripts` as its input, which matches its parent directory.

The current directory was uploaded to the Concourse task container and placed inside the `task-scripts` directory.

Therefore its file `task_show_uname.sh` is available within the Concourse task container at `task-scripts/task_show_uname.sh`.

The only further requirement is that `task_show_uname.sh `is an executable script.
