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
#
#
#
# echo
# echo_purple 'copying updated php.ini file (/la-deployer/php.ini /etc/php/7.2/fpm/php.ini) change made = (cgi.fix_pathinfo=0)'
# sudo rm /etc/php/7.2/fpm/php.ini
# cp php.ini /etc/php/7.2/fpm/php.ini
#
# echo
# echo_purple 'restart php7.2-fpm'
# sudo systemctl restart php7.2-fpm
#
#
# #if i can find sudo nano /etc/nginx/sites-available/default -->re install nginx
# echo
# echo_purple 'copying updated /etc/nginx/sites-available/default'
# sudo rm /etc/nginx/sites-available/default
# cp default /etc/nginx/sites-available/default
#
# echo
# echo_purple 'making sure it is error free'
# sudo nginx -t
#
#
#
# echo
# echo_purple 'now to let it take effect you can restart Nginx'
# sudo systemctl reload nginx
#
# sudo service nginx restart
#
#
#
# echo
# echo_purple 'Creating A Folder for Laravel in (/var/www/laravel)'
# sudo mkdir -p /var/www/laravel
#
#
# echo
# echo_purple 'NOW WE CREATE SWAPFILE'
#
# echo
# echo_purple 'create 1gb swap file '
# sudo fallocate -l 1G /swapfile
#
# echo
# echo_purple 'tell Ubuntu to format it as swap space'
# sudo mkswap /swapfile
#
# echo
# echo_purple 'now we start using it'
# sudo swapon /swapfile
#
#
# echo
# echo_purple 'INSTALLING COMPOSER'
# cd ~
# curl -sS https://getcomposer.org/installer | php
# sudo mv composer.phar /usr/local/bin/composer
#
# echo
# echo_purple 'creating git repository in (/var/repo/site.git)'
# cd /var
# mkdir repo && cd repo
#
# mkdir site.git && cd site.git
# git init --bare
#
# echo
# echo_purple 'Setting Up Git Hooks'
# cd hooks
#
# echo
# echo_purple 'copy post-receive file to /var/repo/site.git/hooks/'
# cp ~/la-deployer/post-receive /var/repo/site.git/hooks/
#
# echo
# echo_purple 'give post-recive file permissions to excute order to copy files over from git to sever'
# sudo chmod +x /var/repo/site.git/hooks/post-receive

echo

echo_white "************************"
echo_white "************************"
echo
echo_yellow 'go to your application and add the remote below,, replace 0.0.0.0 with your server ip'
echo_yellow 'git remote add production ssh://root@0.0.0.0.0/var/repo/site.git'
echo_yellow 'AND FOR THE MAGICAL PART'
echo_purple 'git push production master'
echo
echo_white "************************"
echo_white "************************"

echo
echo

set timeout 10

echo
while true; do

  read -p "HAVE YOU COMPLETE THE INSTUCTIONS ABOVE? (y|Y for yes)" yn

  case $yn in
  [Yy]* )
      #after pushing local app to server

      echo
      cd /var/www/laravel
      echo_purple 'composer install --no-dev'
      composer install --no-dev

      echo
      echo_purple 'creating env .file'
      cp /var/www/laravel/.env.example /var/www/laravel/.env

      echo_purple 'generating app key'
      php artisan key:generate

      echo
      echo_purple 'give nginx permissionsover laravel directoy'
      sudo chown -R :www-data /var/www/laravel
      sudo chmod -R 775 /var/www/laravel/storage
      sudo chmod -R 775 /var/www/laravel/bootstrap/cache

      echo
      echo_white "************************"
      echo_white "************************"
      echo
      echo_purple 'YOUR TURN -->Database Setup'
      echo_purple 'YOU HAVE TO ATLEAST DO SOMETHING'
      echo_purple 'Relax ill help you'
      echo
      echo_white "************************"
      echo_white "************************"
      echo

      echo_white "************************"
      echo_white "************************"
      echo
      echo_purple 'type --> mysql -u root -p" yourpassword"'
      echo_purple 'type --> CREATE DATABASE your_db_name;'
      echo_purple 'type --> exit'
      echo
      echo_white "************************"
      echo_white "************************"

      #will automate this part after i figure out how to (:P)

      echo
      echo_white "************************"
      echo_white "************************"
      echo
      echo_purple 'type --> sudo nano /var/www/laravel/.env'
      echo_purple 'set up as you wish '
      echo_purple 'TIP 1 -> APP_DEBUG=false'
      echo_purple 'TIP 2 -> change --> database (name , password, user)'
      echo_purple 'TIP 3 -> dont forget to put password in quotes ->"password"'
      echo_purple 'SAVE'
      echo
      echo_white "************************"
      echo_white "************************"




      echo
      echo_white "************************"
      echo_white "************************"
      echo
      echo_purple 'type --> cd /var/www/laravel/config/app.php'
      echo_purple ' change --> "url" => "http://example.com" to "url" => "http://your_server_ip"'
      echo_purple 'SAVE'
      echo
      echo_white "************************"
      echo_white "************************"

      echo
      echo_white "************************"
      echo_white "************************"
      echo
      echo_purple 'running artisan config:cache'
      echo_purple 'type --> php artisan config:cache'
      echo
      echo_purple 'running artisan migrate'
      echo_purple 'type -->php artisan migrate'
      echo
      echo_white "************************"
      echo_white "************************"



      echo_white 'ALL DONE'

      break;;

# [Nn]* ) exit;;

  * ) echo  "PLEASE COMPLETE AND ANSWER --> HAVE YOU COMPLETE THE INSTUCTIONS ABOVE? (y|Y for yes)" ;;

  esac
done
