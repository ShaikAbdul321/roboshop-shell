echo -e "\e[32m Downloading NodeJs Repo\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/catalogue.log
echo -e "\e[32m Installing Nodejs Server\e[0m"
yum install nodejs -y &>> /tmp/catalogue.log
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m Downloading New App content and dependencies\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> /tmp/catalogue.log
unzip catalogue.zip &>> /tmp/catalogue.log
rm -rf catalogue.zip &>> /tmp/catalogue.log
npm install &>> /tmp/catalogue.log
echo -e "\e[32m Creating Catalogue service\e[0m"
cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[32m Downloading and installing the mongodb schema\e[0m"
cp /root/roboshop-shell/mongodb.repo  /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y &>> /tmp/catalogue.log
mongo --host mongodb-dev.shaik.website </app/schema/catalogue.js  &>> /tmp/catalogue.log
echo -e "\e[32m Enabling and starting the catalogue service\e[0m"
systemctl daemon-reload &>> /tmp/catalogue.log
systemctl enable catalogue &>> /tmp/catalogue.log
systemctl restart catalogue



