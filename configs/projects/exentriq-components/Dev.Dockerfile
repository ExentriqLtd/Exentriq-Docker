FROM node:14.21.3

ENV APP_PATH=/var/app

WORKDIR ${APP_PATH}/exentriq-components

RUN apt-get update && apt-get install jq -y

COPY ./Exentriq-MSP/npm/exentriq-components ${APP_PATH}/exentriq-components

RUN npm rebuild node-sass
RUN npm i

# open a port which is used by EMA
EXPOSE 8081
USER node

CMD ["npm", "start"]
