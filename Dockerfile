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
RUN yum install -y candlepin candlepin-tomcat6 candlepin-scl-runtime
ADD ./container-etc/candlepin/candlepin.conf /etc/candlepin/
ADD ./container-etc/candlepin/certs/candlepin-ca.key /etc/candlepin/certs/
ADD ./container-etc/candlepin/certs/candlepin-ca.crt /etc/candlepin/certs/
RUN chgrp tomcat /etc/candlepin/certs/candlepin-ca.*; chmod g+r /etc/candlepin/certs/candlepin-ca.*

EXPOSE 8080

# FIXME this seems to be dirty hack
CMD service tomcat6 start && tail -f /var/log/tomcat6/catalina.out
