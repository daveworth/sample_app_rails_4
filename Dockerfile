FROM ruby:2.1.5
RUN mkdir -p /opt/apps/sample_app_rails_4
WORKDIR /opt/apps/sample_app_rails_4
COPY . /opt/apps/sample_app_rails_4
# You should definitely change the SECRET_KEY_BASE
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
