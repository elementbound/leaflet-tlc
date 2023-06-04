FROM node:18-alpine

ARG APP_USER=node
ARG APP_HOME=/opt/tlc
ARG APP_EXECUTABLE=dist/tlc-main.js
ENV ENV_APP_EXECUTABLE=$APP_EXECUTABLE

RUN mkdir -p $APP_HOME
ADD node_modules $APP_HOME/node_modules
ADD dist/package.json $APP_HOME/package.json
ADD dist/build-time.json $APP_HOME/build-time.json
ADD dist/src $APP_HOME/dist/

WORKDIR $APP_HOME
RUN chmod 744 $APP_HOME
RUN chmod 744 $APP_EXECUTABLE
RUN chown -R $APP_USER:$APP_USER $APP_HOME

ENTRYPOINT NODE_OPTIONS=${NODE_OPTIONS} NODE_ENV=${NODE_ENV} NODE_CONFIG_DIR=${NODE_CONFIG_DIR} node ./$ENV_APP_EXECUTABLE
