The concourse client is designed to be explicit which server you work with and it requires that you specify the target API for every fly request. Define an alias for our test environment as follows:

```
fly login -t tutorial -c http://docker:8080
```{{execute terminal}}

Once completed you may verify the contents of your local fly configuration

```
cat ~/.flyrc
```{{execute terminal}}

> @alexsuraci: I promise you'll end up liking it more than having an implicit target state :) Makes reusing commands from shell history much less dangerous (rogue fly configure can be bad)

Review the configured targets with the targets subcommand (alias `ts`)

```
fly ts
```{{execute terminal}}

With the client configured, we can have an overview of all the commands supported as well as their aliases, we will opt to use the aliases in this tutorial.

```
fly --help
```{{execute terminal}}

For example, we may list the number of concourse workers

```
fly -t tutorial ws
```{{execute terminal}}

list active containers per worker

```
fly -t tutorial cs
```{{execute terminal}}
