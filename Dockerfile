FROM ubuntu
# Install any required dependencies.
RUN apt install bash netcat-traditional
WORKDIR /
COPY script.sh /
CMD ["/script.sh"]
