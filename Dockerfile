FROM ubuntu:18.04

WORKDIR /app

RUN apt-get update \
 && apt-get install -y git qtcreator qtmultimedia5-dev libqt5svg5-dev \
                       libboost-dev libssl-dev libboost-system-dev \
                       qt5-default

ENV REPO="https://github.com/fourtf/chatterino2.git" \
    BRANCH="v2.0.4"

RUN git clone --recursive --depth 1 --branch $BRANCH $REPO .

RUN mkdir build \
 && cd build \
 && qmake .. \
 && make

# ----

FROM ubuntu:18.04

RUN apt-get update \
 && apt-get install -y libssl1.1 libboost-system1.65.1 libqt5widgets5 \
                       libqt5multimedia5 xpra tzdata \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists /var/cache/apt

RUN adduser user \
 && mkdir /logs \
 && chown user:user /logs

USER user

COPY --from=0 /app/build/bin/chatterino /usr/bin/chatterino

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["chatterino"]