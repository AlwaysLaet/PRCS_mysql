# Purchase Records Case Study (PRCS) MySQL

v0.1

The simple Dockerfile is a hacky way to prepopulate a MySQL database container using Docker's default MySQL container as base. To give credit where due, the idea and much of the setup of this comes largely from [this](https://stackoverflow.com/questions/32482780/how-to-create-populated-mysql-docker-image-on-build-time) StackOverflow question and responses, but with some changes to deal with using MySQL 8+ rather than 5.X suggested in the link. 

## Explanation of Changes

#### Within `Dockerfile`
  - The `killall` command for `mysqld` is not included by default in the distro of `debian` for MySQL 8+, but is unnecessary. (You can install `psmisc` via `apt-get update && apt-get install psmisc`, but the `mysqld` is not running regardless).
  - Following the run of `entrypoint.sh`, we sleep for 60 seconds, allowing time for the `db.sql` script to run and the database to initialize. This is hacky and had to change from the above suggestion of 30 seconds as that was apparently not long enough to build consistently for our purposes. 

#### Within `my.cnf`

  - The `my.cnf` file needed to include `local-infile` for both `[mysqld]` and `[mysql]`, and based on the directory we created for the csv files (`/csv_link`) needs to be a descendant in the `secure-file-priv` path. Without this, we were apparently disallowed to use `LOAD DATA LOCAL INFILE` command while compiling the container. Note that if you are using the standard `mysql` docker container, you can still use `LOAD DATA LOCAL INFILE` from the command line by remembering to include the parameter `--local-infile 1`. 

## Running from CLI

The following are quick-start instructions to play within the `purchase_records` MySQL database within the command line interface, without porting.

#### Start-up

  1. `docker pull alwayslaet/prcs_mysql`
  2. `docker run -d --name <your-image-name-choice> alwayslaet/prcs_mysql`
  3. `docker exec -it <your-image-name-chioce> bash`

#### After start-up, within bash shell and displaying tables in `purchase_records`
  1. `mysql -uroot -ppwd` (Logging in as user `root` with password `pwd`)
  2. `USE purchase_records;`
  3. `SHOW TABLES;`

## Running via Porting

The following are quick-start instructions to port locally to use, for example, MySQL Workbench.

#### Start-up

  1. `docker pull alwayslaet/prcs_mysql` 
  2. `docker run -d --name <your-image-name-choice> -p <your-fav-port>:3306 alwayslaet/prcs_mysql` (I tend to use `3307` as my favorite port)

#### After start-up
Listen on your local host to `<your-fav-port>` within your tool (e.g., MySQL Workbench). 