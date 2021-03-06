# Dockerfile to build htseq-count container images
# Based on Ubuntu

# Set the base image to Ubuntu
FROM ubuntu:latest

# File Author / Maintainer
MAINTAINER Douglas McCloskey <dmccloskey87@gmail.com>

# Install dependencies and wget
RUN apt-get update && apt-get install -y build-essential \
	python2.7-dev \
	python-numpy \
	python-matplotlib \
	wget \
	python-pip

# Install htseq-count from http
WORKDIR /usr/local/
RUN wget --no-check-certificate https://pypi.python.org/packages/source/H/HTSeq/HTSeq-0.6.1p1.tar.gz
RUN tar -zxvf HTSeq-0.6.1p1.tar.gz
WORKDIR HTSeq-0.6.1p1/
RUN python setup.py install
RUN chmod +x scripts/htseq-count
RUN chmod +x scripts/htseq-qa

## Install htseq-count python dependencies using pip
#RUN pip install --upgrade pip
#RUN pip install --no-cache-dir HTSeq

# add htseq-count to path
ENV PATH /usr/local/HTSeq-0.6.1p1/scripts:$PATH

# Cleanup
RUN rm -rf /usr/local/HTSeq-0.6.1p1.tar.gz
RUN apt-get clean

# Create an app user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
    && chmod -R u+rwx $HOME \
    && chown -R user:user $HOME

WORKDIR $HOME
USER user
