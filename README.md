# Important

For this image to work you need to add your private and public ssh keys into the .ssh folder and modify the Dockerfile accordingly
These keys are used so you can interact with the git repo inside the container. If the keys are not there when building the image that step will fail.
You need to add an id_rsa and id_rsa.pub
You need to install [boot2docker](https://github.com/boot2docker/boot2docker) if you are using Mac OSX.

To build the image do:

```
./install.sh
```

This image is based on batou99/ubuntu-dev (it is on the docker registry)

To start the whole dev env you need to have [fig](http://www.fig.sh/)
Once installed just do:

```
fig up
```

After runnning fig there will be 2 containers running. One with the DB and another with the source code.
Ssh is enabled on the source code container. To ssh into it do:

```
ssh dev@docker_name_or_ip -p 223
```

It should log in without credentials as it is using the same rsa key as the host system.
In case you need to log in without ssh keys the credentials are

user: dev
pass: dev

Once inside in the dev home folder just need to run:

```
./run.sh
```

That will install the gems, run migrations and seed the app.
The source code of the app is in the folder **~/src/code**

