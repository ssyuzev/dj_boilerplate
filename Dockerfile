FROM python3.8

# prep
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# init
RUN mkdir /webapp
WORKDIR /webapp

# setup
RUN apt update \
    && apt upgrade -y \
    && apt install -y \
    build-essential \
    postgresql-client \
    gettext \
    jpeg-dev \
    zlib-dev \
    graphviz \
    graphviz-dev \
    ttf-freefont

ADD requirements/ /requirements/
RUN python3 -m pip install -U pip && python3 -m pip install -Ur /requirements/dev.txt

# Run bash script for waiting for db
COPY wait-for-postgres.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wait-for-postgres.sh

ADD . /webapp/
