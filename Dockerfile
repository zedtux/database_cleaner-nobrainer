FROM ruby:2.7-slim

LABEL MAINTAINER="zedtux@zedroot.org"

WORKDIR /adapter

COPY Gemfile* /adapter/
COPY *.gemspec /adapter
COPY lib/database_cleaner/nobrainer/version.rb /adapter/lib/database_cleaner/nobrainer/

RUN apt update \
    && apt install --yes \
                   --no-install-recommends \
                   build-essential \
                   git \
    && bundle install --jobs $(nproc)

COPY . /adapter

ENTRYPOINT ["bundle", "exec"]
CMD ["rake"]
