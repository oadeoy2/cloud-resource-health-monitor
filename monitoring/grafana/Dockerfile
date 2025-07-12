FROM grafana/grafana:latest
USER root

RUN mkdir -p /etc/grafana/provisioning
COPY ./provisioning /etc/grafana/provisioning

ENV GF_SECURITY_ADMIN_USER=admin
ENV GF_SECURITY_ADMIN_PASSWORD=password123
ENV GF_METRICS_ENABLED=true
ENV GF_METRICS_ENDPOINT_ENABLED=true
ENV GF_METRICS_ENDPOINT=/metrics


EXPOSE 3000
