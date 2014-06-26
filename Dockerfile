FROM docker-registry.usersys.redhat.com/brew/rhel6:latest 
MAINTAINER "Christoph Görn" <goern@redhat.com>

# add an entitlement for RHEL6
ADD ./container-etc/pki/entitlement/6794074734086527579-key.pem /etc/pki/entitlement/
ADD ./container-etc/pki/entitlement/6794074734086527579.pem /etc/pki/entitlement/
ADD ./container-etc/rhsm/ca/redhat-uep.pem /etc/rhsm/ca/

# update to the latest RHEL6 version
RUN subscription-manager repos --disable rhel-ha-for-rhel-6-server-rpms ; subscription-manager repos --disable rhel-lb-for-rhel-6-server-rpms ; subscription-manager repos --enable rhel-6-server-sam-rpms
RUN yum -y update; yum clean all

# install! 
#RUN yum install -y candlepin candlepin-tomcat6 candlepin-scl-runtime
 

