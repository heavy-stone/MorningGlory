# myapp/web/Dockerfile

# Debianがベースのrubyイメージを指定
FROM ruby:2.5.1

# 必要なものをインストール
RUN apt-get update -qq && apt-get -y install \
    build-essential \
    libpq-dev \
    nodejs \
    mysql-client \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# rails用のディレクトリを作成
RUN mkdir /myapp
WORKDIR /myapp

# ローカルマシン(Mac)からコンテナの中にファイルをコピー
COPY Gemfile /myapp
COPY Gemfile.lock /myapp

# 上でコピーしたGemfileに従ってGemをインストール
RUN bundle install
