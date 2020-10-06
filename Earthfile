FROM ruby:2.7-slim
WORKDIR /adapter

deps:
    COPY Gemfile* /adapter/
    COPY *.gemspec /adapter
    COPY lib/database_cleaner/nobrainer/version.rb /adapter/lib/database_cleaner/nobrainer/

    RUN apt update \
        && apt install --yes \
                       --no-install-recommends \
                       build-essential \
                       git \
        && bundle install --jobs $(nproc)

    SAVE ARTIFACT /usr/local/bundle bundler

dev:
    RUN apt update \
        && apt install --yes \
                       --no-install-recommends \
                       git

    COPY +deps/bundler /usr/local/bundle

    COPY *.gemspec /adapter
    COPY bin/ /adapter/bin/
    COPY gemfiles/ /adapter/gemfiles/
    COPY .rspec /adapter
    COPY .rspec_status /adapter
    COPY Appraisals /adapter
    COPY Rakefile /adapter

    COPY Gemfile* /adapter

    COPY lib/ /adapter/lib/
    COPY spec/ /adapter/spec/

    ENTRYPOINT ["bundle", "exec"]
    CMD ["rake"]

    SAVE IMAGE zedtux/database_cleaner-nobrainer:latest

rspec:
    FROM docker:19.03.13-dind

    RUN apk --update --no-cache add docker-compose

    COPY docker-compose.yml ./

    WITH DOCKER
        DOCKER PULL rethinkdb:2.4-buster-slim

        DOCKER LOAD +dev zedtux/database_cleaner-nobrainer:latest

        RUN docker-compose up -d \
            && docker run --network=host \
                          zedtux/database_cleaner-nobrainer:latest \
            && docker-compose down
    END
