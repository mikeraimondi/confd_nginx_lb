FROM nginx:1.9.3

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "wget"]
WORKDIR /usr/local/bin
RUN ["wget", "-Oconfd", "https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64"]
RUN ["chmod", "+x", "confd"]
RUN ["mkdir", "-p", "/etc/nginx/sites-enabled"]
COPY nginx.toml /etc/confd/conf.d/
COPY nginx.tmpl /etc/confd/templates/
COPY nginx.conf /etc/nginx/
COPY confd-watch /usr/local/bin/

CMD /usr/local/bin/confd-watch
