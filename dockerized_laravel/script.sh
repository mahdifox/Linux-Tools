#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2022_Mar ##
##########################################

################# Usage ##################
##    run script with non-root-user     ##
##########################################

script_path=`pwd`

#install docker in ubuntu from https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update

sudo apt-get install ca-certificates curl gnupg lsb-release

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo systemctl enable docker.service && sudo systemctl restart docker.service

sudo apt-get install docker-compose -y

#install laravel from https://www.howtoforge.com/dockerizing-laravel-with-nginx-mysql-and-docker-compose/
usermod -a -G docker $USER

su - $USER

cd ~/

git clone https://github.com/laravel/laravel.git myapp/

cd myapp/

docker login

docker run --rm -v $(pwd):/app composer install

sudo chown -R $USER:$USER ~/myapp

cat "$script_path/docker-compose.yml" > ~/myapp/docker-compose.yml

cat "$script_path/Dockerfile" > ~/myapp/Dockerfile

cat "$script_path/.env" > ~/myapp/.env

docker-compose up -d

docker-compose exec app php artisan key:generate

docker-compose exec app php artisan config:cache

cp -r "$script_path/nginx/"  "~/myapp/"
