# Team Password Manager docker-compose stack #

[Team Password Manager](http://teampasswordmanager.com/ "Team Password Manager Homepage") is a web based password manager for teams. This repository aims to provide a basis to use teampasswordmanager in production via docker and docker-compose.
It features:
* almost completely automated setup of teampasswordmanager, only one config file needs to be touched

## Requirements ##

* docker >= 1.10
* docker-compose >= 1.8
* a server publicly reachable on ports 80 and 443

## How to use / Setup ##

1. Clone this repository
    ```bash
    git clone https://github.com/Riodigital-de/team-password-manager-docker-compose.git /path/to/where/youWant/theFilesToSit
    ```

2. Make sure you have docker and docker-compose up and running

3. Copy .env.dist to .env and open it with your favored editor and change the values to your needs
    Have a look at [the section on the contens of .env](#contents-of-env) to see what every entry does

4. If you do not already have a database in your docker stack copy docker-compose.override.yml.dist to docker-compose.override.yml.

5. Build the images for the compose stack
    ```bash
    docker-compose build
    ```

6. Make sure the DNS records for the domain you want your teampasswordmanager instance to be reachable by are setup properly and point to the public IP of the machine hosting the docker-compose stack

7. Start the rest of the docker-compose stack
    ```bash
    docker-compose up
    ```

8. Visit http://YOUR.TEAMPASSWORD.DOMAIN/install and fill out required fields


## Contents of .env ##
### app ###
* **app_dockerfile**: Tells docker-compose which dockerfile to use when building the app container. The default is 'production.Dockerfile'.
* **app_db_host**: Tells teampasswordmanager which Database to use.

### db ###
* **db_root_password**: The mysql root users password
* **db_name**: The name of the database for teampasswordmanager. The default is 'teampasswordmanager'
* **db_user**: The name of the mysql user for the teampasswordmanager database. The default is 'teampasswordmanager'
* **db_password**: The password for the teampasswordmanager mysql user

### proxy ###
* **proxy_dockerfile**: Tells docker-compose which dockerfile to use when building the proxy container. The default is 'production.Dockerfile'.
* **proxy_domain**: the domain under which your teampasswordmanager instance should be reachable, e.g. YOUR.TEAMPASSWORD.DOMAIN.com. Please make sure to update the DNS records for this domain to point to the machine you want to run teampasswordmanager on.
