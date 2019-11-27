ARG ELK_VERSION

# https://github.com/elastic/logstash-docker
FROM docker.elastic.co/logstash/logstash-oss:${ELK_VERSION}

# Add your logstash plugins setup here
# Example: RUN logstash-plugin install logstash-filter-json
# 增加logstash-nsq這段，讓nsq做queue manager，logstash去垃取nsq上面的資料
RUN /usr/share/logstash/bin/logstash-plugin install logstash-input-nsq