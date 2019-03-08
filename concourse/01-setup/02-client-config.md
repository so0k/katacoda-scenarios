The concourse client is designed to be explicit which server you work with and it requires that you specify the target API for every fly request. Define an alias for our tutorial environment as follows:

```
fly login -t tutorial -c https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com
```{{execute}}

This will prompt you to log in using the web console, use `admin`{{copy}} as both username and password.

Click the link displayed in the terminal to open a new window for log in.

Once logged in, an attempt is made to send the authentication token back to the fly CLI, however this fails given the constraints of the katacoda environment. Use the `copy token to clipboard` button and close the window to past the token manually into the terminal.

Once completed you may verify the contents of your local fly configuration

```
cat ~/.flyrc
```{{execute}}

> @alexsuraci: I promise you'll end up liking it more than having an implicit target state :) Makes reusing commands from shell history much less dangerous (rogue fly configure can be bad)

Review the configured targets with the targets subcommand (alias `ts`)

```
fly ts
```{{execute}}

With the client configured, we can have an overview of all the commands supported as well as their aliases, we will opt to use the aliases in this tutorial.

```
fly --help
```{{execute}}

For example, we may list the number of concourse workers

```
fly -t tutorial ws
```{{execute}}

list active containers per worker

```
fly -t tutorial cs
```{{execute}}
