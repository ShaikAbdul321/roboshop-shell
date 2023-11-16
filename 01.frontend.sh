echo -e "\e[33m Installing Nginx Server\e[0m"
yum install nginx -y &>>/tmp/frontend.log
echo -e "\e[33m Removing default Nginx content\e[0m"
cd /usr/share/nginx/html
rm -rf * &>>/tmp/frontend.log
echo -e "\e[33m Download New Content to Nginx\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/frontend.log
unzip frontend.zip &>>/tmp/frontend.log
rm -rf frontend.zip
echo -e "\e[33m Configuring reverse proxy server\e[0m"
cp /root/roboshop-shell/roboshop.conf  /etc/nginx/default.d/roboshop.conf
echo -e "\e[33m Enabling and starting the Nginx server\e[0m"
systecmtl enable nginx &>>/tmp/frontend.log
systemctl restart nginx



