FROM ruby:2.6-slim

ENV PROJECT=analytics

RUN apt-get update && apt-get install -y make build-essential

COPY ${PROJECT}/gems.rb /opt/${PROJECT}/
WORKDIR /opt/${PROJECT}
RUN bundle install

COPY ${PROJECT}/ /opt/${PROJECT}