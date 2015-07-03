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
	wget

# Install htseq-count from http
WORKDIR /user/local/
RUN wget --no-check-certificate https://pypi.python.org/packages/source/H/HTSeq/HTSeq-0.6.1p1.tar.gz
RUN tar -zxvf HTSeq-0.6.1p1.tar.gz
WORKDIR HTSeq-0.6.1p1/
RUN python setup.py install --user
RUN chmod +x scripts/htseq-count

# add htseq-count to path
ENV PATH /user/local/HTSeq-0.6.1p1/scripts:$PATH

# Cleanup
WORKDIR /
RUN rm -rf /user/local/HTSeq-0.6.1p1.tar.gz
RUN apt-get clean
