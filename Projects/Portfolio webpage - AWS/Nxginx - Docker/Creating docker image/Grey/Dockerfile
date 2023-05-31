FROM alpine:3.14 AS downloader
RUN apk add --no-cache wget
WORKDIR /html
RUN wget https://github.com/KrzysztofBorucki/DevOps/raw/master/Project1/Portfolio_grey.tar.gz
RUN tar -xzf Portfolio_grey.tar.gz

FROM nginx
RUN apt update
RUN apt install apache2-utils -y
COPY --from=downloader /html/Portfolio_grey /usr/share/nginx/html
#COPY nginx.conf /etc/nginx/nginx.conf
RUN touch /var/log/nginx/access.log && chmod 666 /var/log/nginx/access.log
RUN htpasswd -cb /etc/nginx/.htpasswd user password
RUN sed -i '/^#.*\.well-known/ s/# //' /etc/nginx/nginx.conf
#COPY ssl/certificate.crt /etc/nginx/certificate.crt
#COPY ssl/certificate.key /etc/nginx/certificate.key
#RUN sed -i 's/#*listen 443 ssl/list
EXPOSE 80
