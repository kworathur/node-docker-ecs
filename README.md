[![CircleCI](https://circleci.com/gh/kworathur/node-docker-ecs.svg?style=svg)](https://app.circleci.com/pipelines/github/kworathur/node-docker-ecs)
# node-docker-ecs 

This is a project to showcase understanding of CircleCI for automating CI/CD processes, and Terraform for programmatic infrastructure provisioning.

## Use of CircleCI and Terraform
The following steps are automated by CircleCI:

- Building the project. This includes installing the specified node version, ensuring that all dependencies were installed correctly, and running any unit tests that have been written. 
- Build a docker image from the built node application. The docker image will contain all the instructions necessary to launch a container that runs the application
- Push the docker image to an image repository in Amazon ECR


## Setup 

