# The official Canonical Ubuntu Focal image is ideal from a security perspective,
# especially for the enterprises that we, the RabbitMQ team, have to deal with
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    make \ 
    gcc \
    curl \
    tar \
    vim \
    lsof \
    && rm -rf /var/lib/apt/lists/*

ADD https://libiec61850.com/wp-content/uploads/2022/03/libiec61850-1.5.1.tar.gz /service/libiec61850-1.5.1.tar.gz
RUN tar -xvf /service/libiec61850-1.5.1.tar.gz -C /service/
RUN rm /service/libiec61850-1.5.1.tar.gz
RUN make -j 4 -C service/libiec61850-1.5.1/examples/server_example_basic_io all target=LINUX
EXPOSE 102/tcp
ENTRYPOINT ["service/libiec61850-1.5.1/examples/server_example_basic_io/server_example_basic_io", "&"]
