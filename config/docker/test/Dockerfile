FROM ruby:3.1.0

RUN apt update -qq \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY Gemfile* /app/
RUN bundle config set --local without development \
  && bundle install --jobs=4 \
  && bundle clean --force

COPY . /app/

EXPOSE 3000

CMD ["./bin/test"]
