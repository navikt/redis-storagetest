FROM ruby:2.6-alpine3.9

RUN apk add curl

ENV PORT=8080
EXPOSE 8080

WORKDIR /usr/src/app

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install

ADD 1mb.txt .
ADD app.rb .

CMD ["ruby", "./app.rb"]
