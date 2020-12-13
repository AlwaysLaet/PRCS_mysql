# Build over Docker's base MySQL 8 container
FROM mysql:8

# Create the purchase_records table
ENV MYSQL_DATABASE purchase_records
# Set the default mysql root password
ENV MYSQL_ROOT_PASSWORD pwd
# Move the local csv files into the secure-file-priv accessible directory in container
COPY csvs /csv_link
# Copy over the MySQL initialization / table creation script
COPY db.sql /docker-entrypoint-initdb.d/db.sql
# Copy over the my.cnf, importantly changing data dir and local-infile
COPY my.cnf /etc/mysql/my.cnf
# Run to setup the MySQL database and sleep long enough for sql script (hacky)
RUN /entrypoint.sh mysqld & sleep 60
# Remove the sql script from the initdb of container
RUN rm /docker-entrypoint-initdb.d/db.sql
