
aws_region = "us-east-1"
vpc_cidr_block = "10.0.0.0/16"
 subnet_cidr_block = [
     {subnet_cidr_block = "10.0.10.0/24", name = "Pub-sn"}, 
     {subnet_cidr_block = "10.0.20.0/24", name = "Priv-SN"}]
AZ = [
    {AZ = "us-east-1a", name = "Pub-SN-AZ"},
    {AZ = "us-east-1b", name = "Priv-SN-AZ"}]

env_prefix = "Development"
my-ip = "68.47.191.55/32"
instance_type = "t2.micro"
public_key-pair  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4fsPWVtOatQpmc0fRAf6117tAytFYy95VlgR7NrmGVKBkrGMhP2w5fMCNElnqARqfxt9YFklZj3zpYzycNaseC7Bh+Kxj/V+Y6hSbKx5vNvVNbuP5XmYbr8mWRsV1essoaa/hK2pY/jnPoDMiHrf3Rsh/Aj2cov7QAIUTJqO49bWWEjGzPyBg1Xw1D/DEyoORswBdx3RyBq/04lYXyQd5FrjQUc66paaCV7XCrYVgHBUbPaTGZJU1AYlywe+32uQb0QDcvbOzlGHubmIp1DCl41yyI/eTMStJlP3o1GMfbnROIXD7rZVWsOGfuQ/wnkxdvVB2aVWQe+oTef+bGdiWVMNAX+1z/NV96aJPVAvJMJJzMXDOhO0d/czYKOdPdjOiPo/BTdjVzZEId7i4u/XRkhQqn/Kr9jbdQqLw8bwHs0Ntn0xUr/QXqhzFxBEfMCHP3Eq08P0OXWgrVAtKdWUPPU+uLmP18dcrWtvhEBCEntWZlwuv4K82PnIBskTp1j8= 12406@Nguafac"