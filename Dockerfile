FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /further_efforts
WORKDIR /further_efforts
COPY Gemfile /further_efforts/Gemfile
COPY Gemfile.lock /further_efforts/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /further_efforts

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]