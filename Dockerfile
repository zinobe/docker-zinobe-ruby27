FROM ruby:latest

RUN apt-get update && \
    apt-get install -y \
      wget \
      make \
      gcc \
      ruby-dev \
      default-libmysqlclient-dev

# Install AWS SSM
RUN wget https://github.com/Droplr/aws-env/raw/v0.4/bin/aws-env-linux-amd64 -O /bin/aws-env && \
  chmod +x /bin/aws-env

# Install Supervisor
RUN apt-get install -y supervisor

COPY supervisord.conf /etc/supervisor/supervisord.conf

# Create user and group
RUN groupadd -g 1000 www && useradd -u 1000 -g www www

RUN mkdir /www && touch /www/docker-volume-not-mounted && chown www:www /www
WORKDIR /www

RUN apt-get autoremove -y

RUN ln -s /usr/local/bin/ruby /usr/bin/ruby2.7

# Supervisor will run gunicorn or celery
CMD ["supervisord", "-n", "-c", "|"]
