FROM openjdk:11.0.5-stretch

WORKDIR /srv/workdir

RUN apt-get update && \
	apt-get install -y \
		software-properties-common \
		build-essential \
		checkinstall \
		nano \
		libpng-dev \
		zlib1g-dev \
		libffi-dev \
		libreadline-gplv2-dev \
		libncursesw5-dev \
		libssl-dev \
		libsqlite3-dev \
		tk-dev \
		libgdbm-dev \
		libc6-dev \
		libbz2-dev \
		zlib1g-dev \
		openssl \
		libffi-dev \
		python3-dev \
		python3-setuptools \
		wget \
		curl \
		openssl \
		python2.7

# install openssl to fix python 3.7 ssl issue
RUN mkdir /usr/src/openssl \
	&& cd /usr/src/openssl \
	&& wget https://www.openssl.org/source/openssl-1.0.2q.tar.gz \
	&& tar xvf openssl-1.0.2q.tar.gz \
	&& cd /usr/src/openssl/openssl-1.0.2q \
	&& ./config \
	&& make \
	&& make install

# install Python 3.7.4
RUN cd /usr/src \
	&& wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
	&& tar xzf Python-3.7.4.tgz \
	&& cd Python-3.7.4 \
	&& ./configure --enable-optimizations \
	&& make altinstall

# fix symlinks
RUN rm -f /usr/bin/python3 \
	&& ln -s /usr/local/bin/python3.7 /usr/bin/python3 \
	&& mv /usr/bin/lsb_release /usr/bin/lsb_release_back

# install pip and pip3
RUN cd /usr/src \
	&& curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
	&& python3 get-pip.py --force-reinstall \
	&& python get-pip.py

COPY ./requirements.txt /srv/requirements.txt

RUN pip3 install -r /srv/requirements.txt
RUN pip install awscli==1.16.294

COPY ./ipa-1.0.0-M2 /srv/ipa-1.0.0-M2

RUN chmod -R +x /srv/ipa-1.0.0-M2/bin/

ENV PATH "$PATH:/srv/ipa-1.0.0-M2/bin/"
