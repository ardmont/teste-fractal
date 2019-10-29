FROM ruby:2.5-slim

LABEL Name=teste-fractal Version=0.0.1
EXPOSE 3000

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN apt-get update --fix-missing
RUN apt-get install sqlite3 --assume-yes
RUN apt-get install libsqlite3-dev --assume-yes
RUN apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev --assume-yes


WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

ADD . /app


    