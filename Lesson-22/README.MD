# Terraform Folder Hierarchy for Multi Environment example


Terraform Modules better to keep in GitHub or BitBucket, otherwise in separate folder.
```
.
├── modules
│   ├── aws_network
│   ├── aws_security_group
│   └── aws_something
└── ProjectXYZ
    ├── dev
    │   ├── kms
    │   ├── network
    │   ├── route53
    │   ├── s3
    │   └── vpc
    │       ├── applications
    │       │   ├── app1
    │       │   └── app2
    │       ├── databases
    │       ├── ecs_cluster
    │       └── vpn
    ├── prod
    │   ├── kms
    │   ├── network
    │   ├── route53
    │   ├── s3
    │   └── vpc
    │       ├── applications
    │       │   ├── app1
    │       │   └── app2
    │       ├── databases
    │       ├── ecs_cluster
    │       └── vpn
    └── staging
        ├── kms
        ├── network
        ├── route53
        ├── s3
        └── vpc
            ├── applications
            │   ├── app1
            │   └── app2
            ├── databases
            ├── ecs_cluster
            └── vpn
```

# ----------------------------
