#!/bin/bash
cd /home/ubuntu/appjs
sudo npm install
#npm start
#export DB_HOST=mongodb://18.202.218.255:27017/posts
export DB_HOST=mongodb://10.0.2.118:27017/posts
#if npm install did not install the posts db use command:
node seeds/seed.js
#sudo npm install
npm start
