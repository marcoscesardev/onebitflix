FROM ruby:2.6.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
&& apt-get install -y nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn postgresql-client

WORKDIR /onebitflix

COPY . /onebitflix

RUN chmod +x start-dev.sh

RUN gem install bundler

RUN bundle install 

ENTRYPOINT ["./start-dev.sh"]