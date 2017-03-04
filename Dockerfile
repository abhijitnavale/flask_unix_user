FROM centos:latest
MAINTAINER Abhijit N.
RUN yum update -y
RUN yum install git curl wget -y
RUN yum -y install epel-release && yum clean all
RUN yum -y install python-pip && yum clean all
RUN cd /root
RUN git clone https://github.com/abhijitnavale/flask_unix_user.git
RUN pip install -r requirements.txt
EXPOSE 5000
WORKDIR /root/flask_unix_user
CMD python flask_app.py