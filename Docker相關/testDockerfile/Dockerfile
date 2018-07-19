# docker build --build-arg par1=123 --build-arg par2=234 .
FROM node:9.2.0 as builder
ADD . /tmp/
ARG par1=PleaseInputValidValue
ARG par2=PleaseInputValidValue2
RUN echo ${par1}
RUN echo ${par2}
RUN sed -i "s/888/${par1}/g" /tmp/testfile.log
RUN cat /tmp/testfile.log
