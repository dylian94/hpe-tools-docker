FROM redhat/ubi9
USER root

RUN dnf --assumeyes install wget

ADD http://downloads.linux.hpe.com/SDR/add_repo.sh /root/add_repo.sh
RUN chmod +x /root/add_repo.sh
RuN /root/add_repo.sh -d RedHat -r 9 -a x86_64 hpsum
RUN /root/add_repo.sh -d RedHat -r 9 -a x86_64 spp-gen10

RUN dnf --assumeyes install hpsum
RUN dnf --assumeyes install amsd storcli ssa ssacli ssaducli
RUN dnf clean all

ADD ./start.sh /start.sh
RUN chmod +x /start.sh

# Change root password to "password"
RUN echo 'root:password' | chpasswd

EXPOSE 63001 63002 9111

ENTRYPOINT [ "./start.sh" ]

HEALTHCHECK --interval=5m --timeout=5s \
    CMD curl -fk https://127.0.0.1:63002 &>/dev/null && echo "Ok" || echo "No Connection" && exit 1