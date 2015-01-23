
#################################################################
# This docker image build file creates an image crafted for RoR 
# development. It packs nginx, passenger, rvm with ruby on rails 
# and nodejs. As dev env uses tmux, zsh, oh-my-zsh, powerline and 
# vim with pathogen and a lot of plugins.
# Is is based on ubuntu:saucy
#
#                    ##        .
#              ## ## ##       ==
#           ## ## ## ##      ===
#       /""""""""""""""""\___/ ===
#  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
#       \______ o          __/
#         \    \        __/
#          \____\______/
#
# Credentials
# User: dev
# Pass: dev
#
# Component:    ubuntu-dev
# Author:       batou99 <lorenzo.lopez@intec.es>
#################################################################

#####
# Building: sudo docker build -t batou99/ubuntu-dev .

# Open it up: sudo docker run -t -i -p 80:80 bash -l

# This image inherits from dockerfile/supervisor
# and its on docker public registry
FROM batou99/ubuntu-dev
MAINTAINER Lorenzo Lopez <lorenzo.lopez@intec.es>

USER root
RUN mkdir -p /var/run/sshd
RUN apt-get -y update
RUN apt-get -y install default-jdk imagemagick libmagickwand-dev redis-tools

ADD sshd.sv.conf /etc/supervisor/conf.d/

USER dev
RUN /bin/bash -l -c 'rvm get head'
RUN /bin/bash -l -c 'rvm install ree-1.8.7-2011.12'
RUN /bin/bash -l -c 'rvm use ree-1.8.7-2011.12 && rvm install rubygems 1.5.2 --force'
RUN /bin/bash -l -c 'rvm install 1.9.3-p484'

RUN mkdir ~/src
RUN mkdir ~/.ssh
# Add the code we cloned outside into the container
ADD code/ /home/dev/src/code
# We should have the keys to copy into the containers
ADD .ssh/config /home/dev/.ssh/config
ADD .ssh/id_rsa /home/dev/.ssh/id_rsa
ADD .ssh/id_rsa.pub /home/dev/.ssh/id_rsa.pub
ADD .ssh/id_rsa.pub /home/dev/.ssh/authorized_keys

USER root
RUN chmod 700 /home/dev/.ssh
RUN chown -R dev.dev /home/dev/
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV RAILS_ENV development
RUN env | grep _ >> /etc/environment

EXPOSE 9292
EXPOSE 4567
