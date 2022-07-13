elasticSearch_endpoint="https://`terraform output -raw opensearch_endpoint`:443"
elasticSearch_username="`terraform output -raw opensearch_username`"
elasticSearch_passowrd="`terraform output -raw opensearch_password`"


cat << EOF > scripts/rally.sh
# Get ElasticSearch vars
elasticSearch_endpoint=$elasticSearch_endpoint
elasticSearch_username=$elasticSearch_username
elasticSearch_passowrd=$elasticSearch_passowrd

# Install dependencies for the EC2 Instance

yum -y install gcc python3-devel

# Install rally
pip3.7 install esrally


# Run the benchmark
esrally race --track=pmc --target-hosts=${elasticSearch_endpoint} --pipeline=benchmark-only --client-options="use_ssl:true,verify_certs:true,basic_auth_user:'$elasticSearch_username',basic_auth_password:'$elasticSearch_passowrd'"
EOF


# Copy the rally.sh script to the public EC2 instance
scp -o StrictHostKeyChecking=no -i $(terraform output -raw public_ec2_key_pair_name).pem scripts/rally.sh ec2-user@$(terraform output -raw public_ec2_public_ip):/tmp/