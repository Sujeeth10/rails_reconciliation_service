FROM ruby:3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm curl
RUN npm install -g yarn
RUN gem install bundler --no-document
RUN gem install rails -v 7.0.4 --no-document || gem install rails --no-document
WORKDIR /myapp
COPY Gemfile* /myapp/ 2>/dev/null || true
RUN if [ -f Gemfile ]; then bundle config set without 'development test' && bundle check || bundle install; fi
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
