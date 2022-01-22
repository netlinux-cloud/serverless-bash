FROM alpine
# Install any required dependencies.
RUN apk --no-cache add ca-certificates
WORKDIR /
# Copy the binary from the builder stage and set it as the default command.
COPY script.sh /
CMD ["/script.sh"]
