FROM mysql

ENV MYSQL_DATABASE purchase_records
ENV MYSQL_ROOT_PASSWORD pwd
COPY csvs /csv_link
COPY db.sql /docker-entrypoint-initdb.d/db.sql
COPY my.cnf /etc/mysql/my.cnf
RUN /entrypoint.sh mysqld & sleep 60
RUN rm /docker-entrypoint-initdb.d/db.sql
