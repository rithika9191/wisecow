
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/games:${PATH}"
WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fortune-mod \
    fortunes-min \
    cowsay \
    netcat-openbsd \
    bash && \
    rm -rf /var/lib/apt/lists/*

COPY wisecow.sh .

RUN chmod +x wisecow.sh && \
    useradd -m -u 10001 wisecow && \
    chown -R wisecow:wisecow /app

USER wisecow

EXPOSE 4499

CMD ["./wisecow.sh"]
