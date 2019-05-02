FROM node:8.0-alpine AS builder
RUN apk update && apk upgrade && apk add --no-cache bash git openssh
RUN npm config set unsafe-perm true

WORKDIR /app

COPY package.json /app
COPY Gruntfile.js /app
# Creating tar of productions dependencies
# Installing all dependencies
RUN npm install
# Hum...
RUN npm install nunjucks
RUN npm install -g grunt-cli
        
    


        
EXPOSE 8080
WORKDIR /app

# Copying application code
COPY . /app
RUN grunt build buildsite --no-hardlink
CMD node devserver.js
