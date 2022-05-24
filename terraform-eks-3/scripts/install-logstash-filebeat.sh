helm upgrade --install my-filebeat elastic/filebeat --version 7.17.3 --namespace elk-stack --create-namespace --values scripts/filebeat-values.yaml

# Test access to openSearch before installing LogStash
curl https://admin:Password_123@search-benchmarking-test-7f4pcjtvoh5beyaunosvxdo4b4.us-east-1.es.amazonaws.com:443

helm upgrade --install my-logstash elastic/logstash --version 7.17.3 --namespace elk-stack --create-namespace --values scripts/logstash-values.yaml