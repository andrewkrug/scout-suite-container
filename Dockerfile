FROM amazonlinux:2.0.20201218.1

RUN yum update -y > /dev/null 2>&1

RUN yum install -y \
python3 \
python3-devel \
python3-pip \
shadow-utils \
gcc-c++ \
gcc \
unzip \
gnupg \
lsb-release \
vim \
dialog \ 
curl \
cmake \
openssl \
openssl-devel \
python-virtualenv

RUN yum clean headers && yum clean metadata && yum clean all

RUN useradd -ms /bin/bash scoutsuite
USER scoutsuite
WORKDIR /home/scoutsuite
ADD requirements.txt .
RUN virtualenv scoutsuite -p python3
RUN pip3 install --user awscliv2
RUN bash -c 'source scoutsuite/bin/activate && \
python3 -m pip install --upgrade setuptools && \
pip3 install grpcio==1.18.0 && \
pip3 install awscliv2 && \
pip3 install -r requirements.txt && \
pip3 install scoutsuite==5.10.2'

RUN echo "echo -e \"Welcome to ScoutSuite!\nTo run ScoutSuite, just type scout -h to see the help documentation. Have fun!\"" >> /home/scoutsuite/.bashrc
RUN echo -e "export PATH=$PATH:/home/scoutsuite/.local/bin" >> /home/scoutsuite/.bashrc
RUN echo -e "source scoutsuite/bin/activate" >> /home/scoutsuite/.bashrc