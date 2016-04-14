FROM ubuntu:14.04
MAINTAINER Simon Breiter hello@simonbreiter.ch

# Get newest updates
RUN apt-get -y update
# Install pip3
RUN apt-get -y install python3-pip
# Install PIL dependencies
RUN apt-get -y build-dep python-imaging
RUN apt-get -y install libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev
# Install curl
RUN apt-get install -y curl
# Install nodejs and npm
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
# Install Ruby
RUN apt-get -y install ruby
# Install sass
RUN gem install sass
# Install gulp
RUN npm install -g gulp-cli

# Create folder
RUN mkdir -p /var/www/place-puppy/
# Copy content
COPY . /var/www/place-puppy/
# Set workdir
WORKDIR /var/www/place-puppy/

# Install dependencies
RUN pip3 install -r requirements.txt
RUN npm install

# Fix weird ubuntu node-sass behavior
RUN npm install -g node-sass
RUN npm rebuild node-sass

# Build project
RUN gulp dist


# Run
CMD [ "gunicorn", "--bind", "0.0.0.0:8000", "wsgi:app" ]
