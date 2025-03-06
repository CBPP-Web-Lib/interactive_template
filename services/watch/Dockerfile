FROM node:latest

WORKDIR /opt/project/app

RUN apt-get update 
RUN apt-get install gdal-bin -y

ENTRYPOINT npx webpack --config=../webpack.config.js