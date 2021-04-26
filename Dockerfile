# Use python3.9 base image
FROM python:3.9-slim-buster

# we don't have an interactive Term
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /ilham-mansiez-petercord/

# http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt -qq update && apt -qq upgrade -y
RUN apt -qq install -y --no-install-recommends \
    apt-utils \
    aria2 \
    bash \
    build-essential \
    curl \
    figlet \
    ffmpeg \
    g++ \
    gcc \
    git \
    gnupg2 \
    jq \
    libpq-dev \
    libssl-dev \
    libxml2 \
    megatools \
    neofetch \
    postgresql \
    pv \
    sudo \
    unar \
    unzip \
    wget \
    zip

# Install google chrome
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    apt-get -qq update && apt-get -qq install -y google-chrome-stable

# Install chromedriver
RUN wget -N https://chromedriver.storage.googleapis.com/87.0.4280.88/chromedriver_linux64.zip -P ~/ && \
    unzip ~/chromedriver_linux64.zip -d ~/ && \
    rm ~/chromedriver_linux64.zip && \
    mv -f ~/chromedriver /usr/bin/chromedriver && \
    chown root:root /usr/bin/chromedriver && \
    chmod 0755 /usr/bin/chromedriver

# Install python requirements
ADD https://raw.githubusercontent.com/ilham77mansiz/-PETERCORD-/Petercord-Userbot/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

CMD ["bash"]
