FROM ubuntu:18.04

# Install supervisor
RUN apt-get update && apt-get install -y supervisor && apt-get clean

# Download and install Factom
ADD https://github.com/FactomProject/distribution/releases/download/v6.1.0/factom-amd64.deb factom.deb
RUN dpkg -i factom.deb

# Copy configs
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY factomd.conf /root/.factom/m2/

# Expose ports used, Factomd: 8088, FactomWalletd:8089, Factom controlpanel: 8090
EXPOSE 8088 8089 8090

CMD ["/usr/bin/supervisord"]
