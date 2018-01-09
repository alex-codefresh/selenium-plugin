FROM ubuntu:16.04 AS build

WORKDIR /Selenium

RUN apt-get -y update && apt-get -y install python-pip wget && \
    pip install -U Selenium && \
    wget https://github.com/mozilla/geckodriver/releases/download/v0.17.0/geckodriver-v0.17.0-linux64.tar.gz && \
    mkdir geckodriver && \
    tar xvzf geckodriver-v0.17.0-linux64.tar.gz -C geckodriver


FROM ubuntu-debootstrap


RUN apt-get -y update && apt-get -y install firefox \
    xvfb \
    python-minimal && \
    apt-get autoclean && apt-get clean

COPY --from=build /usr/local/lib/python2.7/dist-packages /usr/local/lib/python2.7/dist-packages
COPY --from=build /Selenium/geckodriver/* /usr/bin/
COPY ./scripts /Selenium/scripts

ENTRYPOINT ["/Selenium/scripts/init.sh"]
