# Team Password Manager docker-compose stack #

[Team Password Manager](http://teampasswordmanager.com/ "Team Password Manager Homepage") is a web based password manager for teams. This repository aims to provide a basis to use teampasswordmanager in production via docker and docker-compose.
It features:
* almost completely automated setup of teampasswordmanager, only one config file needs to be touched
* builtin letsencrypt support: Helper script to test setup and obtain certificates via certbot
* automatic letsencrypt certificate renewal
* SSL offloading via a nginx reverse proxy
* OWASP recommended nginx settings

## Requirements ##

* docker >= 1.10
* docker-compose >= 1.8
* for LetsEncrypt: A domain pointing to the public IP address of the server intended to run the docker-compose stack for passbolt
* a server publicly reachable on ports 80 and 443

## How to use / Setup ##

1. Clone this repository
    ```bash
    git clone https://github.com/Riodigital-de/team-password-manager-docker-compose.git /path/to/where/youWant/theFilesToSit
    ```

2. Make sure you have docker and docker-compose up and running

3. Copy .env.dist to .env and open it with your favored editor and change the values to your needs
    Have a look at [the section on the contens of .env](#contents-of-env) to see what every entry does

5. Build the images for the compose stack
    ```bash
    docker-compose build
    ```

6. Start the (nginx-reverse-)proxy container in interactive mode while overriding the default command to bash and mapping port 80 and 443 explicitly:
    ```bash
    docker-compose run -ti -p 80:80 -p 443:443 proxy bash
    ```
    Depending on the hardware specs and available bandwidth of your machine, the startup may take a couple of minutes the first time. The proxy container depends on the app container, which depends on the database container, so these two are started first.
    
7. **From inside the proxy container**, perform a dry run of the included letsencrypt helper scripts
    ```bash
    sh /dry-run.sh
    ```

8. If everything checks out, actually obtain the letsencrypt certificates:
    ```bash
    sh /get-cert.sh
    ```

10. Exit the container
    ```bash
    exit
    ```

11. Identify the name of the run instance of the proxy container you just exited
    ```bash
    docker-compose ps
    ```
    The name should be something like teampasswordmanager_proxy_run_1 , where *teampasswordmanager* is equal to your current directory name.

12. Stop the proxy container run instance and remove it
    ```bash
    docker stop name_of_the_run_instance && docker rm name_of_the_run_instance 
    ```

13. Start the rest of the docker-compose stack
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
