#!/bin/bash
#cd /home/ubuntu/appjs
#sudo npm install
#npm start
export DB_HOST=mongodb://34.240.165.8:27017/posts
#if npm install did not install the posts db use command:
#node seeds/seed.js
sudo npm install
npm start
