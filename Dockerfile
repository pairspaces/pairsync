FROM python:3.11-alpine
RUN apk --update --no-cache add git aws-cli
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]