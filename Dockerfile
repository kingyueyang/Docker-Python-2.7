FROM centos:6.6
MAINTAINER Yang Yue

ENV PATH /opt/Python-2.7.8/bin:$PATH
ENV LANG en_US.UTF-8
ENV PYTHON_VERSION 2.7.8
ENV PYTHON_PIP_VERSION 9.0.1

# runtime dependencies
RUN yum install -y gcc wget xz tar zlib zlib-devel openssl-devel.x86_64 \
	&& cd / \
	&& wget https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tar.xz \
	&& xz -kvd Python-2.7.8.tar.xz \
	&& tar xvf Python-2.7.8.tar \
	&& cd Python-2.7.8 \
	&& ./configure  --prefix=/opt/Python-2.7.8 \
	&& make -j2 \
	&& make install \
	&& rm -rf /Python-2.7.8

RUN cd / \
	&& wget https://pypi.python.org/packages/25/4e/1b16cfe90856235a13872a6641278c862e4143887d11a12ac4905081197f/setuptools-28.8.0.tar.gz \
	&& tar zxvf setuptools-28.8.0.tar.gz \
	&& cd setuptools-28.8.0 \
	&& python setup.py install \
	&& rm -rf /setuptools-28.8.0

RUN cd / \
	&& wget https://pypi.python.org/packages/11/b6/abcb525026a4be042b486df43905d6893fb04f05aac21c32c638e939e447/pip-9.0.1.tar.gz \
	&& tar zxvf pip-9.0.1.tar.gz \
	&& cd pip-9.0.1 \
	&& python setup.py install \
	&& rm -rf /pip-9.0.1

# install "virtualenv", since the vast majority of users of this image will want it
RUN pip install --no-cache-dir virtualenv

WORKDIR  /root

CMD ["/bin/bash"]
