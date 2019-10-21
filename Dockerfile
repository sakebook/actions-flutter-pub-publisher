ARG channel=$INPUT_CHANNEL
FROM cirrusci/flutter:$channel

USER root

WORKDIR /home/cirrus

COPY entrypoint.sh /home/cirrus/entrypoint.sh

RUN env

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/home/cirrus/entrypoint.sh"]
