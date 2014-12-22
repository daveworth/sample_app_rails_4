FROM ruby:2.1.5
RUN mkdir -p /usr/src/sample_app_rails_4
WORKDIR /usr/src/sample_app_rails_4
COPY . /usr/src/sample_app_rails_4
ENV SECRET_KEY_BASE af11b5847a6110626cfb16d71d60f71f
RUN bundle install
RUN apt-get update
RUN apt-get install -y nodejs --no-install-recommends
RUN apt-get install -y sqlite3 --no-install-recommends
RUN rm -rf /var/lib/apt/lists/*
EXPOSE 3000
CMD export RAILS_ENV=production; \
    bundle exec rake db:create; \
    bundle exec rake db:migrate; \
    bundle exec rake db:seed; \
    bundle exec rails server -p 3000
