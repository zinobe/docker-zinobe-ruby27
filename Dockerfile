FROM ruby:2.7.1

RUN apt update && \
    apt install -y \
      wget \
      make \
      gcc \
      ruby-dev \
      default-libmysqlclient-dev \
      cron \
      supervisor

# Install AWS SSM
RUN wget https://github.com/Droplr/aws-env/raw/v0.4/bin/aws-env-linux-amd64 -O /bin/aws-env && \
  chmod +x /bin/aws-env

COPY supervisord.conf /etc/supervisor/supervisord.conf

# Create user and group
RUN groupadd -g 1000 www && useradd -u 1000 -g www www

RUN mkdir /www && touch /www/docker-volume-not-mounted && chown www:www /www
WORKDIR /www

RUN apt-get autoremove -y

CMD ["supervisord", "-n", "-c", "|"]
