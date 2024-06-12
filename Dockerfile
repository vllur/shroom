FROM crystallang/crystal:1.12.2

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN shards install
RUN shards build --release --no-debug
ENTRYPOINT /app/bin/shroom