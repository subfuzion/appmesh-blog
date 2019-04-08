# Running the Color App Demo

This is how to run the demo from the re:Invent launch of App Mesh.

Here's what we are going to do:

1. Create a [Virtual Private Cloud] (VPC) for the application. A VPC is a virtual
network that provides isolation from other applications in other networks running
on AWS.

2. 

## Prerequisites

1. You have the latest version of the [AWS CLI] installed.

2. Your [AWS CLI configuration] has a `default` or named profile and valid credentials.

3. You have cloned the [github.com/aws/app-mesh-examples] repo and changed directory to the project root.

## Create the VPC

We will use a script to deploy a [CloudFormation] stack that will create a VPC
for our application.

The VPC will be created for the region specified by the `AWS_DEFAULT_REGION` environment
variable. It will be configured for two availability zones (AZs); each AZ will be
configured with a public and a private subnet. App Mesh is currently available in
nineteen [AWS regions]:

The deployment will include an [Internet Gateway] and a pair of [NAT Gateways] (one
in each AZ) with default routes for them in the private subnets.

The following environment variables need to be set before running the script:

* `AWS_PROFILE` should be set to a profile that you've configured for the AWS CLI (either
`default` or a named profile).
* `AWS_DEFAULT_REGION` should be set to a region from the supported regions shown previously.
* `ENVIRONMENT_NAME` will be used as a prefix for the CloudFormation stacks that you will deploy.

To deploy the stack, run `examples/infrastructure/vpc.sh`:

```
$ export AWS_PROFILE=default
$ export AWS_DEFAULT_REGION=us-west-2
$ export ENVIRONMENT_NAME=DEMO
$ .examples/infrastructure/vpc.sh
...
+ aws --profile default --region us-west-2 cloudformation deploy --stack-name DEMO-vpc --capabilities CAPABILITY_IAM --template-file examples/infrastructure/vpc.yaml --parameter-overrides EnvironmentName=DEMO

Waiting for changeset to be created..
Waiting for stack create/update to complete
...
Successfully created/updated stack - DEMO-vpc
```

## Create an App Mesh

The following CloudFormation template will be used to create our mesh:

`examples/infrastructure/appmesh-mesh.yaml`

```
Parameters:

  EnvironmentName:
    Description: An environment name that will be prefixed to resource names
    Type: String

  AppMeshMeshName:
    Type: String
    Description: Name of mesh

Resources:

  Mesh:
    Type: AWS::AppMesh::Mesh
    Properties:
      MeshName: !Ref AppMeshMeshName

Outputs:

  Mesh:
    Description: A reference to the AppMesh Mesh
    Value: !Ref Mesh
    Export:
      Name: !Sub "${EnvironmentName}:Mesh"
```

We will use the same environment variables from the previous step, plus one
additional one (`MESH_NAME`), to deploy the stack using a script (`appmesh-mesh.sh`).

* `MESH_NAME` should be set to the name you want to use to identify the mesh. For this demo, we will call it `appmesh-mesh`.

```
$ ./examples/infrastructure/appmesh-mesh.sh
...
+ aws --profile default --region us-west-2 cloudformation deploy --stack-name DEMO-appmesh-mesh --capabilities CAPABILITY_IAM --template-file /home/ec2-user/projects/aws/aws-app-mesh-examples/examples/infrastructure/appmesh-mesh.yaml --parameter-overrides EnvironmentName=DEMO AppMeshMeshName=appmesh-mesh

Waiting for changeset to be created..
Waiting for stack create/update to complete
...
Successfully created/updated stack - DEMO-appmesh-mesh
```





[AWS CLI]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
[AWS CLI configuration]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
[AWS regions]: ./regions.md
[CloudFormation]: https://aws.amazon.com/cloudformation/
[github.com/aws/app-mesh-examples]: https://github.com/aws/aws-app-mesh-examples
[Internet Gateway]: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html
[NAT Gateway]: https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html
[Virtual Private Cloud]: https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html

