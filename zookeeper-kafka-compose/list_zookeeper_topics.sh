# notice that "172.21.0.3" is the container's ip, which can be retrived vi `check` script
docker exec -it zookeeper-kafka-compose_kafka_1 ./opt/kafka/bin/kafka-topics.sh --list --zookeeper 172.21.0.3:2181

# or try
docker exec -it zookeeper-kafka-compose_kafka_1 ./opt/kafka/bin/kafka-topics.sh --list --zookeeper `sh check.sh`:2181