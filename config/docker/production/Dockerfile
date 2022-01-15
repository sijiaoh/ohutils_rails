FROM ruby:3.1.0

RUN apt update -qq \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY Gemfile* /app/
RUN bundle config set --local without development test \
  && bundle install --jobs=4 \
  && bundle clean --force

COPY . /app/

ARG RAILS_MASTER_KEY
ARG OHUTILS_DATABASE_PASSWORD

ENV RAILS_ENV production
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
ENV OHUTILS_DATABASE_PASSWORD ${OHUTILS_DATABASE_PASSWORD}

RUN ./bin/rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server"]
