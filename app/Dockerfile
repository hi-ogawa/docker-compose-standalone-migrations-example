FROM haskell:7.10.3

RUN apt-get update && apt-get install libpq-dev postgresql-client -y

RUN mkdir -p /app
WORKDIR /app

RUN cabal update
COPY app.cabal /app/app.cabal
RUN cabal install --only-dependencies

COPY src /app/src
RUN cabal install
