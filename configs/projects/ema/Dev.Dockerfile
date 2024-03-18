FROM node:14.21.3

ENV APP_PATH=/var/app
ENV MONGO_SERVICE_NAME=mongo
ENV REDIS_SERVICE_NAME=redis
ENV METEOR_ALLOW_SUPERUSER=true

WORKDIR ${APP_PATH}/Exentriq-EMA

RUN apt-get update && apt-get install jq -y
RUN curl https://install.meteor.com/\?release\=1.8.0.1 | sh

COPY ./meteor-easy-search/packages ${APP_PATH}/meteor-easy-search/packages
COPY ./meteor-streamer/packages ${APP_PATH}/meteor-streamer/packages
COPY ./exentriq-packages ${APP_PATH}/exentriq-packages
COPY ./Exentriq-MSP/ ${APP_PATH}/Exentriq-MSP
COPY ./Exentriq-EMA/ ${APP_PATH}/Exentriq-EMA

RUN npm config set registry https://registry.npmjs.org/
RUN cd ${APP_PATH}/Exentriq-MSP/npm/exentriq-components && npm rebuild node-sass
RUN cd ${APP_PATH}/Exentriq-MSP/npm/exentriq-components && npm i
RUN cd ${APP_PATH}/Exentriq-MSP/npm/exentriq-components && npm run build_meteor

RUN meteor npm i

RUN chown -Rh node ${APP_PATH}/Exentriq-EMA/.meteor/local
RUN chmod -R 700 ${APP_PATH}/Exentriq-EMA/.meteor/local

RUN cp ./run_template.sh ./run.sh
RUN cp ./settings-development.json ./settings-local.json

RUN sed -i "s|mongodb://localhost:27017|mongodb://$MONGO_SERVICE_NAME:27017|g" ./run.sh
RUN sed -i "s|mongodb://localhost:27017|mongodb://$MONGO_SERVICE_NAME:27017|g" ./settings-local.json
RUN sed -i "s|\"path\": \"localhost\"|\"path\": \"$REDIS_SERVICE_NAME\"|g" ./settings-local.json
RUN sed -i "s|\"rootFolder\": \"\"|\"rootFolder\": \"$APP_PATH\"|g" ./settings-local.json

# open a port which is used by EMA
EXPOSE 3002
#USER node

CMD ["bash", "run.sh"]
