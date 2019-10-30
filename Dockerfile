FROM httpd

# Update package lists and install dependencies
RUN apt-get update -y && apt-get install -y libtinfo5 procps

# Install vulnerable bash
COPY bash_4.2+dfsg-0.1_amd64.deb /tmp/bash_4.2+dfsg-0.1_amd64.deb
RUN dpkg -i /tmp/bash_4.2+dfsg-0.1_amd64.deb

# Enable httpd and cgi scripts
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY index.html /usr/local/apache2/htdocs/
COPY toucan /usr/local/apache2/cgi-bin/
RUN chmod +x /usr/local/apache2/cgi-bin/toucan

# Hide the "flag"
COPY toucan.jpg /usr/local/apache2/htdocs/T0UC4N.jpg