#!/bin/bash
# set timeout 10

source includes/format





#Men at Work
intro


inform_human 'UPDATING SERVER (sudo apt-get update)'
sudo apt-get update


inform_human 'INSTALLING NGINX'
sudo apt-get -y install nginx


inform_human 'INSTALLING mysql-server'
sudo apt-get -y install mysql-server


inform_human 'INSTALLING mysql_secure_installation'
echo_white 'What we will do:'
echo_white 'Re-enter password (No)'
echo_white 'VALIDATOR ( No)'
echo_white 'Remove anonymous users (yes)'
echo_white 'Disallow root login remotely (yes)'
echo_white 'Remove test database (yes)'
echo_white 'Reload privilege tables now (yes)'
echo_purple '-------------------------'
# echo -e "n \ny \ny \ny \ny" | mysql_secure_installation
sudo mysql_secure_installation


inform_human 'INSTALLING php-7.2 && most commonly used modules'
sudo apt-add-repository -y ppa:ondrej/php
sudo apt-get update
sudo apt-get -y --allow-unauthenticated install php7.2 php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-mysql php7.2-mbstring  php7.2-zip php7.2-fpm php7.2-xml  zip unzip
#php7.2-mcrypt <-- deprecated ??
sudo apt-get -y install php7.1-mcrypt



inform_human 'UPDATING php.ini (cgi.fix_pathinfo=0)' #
sudo rm /etc/php/7.2/fpm/php.ini
cp files/php.ini /etc/php/7.2/fpm/php.ini


inform_human 'RESTARTING php7.2-fpm'
sudo systemctl restart php7.2-fpm


#if i can't find sudo nano /etc/nginx/sites-available/default -->re install nginx
inform_human 'UPDATING /etc/nginx/sites-available/default'
sudo rm /etc/nginx/sites-available/default
cp files/default /etc/nginx/sites-available/default


inform_human 'CHECKING FOR ERRORS IN default'
sudo nginx -t



inform_human 'RESTARTING NGINX'
sudo systemctl reload nginx
sudo service nginx restart


inform_human 'CREATING A Folder for Laravel in (/var/www/laravel)'
sudo mkdir -p /var/www/laravel

inform_human'NOW WE CREATE SWAPFILE'

inform_human 'CREATING 1GB SWAP FILE'
sudo fallocate -l 1G /swapfile

inform_human 'TELL TO FORMAT IT AS SWAP SPACE && START USING IT'
sudo mkswap /swapfile
sudo swapon /swapfile



inform_human 'INSTALLING COMPOSER'
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

inform_human 'CREATING git repository in (/var/repo/site.git)'
cd /var
mkdir repo && cd repo

mkdir site.git && cd site.git
git init --bare


inform_human 'SETTING UP Git Hooks'
cd hooks


inform_human 'COPYING post-receive file to /var/repo/site.git/hooks/'
cp ~/la-deployer/files/post-receive /var/repo/site.git/hooks/


inform_human 'GIVING post-recive file permissions to excute order to copy files over from git to sever'
sudo chmod +x /var/repo/site.git/hooks/post-receive



white_divider
order_human 'go to your application and add the remote below,, replace 0.0.0.0 with your server ip'
order_human 'git remote add production ssh://root@0.0.0.0.0/var/repo/site.git'
inform_human 'AND FOR THE MAGICAL PART'
order_human 'git push production master'
white_divider

echo
echo

set timeout 10

echo
while true; do

  read -p "HAVE YOU COMPLETE THE INSTUCTIONS ABOVE? (y|Y for yes) : " yn

  case $yn in
  [Yy]* )
      #after pushing local app to server

      white_divider

      cd /var/www/laravel
      inform_human 'RUNNING composer install --no-dev'
      warn_human "*******************************************************"
      warn_human "** if your composer.josn has errors, this will fail ***"
      warn_human "*******************************************************"
      composer install --no-dev


      inform_human 'CREATING ..env file'
      cp /var/www/laravel/.env.example /var/www/laravel/.env


      inform_human 'GENERATING APP KEY'
      php artisan key:generate


      inform_human 'GIVING NGINX PERMISSION OVER LARAVEL DIRECTORY'
      sudo chown -R :www-data /var/www/laravel
      sudo chmod -R 775 /var/www/laravel/storage
      sudo chmod -R 775 /var/www/laravel/bootstrap/cache


      warn_human "*******************************************************"
      warn_human 'YOUR TURN -->Database Setup'
      warn_human 'YOU HAVE TO ATLEAST DO SOMETHING'
      warn_human 'Relax ill help you'
      warn_human "*******************************************************"

      white_divider
      order_human 'type --> mysql -u root -p"yourpassword"'
      order_human 'type --> CREATE DATABASE your_db_name;'
      order_human 'type --> exit'
      white_divider

      #will automate this part after i figure out how to (:P)

      white_divider
      order_human 'type --> sudo nano /var/www/laravel/.env'
      inform_human 'set up as you wish '
      order_human  'TIP 1 -> APP_DEBUG=false'
      order_human  'TIP 2 -> DB_DATABASE= "YOUR_DATABASE_NAME"'
      order_human  'TIP 3 -> DB_USERNAME= "YOUR_DATABASE_USERNAME"'
      order_human  'TIP 4 -> DB_PASSWORD= "YOUR_PASSWORD" (dont forget to put password in quotes ->"YOUR_password") '
      order_human  'SAVE ( CTRL + X , then Y , then ENTER)'
      white_divider


      order_human 'type --> nano /var/www/laravel/config/app.php'
      order_human ' change --> "url" => "http://example.com" to "url" => "http://your_server_ip"'
      order_human 'SAVE ( CTRL + X , then Y , then ENTER)'
      white_divider


      order_human 'type --> cd /var/www/laravel'
      order_human 'type --> php artisan config:cache'
      order_human 'type -->php artisan migrate'
      white_divider

      white_divider
      white_divider
      white_divider

      inform_human 'ALL DONE'

      white_divider
      white_divider
      white_divider

      break;;

# [Nn]* ) exit;;

  * ) echo_red "PLEASE PERFORM THE INSTRUCTIONS ABOVE FIRST !!!!!" ;;

  esac
done

exit;
