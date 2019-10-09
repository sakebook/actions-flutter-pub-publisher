FROM cirrusci/flutter:stable

USER root

WORKDIR /home/cirrus

COPY entrypoint.sh /home/cirrus/entrypoint.sh

ENTRYPOINT ["sh", "entrypoint.sh"]
