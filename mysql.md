mysql8以后，以下配置无效：

[mysqld]
lower_case_table_names  = 1

需要在docker-compose.yml中修改：command: --lower-case-table-names=1

mysql:
    image: mysql/mysql-server:${MYSQL_VERSION}
    command: --lower-case-table-names=1