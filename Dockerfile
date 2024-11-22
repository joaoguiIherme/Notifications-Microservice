FROM ruby:3.1.6

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs bash

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 4 --retry 3

COPY . .

EXPOSE 4001

CMD ["bash", "-c", "rm -f tmp/pids/server.pid && rails server -p 4001 -b 0.0.0.0"]
