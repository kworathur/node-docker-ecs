provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_ecr_repository" "node_docker_ecs" {
    name = "node-docker-ecs"
}

resource "aws_ecs_cluster" "prod_cluster" {
    name = "prod-cluster"
}


resource "aws_ecs_task_definition" "demo_app_config" {
  family                   = "demo-app-config" 
  container_definitions    = <<DEFINITION
  [
    {
      "name": "demo_app_config",
      "image": "${aws_ecr_repository.node_docker_ecs.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] 
  network_mode             = "awsvpc"    
  memory                   = 512         
  cpu                      = 256         
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = "${aws_iam_role.ecsTaskExecutionRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



# Providing a reference to default VPC
resource "aws_default_vpc" "default_vpc" {
}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "us-east-1a"
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = "us-east-1b"
}

resource "aws_default_subnet" "default_subnet_c" {
  availability_zone = "eu-west-1c"
}

resource "aws_ecs_service" "run_demo_app" {
  name            = "run-demo-app"                             # Naming our first service
  cluster         = "${aws_ecs_cluster.prod_cluster.id}"             
  task_definition = "${aws_ecs_task_definition.demo_app_config.arn}" 
  launch_type     = "FARGATE"
  desired_count   = 1 

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true # Providing our containers with public IPs
  }
}