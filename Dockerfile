FROM ibmcom/ace:11.0.0.5-amd64
ENV BAR1=API.bar 
#ENV OVERRIDE_FILE=override.properties
# Copy the override properties file to ace-server overrides directory
#COPY --chown=aceuser $OVERRIDE_FILE /home/aceuser/ace-server/overrides 
# Copy in the bar file to a temp directory
COPY --chown=aceuser $BAR1 /tmp
# Unzip the BAR file; need to use bash to make the profile work
RUN bash -c 'mqsibar -w /home/aceuser/ace-server -a /tmp/$BAR1 -c'
# Switch off the admin REST API for the server run, as we won't be deploying anything after start
RUN sed -i 's/adminRestApiPort/#adminRestApiPort/g' /home/aceuser/ace-server/server.conf.yaml
