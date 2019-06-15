FROM node:alpine

ADD . /wsServer/
WORKDIR /wsServer
RUN npm install ws
CMD ["node","server.js"]
