  FROM ruby:3.1.2
  RUN apt-get update && apt-get install
  WORKDIR /app
  COPY Gemfile* .
  RUN bundle install
  COPY . .
  CMD ["rails", "server", "-b", "0.0.0.0"]