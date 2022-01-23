FROM ubuntu
# Install any required dependencies.
RUN apt install ca-certificates bash netcat-traditional
WORKDIR /
COPY script.sh /
CMD ["/script.sh"]
