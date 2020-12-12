# Purchase Records Case Study (PRCS) MySQL

The simple Dockerfile is a hacky way to prepopulate a MySQL database container using Docker's default MySQL container as base. To give credit where due, the idea and much of the setup of this comes largely from [this](https://stackoverflow.com/questions/32482780/how-to-create-populated-mysql-docker-image-on-build-time) StackOverflow question and responses, but with some changes to deal with using MySQL 8+ rather than 5.X suggested in the link. 

## Explanation of Changes

  - The `killall` command for `mysqld` is not included by default in the distro of `debian` for MySQL 8+, but is unnecessary. (You can install `psmisc` via `apt-get update && apt-get install psmisc`, but the `mysqld` is not running regardless).

  - The `my.cnf` file needed to include `local-infile` for both `[mysqld]` and `[mysql]`, and based on the directory we created for the csv files (`/csv_link`) needs to be a descendant in the `secure-file-priv` path. Without this, we were apparently disallowed to use `LOAD DATA LOCAL INFILE` command while compiling the container. Note that if you are using the standard `mysql` docker container, you can still use `LOAD DATA LOCAL INFILE` from the command line by remembering to include the parameter `--local-infile 1`  
