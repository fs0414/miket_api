FROM ruby:3.2.2-alpine3.18

RUN apk update -qq && apk add libpq-dev nodejs vim g++ make

WORKDIR /workspace

ADD ../Gemfile /workspace/Gemfile
ADD ../Gemfile.lock /workspace/Gemfile.lock

RUN gem install bundler -v 2.4.19
RUN bundle install
