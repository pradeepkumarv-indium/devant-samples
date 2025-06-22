import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/mysql.driver as _;

final mysql:Client mysqlClient = check new (dbHost, dbUser, dbPassword, dbDatabase, dbPort);
