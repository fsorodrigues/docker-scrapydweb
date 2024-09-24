FROM python:3.11-alpine
LABEL maintainer="Felippe Rodrigues"
LABEL description="Web app for Scrapyd cluster management, Scrapy log analysis & visualization, Auto packaging, Timer tasks, Monitor & Alert, and Mobile UI. Originally created by Zentek Servicios Tecnologicos, forked for the sole pupose of bumping the Python versio Originally created by Zentek Servicios Tecnologicos, forked for the sole pupose of bumping the Python version."

ENV PYTHONUNBUFFERED 1

RUN set -ex && apk --no-cache --virtual .build-deps add build-base g++ bash curl gcc libgcc tzdata psutils linux-headers openssl-dev postgresql-dev libffi-dev libxml2-dev libxslt-dev

RUN ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
RUN echo "Pacific/Auckland" > /etc/timezone

RUN pip install pip==24.2
RUN pip install scrapydweb==1.5.0
RUN pip install psycopg2

RUN mkdir /scrapyd
COPY scrapydweb_settings_v10.py /scrapyd/
WORKDIR /scrapyd/

EXPOSE 5000

ENTRYPOINT ["scrapydweb"]
