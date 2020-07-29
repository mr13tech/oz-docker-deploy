FROM node:10.19-alpine3.9

RUN apk add --update git python g++ make && \

rm -rf /tmp/* /var/cache/apk/*

WORKDIR /src

RUN npm init -y
RUN npm config set unsafe-perm true && npm config set user root && npm install @openzeppelin/cli
RUN npx openzeppelin init test --no-interactive

COPY ./contracts/Box.sol /src/contracts

CMD  npx openzeppelin deploy --kind regular --no-interactive --network development Box


