FROM ruby:3.1.2

RUN apt-get -q update -yqq && apt-get install -yqq --no-install-recommends \
  curl

SHELL ["/bin/bash", "-l", "-c"]

# Installing node with n
RUN curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
RUN bash n 16.13.2
RUN npm install -g npm@8.13.2
RUN corepack enable

# Moving files
WORKDIR /app
ADD Gemfile* /app/

# Install gems
RUN gem install bundler:2.2.15
RUN bundle install

ADD . /app/

# NOTE: Adding master key here for testing purposes. This is not the intended place for the master.key
ENV RAILS_MASTER_KEY="371f9e6694dbf119e4072332b80f53b7"

# Add a script to be executed every time the container starts.
COPY ./docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]