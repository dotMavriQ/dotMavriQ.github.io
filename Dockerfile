FROM debian:bullseye AS build
RUN apt-get update \
 && apt-get install -y hugo

WORKDIR /blog
COPY . .
RUN hugo --environment production

FROM nginx:latest AS production
RUN rm -rf /usr/share/nginx/html
COPY --from=build /blog/public /usr/share/nginx/html

