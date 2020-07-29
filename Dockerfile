FROM node:10.19-alpine3.9

RUN apk add --update git python g++ make && \

rm -rf /tmp/* /var/cache/apk/*

WORKDIR /src

RUN npm config set unsafe-perm true && npm config set user root && npm install @openzeppelin/cli@2.8.0-rc.2

#RUN npm config set unsafe-perm true && npm config set user root && npm install @openzeppelin/cli@2.7.1

WORKDIR /src/contracts

COPY ./contracts/Box.sol ./

WORKDIR /src

RUN npm init -y

RUN npx openzeppelin init test --no-interactive

RUN cat networks.js

CMD echo 'start oz deploy' && cat package.json && pwd && cat ./networks.js && cat ./.openzeppelin/project.json && npx openzeppelin deploy ./contracts/Contract.sol --kind regular --no-interactive --network development && ls -alR ./contracts && echo 'finish oz deploy'

