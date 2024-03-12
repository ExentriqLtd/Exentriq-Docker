FROM node:14.21.3

WORKDIR /var/app/Exentriq-EMA

ENV METEOR_ALLOW_SUPERUSER=true

RUN apt-get update && apt-get install jq -y
RUN curl https://install.meteor.com/\?release\=1.8.0.1 | sh

COPY ./meteor-easy-search/packages /var/app/meteor-easy-search/packages
COPY ./meteor-streamer/packages /var/app/meteor-streamer/packages
COPY ./exentriq-packages /var/app/exentriq-packages
COPY ./Exentriq-MSP/ /var/app/Exentriq-MSP/
COPY ./Exentriq-EMA/ /var/app/Exentriq-EMA

# RUN cd ../Exentriq-MSP/npm/exentriq-components && npm i

RUN meteor npm install

#RUN chown -Rh node /var/app/Exentriq-EMA/.meteor/local
RUN chmod -R 700 /var/app/Exentriq-EMA/.meteor/local

RUN cp ./run_template.sh ./run.sh

# open a port which is used by EMA
EXPOSE 3002
#USER node
CMD ["bash", "run.sh"]
