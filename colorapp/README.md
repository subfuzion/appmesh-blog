# Running the Color App Demo

This is how to run the demo from the re:Invent launch of App Mesh.

Here's what we are going to do:

1. Create a [Virtual Private Cloud] (VPC) for the application. A VPC is a virtual network that provides isolation from other applications in other networks running on AWS.

2. 

## Prerequisites

1. You have the latest version of the [AWS CLI] installed.

2. Your [AWS CLI configuration] has a `default` or named profile and valid credentials.

## Create the VPC

We will use a script to deploy a [CloudFormation] stack that will create a VPC for our application.

The VPC will be created for the region specified by the `AWS_DEFAULT_REGION` environment variable. It will be configured for two availability zones (AZs); each AZ will be configured with a public and a private subnet. 

The deployment will include an [Internet Gateway] and a pair of [NAT Gateways] (one in each AZ) with default routes for them in the private subnets.

App Mesh is available in all of the following [AWS regions]:

| AWS Region Name            | Code           |
|----------------------------|----------------|
| US West (N. California)    | us-west-1      |
| US West (Oregon)           | us-west-2      |
| US East (N. Virginia)      | us-east-1      |
| US East (Ohio)             | us-east-2      |
| Canada (Central)           | ca-central-1   |
| Europe (Ireland)           | eu-west-1      |
| Europe (London)            | eu-west-2      |
| Europe (Stockholm)         | eu-north-1     |
| Europe (Frankfurt)         | eu-central-1   |
| Asia Pacific (Mumbai)      | ap-south-1     |
| Asia Pacific (Singapore)   | ap-southeast-1 |
| Asia Pacific (Sydney)      | ap-southeast-2 |
| Asia Pacific (Tokyo)       | ap-northeast-1 |
| Asia Pacific (Seoul)       | ap-northeast-2 |
| Asia Pacific (Osaka-Local) | ap-northeast-3 |
| China (Beijing)            | cn-north-1     |
| China (Ningxia)            | cn-northwest-1 |
| AWS GovCloud (US-East)     | us-gov-east-1  |
| AWS GovCloud (US-West)     | us-gov-west-1  |

Note that Fargate is currenly supported only in `us-east-2` (more regions coming very soon).



`AWS_PROFILE` should be set to a profile that you've configured for the AWS CLI (either `default` or a named profile).
`AWS_DEFAULT_REGION` should be set to a region from the supported regions shown previously.
`ENVIRONMENT_NAME` will be used as a prefix for the CloudFormation stacks that you will deploy.



```
$ export AWS_PROFILE=default
$ export AWS_DEFAULT_REGION=us-west-2
$ export ENVIRONMENT_NAME=DEMO
$ .examples/infrastructure/vpc.sh
+ aws --profile default --region us-west-2 cloudformation deploy --stack-name DEMO-vpc --capabilities CAPABILITY_IAM --template-file examples/infrastructure/vpc.yaml --parameter-overrides EnvironmentName=DEMO

Waiting for changeset to be created..
Waiting for stack create/update to complete
...
Successfully created/updated stack - DEMO-vpc
```





[AWS CLI]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html

[AWS CLI configuration]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html

[AWS regions]: https://github.com/aws/aws-app-mesh-roadmap/issues/1

[CloudFormation]: https://aws.amazon.com/cloudformation/

[Internet Gateway]: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html

[NAT Gateway]: https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html

[Virtual Private Cloud]: https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html



