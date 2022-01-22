FROM alpine
# Install any required dependencies.
RUN apk --no-cache add ca-certificates bash netcat-openbsd
WORKDIR /
COPY script.sh /
CMD ["/script.sh"]
