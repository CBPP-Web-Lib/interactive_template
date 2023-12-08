FROM node:latest

WORKDIR /opt/project

RUN apt-get update 

RUN npm install -g webpack@5
RUN npm install -g webpack-cli@5

RUN apt-get install gdal-bin -y

ENTRYPOINT npx webpack