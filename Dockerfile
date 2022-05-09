FROM ruby:2.7.3
LABEL Description="Docker Rails API Base"
WORKDIR /app

RUN gem install bundler
#
RUN rails db:create
RUN rails db:migrate
RUN rails db:seed

CMD exec bin/start.sh   