FROM alpine
# Install any required dependencies.
RUN apk --no-cache add ca-certificates ncat
WORKDIR /
COPY script.sh /
CMD ["/script.sh"]
