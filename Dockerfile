FROM python:3-onbuild
MAINTAINER Simon Breiter hello@simonbreiter.ch

RUN mkdir -p /var/www/place-puppy/
ADD . /var/www/place-puppy/
WORKDIR /var/www/place-puppy/

CMD [ "gunicorn", "--bind", "0.0.0.0:8000", "wsgi:app" ]
