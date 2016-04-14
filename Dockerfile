FROM ubuntu:14.04
MAINTAINER Simon Breiter hello@simonbreiter.ch

# Get newest updates and install software
RUN apt-get update
RUN apt-get -y install python3-pip
RUN apt-get -y build-dep python-imaging
RUN apt-get -y install libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev

# Create folder
RUN mkdir -p /var/www/place-puppy/
# Copy content
COPY . /var/www/place-puppy/
# Set workdir
WORKDIR /var/www/place-puppy/

# Install dependencies
RUN pip3 install -r requirements.txt

# Run Gunicorn
CMD [ "gunicorn", "--bind", "0.0.0.0:8000", "wsgi:app" ]
