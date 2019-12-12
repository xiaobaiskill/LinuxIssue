#### refer : https://vsupalov.com/docker-arg-env-variable-guide/
```
# Dockerfile
# [[docker build cmd]]
# docker build --build-arg par1=123 --build-arg par2=234 .
FROM node:9.2.0 as builder
ADD . /tmp/
ARG par1=PleaseInputValidValue
ARG par2=PleaseInputValidValue2
RUN echo ${par1}
RUN echo ${par2}
```

#### sed ref
https://jingyan.baidu.com/article/adc81513a26ac7f723bf738f.html
http://www.bathome.net/thread-29077-1-1.html
