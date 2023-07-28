[![CircleCI](https://circleci.com/gh/kworathur/node-docker-ecs.svg?style=svg)](https://app.circleci.com/pipelines/github/kworathur/node-docker-ecs)
# node-docker-ecs 

The goals of this project are to understand how CircleCI is used to automate CI/CD processes, and how Terraform can be used to provision AWS resources as code. 

# Prerequisites
In order to allow CircleCI to push to docker image to the ECR repository, an IAM user must be created with read/write permissions on the ECR repository. Additionally, the following environment variables must be added to the CircleCI project:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_ECR_REPOSITORY_ID

## Use of CircleCI and Terraform
The following steps are automated by CircleCI:

- Building the project. This includes installing the specified node version, ensuring that all dependencies were installed correctly, and run a demo unit test written with Mocha 
- Build a docker image from the built node application. The docker image will contain all the instructions necessary to launch a container that runs the application
- Push the docker image to an image repository in Amazon ECR


## Setup 

