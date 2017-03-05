FROM centos:latest
MAINTAINER Abhijit N.
RUN yum update -y
RUN yum install git curl wget -y
RUN yum -y install epel-release && yum clean all
RUN yum -y install python-pip && yum clean all
RUN echo "UnaiF0zo" | passwd root --stdin
RUN cd /root
RUN git clone https://github.com/abhijitnavale/flask_unix_user.git
EXPOSE 5000
WORKDIR /flask_unix_user
RUN pip install -r /flask_unix_user/requirements.txt
RUN export LOGINPASSWORD="UnaiF0zo"
CMD python flask_app.py