FROM ruby:2.5-alpine as builder

RUN apk update \
    && apk add libatomic readline readline-dev libxml2 libxml2-dev \
       ncurses-terminfo-base ncurses-terminfo \
       libxslt libxslt-dev zlib-dev zlib \
       ruby ruby-dev yaml yaml-dev \
       libffi-dev build-base git nodejs \
       ruby-io-console ruby-irb ruby-json ruby-rake \
    && gem install --no-document \
       redcarpet kramdown maruku \
       rdiscount RedCloth liquid pygments.rb \
       sass safe_yaml \
       jekyll jekyll-paginate jekyll-sass-converter \
       jekyll-sitemap jekyll-feed jekyll-redirect-from \
    && rm -rf /var/cache/apk/*

RUN mkdir /srv/jekyll
WORKDIR /srv/jekyll
COPY . .

EXPOSE 4000
RUN jekyll build --config _config.yml --destination ./dist/staging
