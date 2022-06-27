FROM klakegg/hugo:ext-alpine

RUN apk add git
RUN git config --global --add safe.directory /src