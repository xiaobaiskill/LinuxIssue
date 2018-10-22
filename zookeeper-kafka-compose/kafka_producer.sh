# add a kafka producer for topic 'test'
docker exec -it kafka-docker_kafka_1 ./opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
