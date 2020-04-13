FROM alpine

ENV PASSWORD "dontletitlikethat"
ENV USER_ID 1000
ENV GROUP_ID 1001

RUN addgroup -g ${GROUP_ID} openldap \
    && adduser -u ${USER_ID} -G openldap -H -D -S openldap
RUN apk add --no-cache --purge --clean-protected -u openldap openldap-clients openldap-back-mdb openldap-overlay-memberof openldap-overlay-refint

RUN mkdir /tmp/ldif
ADD ldif/*.ldif /tmp/ldif/

EXPOSE 389
EXPOSE 636

# VOLUME /ssl
VOLUME /etc/openldap
VOLUME /var/lib/openldap

ADD slapd.conf /etc/openldap/slapd.conf
ADD start.sh /

CMD ["/start.sh"]