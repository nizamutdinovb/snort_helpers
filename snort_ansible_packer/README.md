This packer template created for building docker Snort image for k8s cluster.

To build image need to setup number of environment variables.


```
AWS_PROFILE
```
To build image run the following command:
AWS_PROFILE=aws_profile packer build snort.json

As result you will get image at ECR you provided previously.
