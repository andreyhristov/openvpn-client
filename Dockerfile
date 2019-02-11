FROM alpine:3.9

RUN apk --update --no-cache add \
    lynx \
    wget \
    zip \
    unzip \
    iputils \
    busybox-extras \
    net-tools \
    bash \
    openssh-server \
    openvpn


RUN adduser -D -u 1000 local && echo 'local:1234' | chpasswd
RUN mkdir -p /var/run/sshd 

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN sed -i 's/AllowTcpForwarding no/AllowTcpForwarding yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
