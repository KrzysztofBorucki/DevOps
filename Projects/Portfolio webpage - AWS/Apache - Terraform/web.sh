#!/bin/bash
yum install wget unzip httpd -y
systemctl start httpd
systemctl enable httpd
wget https://github.com/KrzysztofBorucki/DevOps/raw/master/Project1/Portfolio_grey.zip
unzip -o Portfolio_grey.zip
cp -r Portfolio_grey/* /var/www/html/
systemctl restart httpd
