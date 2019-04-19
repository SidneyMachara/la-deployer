#!/bin/bash
# set timeout 10
echo_red(){
    echo -e "\e[1;31m$1\e[0m"
}
echo_green(){
    echo -e "\e[1;32m$1\e[0m"
}
echo_yellow(){
    echo -e "\e[1;33m$1\e[0m"
}
echo_blue(){
    echo -e "\e[1;34m$1\e[0m"
}
echo_purple(){
    echo -e "\033[1;95m$1\e[0m"
}
echo_white(){
    echo -e "\033[0;37m$1\e[0m"
}
#
# echo_purple 'Hi'
# echo_purple 'Sit back and let me do all the hard parts'
# echo_purple 'You lazy cunt'
# echo_white '--------------------------'
#
# echo
# echo_purple 'Updating server with (sudo apt-get update)'
# sudo apt-get update
#
# echo
# echo_purple 'installing Nginx'
# sudo apt-get -y install nginx
#
# echo
# echo_purple  'installing mysql-server'
# sudo apt-get -y install mysql-server
#
# echo
# echo_purple 'sudo mysql_secure_installation'
# echo_white 'What we will do:'
# echo_white 'Remove anonymous users (yes)'
# echo_white 'Disallow root login remotely (yes)'
# echo_white 'Remove test database (yes)'
# echo_white 'Reload privilege tables now (yes)'
# echo_purple '-------------------------'
# echo -e "n \ny \ny \ny \ny" | mysql_secure_installation
#
#
# echo
# echo_purple 'install php-7.2 && most commonly used modules'
# sudo apt-add-repository -y ppa:ondrej/php
# sudo apt-get update
# sudo apt-get -y install php7.2 php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-mysql php7.2-mbstring  php7.2-zip php7.2-fpm php7.2-xml composer unzip
# #sudo apt-get install php7.2 php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-mysql php7.2-mbstring php7.2-mcrypt php7.2-zip php7.2-fpm composer unzip



echo
echo_purple 'copying updated php.ini file (/la-deployer/php.ini /etc/php/7.2/fpm/php.ini) change made = (cgi.fix_pathinfo=0)'
sudo rm /etc/php/7.2/fpm/php.ini
cp /la-deployer/php.ini /etc/php/7.2/fpm/php.ini

echo
echo_purple 'restart php7.2-fpm'
sudo systemctl restart php7.2-fpm

exit
#if i can find sudo nano /etc/nginx/sites-available/default -->re install nginx
echo
echo 'copying updated /etc/nginx/sites-available/default'
cp /la-deployer/default /etc/nginx/sites-available/default

echo
echo 'making sure it is error free'
sudo nginx -t


echo
echo 'now to let it take effect you can restart Nginx'
sudo systemctl reload nginx

echo
echo 'restart nginx'
sudo service nginx restart

echo
echo 'Creating A Folder for Laravel'
sudo mkdir -p /var/www/laravel

echo
echo 'NOW WE CREATE SWAPFILE'

echo
echo 'create 1gb swap file '
sudo fallocate -l 1G /swapfile

echo
echo 'tell Ubuntu to format it as swap space'
sudo mkswap /swapfile

echo
echo 'now we start using it'
sudo swapon /swapfile


echo
echo 'INSTALLING COMPOSER'
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo
echo 'creating git repository in (/var/repo/site.git)'
cd /var
mkdir repo && cd repo

mkdir site.git && cd site.git
git init --bare

echo
echo 'Setting Up Git Hooks'
cd hooks

echo
echo 'copy post-receive file to /var/repo/site.git/hooks/'
cp /la-deployer/post-receive /var/repo/site.git/hooks/

echo
echo 'give post-recive file permissions to excute order to copy files over from git to sever'
sudo chmod +x post-receive

echo

echo "************************"
echo "************************"
echo
echo 'go to your application and add the remote below,, replace 0.0.0.0 with your server ip'
echo 'git remote add production ssh://root@0.0.0.0.0/var/repo/site.git'
echo 'AND FOR THE MAGICAL PART'
echo 'git push production master'
echo
echo "************************"
echo "************************"

echo
echo
read -p "DID YOU FOLLOW THE STEPS ABOVE ???" -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then

echo

#after pushing to server
echo
echo 'ALL DONE HERE (you can exit using (exit) command)'
cd /var/www/laravel/
composer install --no-dev

echo
echo 'give nginx permissionsover laravel directoy'
sudo chown -R :www-data /var/www/laravel
sudo chmod -R 775 /var/www/laravel/storage

sudo chmod -R 775 /var/www/laravel/bootstrap/cache

echo
echo 'YOUR TURN -->Database Setup'
echo 'YOU HAVE TO ATLEAST DO SOMETHING'
echo 'Relax ill help you'
echo
echo 'type --> mysql -u root -p" yourpassword"'
echo 'type --> CREATE DATABASE your_db_name;'
echo 'type --> exit'


#will automate this part after i figure out how to wait for user to finish to part
echo
echo 'creating env .file'
echo' type --> cd /var/www/laravel/'
echo 'type --> cp .env.example .env'

echo
echo 'type --> sudo nano /var/www/laravel/.env'
echo 'set up as you wish '
echo 'TIP 1 -> APP_DEBUG=false'
echo 'TIP 2 -> database name , password, user'
echo 'TIP 3 -> dont forget to put passwor in quotes ->"password"'
echo 'PRESS'
echo 'ctrl + x'
echo 'y'
echo 'enter'

echo 'generating app key'
echo 'type --> php artisan key:generate'

echo
echo 'type --> cd /var/www/laravel/config/app.php'
echo ' change --> "url" => "http://example.com" to "url" => "http://your_server_ip"'
echo 'PRESS'
echo 'ctrl + x'
echo 'y'
echo 'enter'

echo
echo 'running artisan config:cache'
echo 'type --> php artisan config:cache'

echo
echo 'running artisan migrate'
echo 'type -->php artisan migrate'


echo 'ALL DONE'

fi
