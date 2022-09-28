FROM amazon/aws-sam-cli-build-image-ruby2.7

WORKDIR /tmp

RUN yum install -y unzip && \
    curl -SL https://chromedriver.storage.googleapis.com/2.42/chromedriver_linux64.zip > chromedriver.zip && \
    curl -SL https://github.com/adieuadieu/serverless-chrome/releases/download/v1.0.0-53/stable-headless-chromium-amazonlinux-2017-03.zip > headless-chromium.zip && \
    unzip chromedriver.zip && \
    unzip headless-chromium.zip

RUN yum install -y libX11

CMD cp /tmp/chromedriver /opt/bin/ && \
    cp /tmp/headless-chromium /opt/bin/ && \
    # chromium
    cp /usr/lib64/libexpat.so.1 /opt/lib/ && \
    cp /usr/lib64/libuuid.so.1 /opt/lib/ && \
    # chromedriver
    cp /usr/lib64/libglib-2.0.so.0 /opt/lib/ && \
    cp /usr/lib64/libX11.so.6 /opt/lib/ && \
    cp /usr/lib64/libxcb.so.1 /opt/lib/ && \
    cp /usr/lib64/libXau.so.6 /opt/lib/