# Get ElasticSearch vars
elasticSearch_endpoint=https://search-benchmarking-test-cwymrt2nyytbsbjporynfgmmfi.us-east-1.es.amazonaws.com:443
elasticSearch_username=admin
elasticSearch_passowrd=Password_123

# Install dependencies for the EC2 Instance

yum -y install gcc python3-devel

# Install rally
pip3 install esrally


# Run the benchmark
esrally race --track=pmc --target-hosts=https://search-benchmarking-test-cwymrt2nyytbsbjporynfgmmfi.us-east-1.es.amazonaws.com:443 --pipeline=benchmark-only --client-options="use_ssl:true,verify_certs:true,basic_auth_user:'admin',basic_auth_password:'Password_123'"
