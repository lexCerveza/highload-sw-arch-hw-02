FROM node:alpine

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm i
COPY . .
COPY ./.env ./.env
EXPOSE 5000
CMD ["node", "index.js"]
