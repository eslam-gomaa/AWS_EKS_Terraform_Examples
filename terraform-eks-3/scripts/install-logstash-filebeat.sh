#!/bin/bash
elastic_search_endpoint=$1

if ! [ -n "$1" ];
then
    echo "Error -- Please provide the 1st argument 'ElasticSearch Endpoint' "
    exit 1
fi

read -r -d '' VAR << EOF
image: "opensearchproject/logstash-oss-with-opensearch-output-plugin"
imageTag: "7.16.3"
imagePullPolicy: "IfNotPresent"
imagePullSecrets: []

service:
  annotations: {}
  type: ClusterIP
  loadBalancerIP: ""
  ports:
    - name: beats
      port: 5044
      protocol: TCP
      targetPort: 5044
    - name: http
      port: 8080
      protocol: TCP
      targetPort: 8080
      
logstashPipeline:
 logstash.conf: |
   input {
     beats {
       port => 5044 
     }
   }
   output {
    opensearch {
      hosts       => "https://$elastic_search_endpoint:443"
      user        => "admin"
      password    => "Password_123"
      index       => "logstash-logs-%{+YYYY.MM.dd}"
      ecs_compatibility => disabled
      ssl_certificate_verification => false
        }
    }
EOF

sleep  0.1
echo "${VAR}" > scripts/logstash-values-updated.yaml
sleep  0.1


helm repo add elastic https://helm.elastic.co

helm repo update


helm upgrade --install my-logstash elastic/logstash --version 7.17.3 --namespace elk-stack --create-namespace --values scripts/logstash-values-updated.yaml

helm upgrade --install my-filebeat elastic/filebeat --version 7.17.3 --namespace elk-stack --create-namespace --values scripts/filebeat-values.yaml


# search-benchmarking-test-sl33wqfloqf53trhegkgh6ua3e.us-east-1.es.amazonaws.com