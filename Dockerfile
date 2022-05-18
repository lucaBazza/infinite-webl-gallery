# steps:    1- $ docker build ./
#           2- $ docker tag IMAGE-ID zabbanode
#           3- $ docker run -d --publish 8000:8000 zabbanode        // run detached, port 8000
#           3- $ [alt]  docker run -d -p 8080:8080 --name rest-zabba-NodeJS-server -it $(docker build -q .)
#           3- $ [alt]  docker compose up   NO-WORKS

FROM node:17-alpine

LABEL version="1.0"
LABEL description="zabba test nodejs dockered"
LABEL maintainer="email luca.bazzanella94@gmail.com"

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies: a wildcard is used to ensure both package.json AND package-lock.json are copied where available (npm@5+)
COPY package*.json ./

RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*

RUN npm install

# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 8080

CMD ["npm", "start"]
#CMD ["npm", "webpack serve --mode development  --host 0.0.0.0"]