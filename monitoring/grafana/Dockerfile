FROM grafana/grafana:latest
USER root
RUN mkdir -p /etc/grafana/provisioning
COPY ./provisioning /etc/grafana/provisioning
EXPOSE 3000
