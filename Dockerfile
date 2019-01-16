FROM node:8.15.0-stretch-slim

# I can be root if I want, MOM!
ENV METEOR_ALLOW_SUPERUSER=true
ENV PORT 3000


# add packages for building NPM modules (required by Meteor)
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  build-essential \
  git \
  python \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# install Meteor
RUN curl https://install.meteor.com/ | sh
RUN meteor --version

# run Meteor from the app directory
WORKDIR /app

# application code - mount project root there
VOLUME /app
# meteor user home - optionally mount to cache meteor files between builds
VOLUME /root/.meteor

EXPOSE ${PORT}
CMD [ "meteor", "--verison" ]
