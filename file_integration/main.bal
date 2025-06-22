import ballerina/ftp;
import ballerina/log;
import ballerina/sql;

listener ftp:Listener file_listener = new (protocol = ftp:FTP, path = ftpFolderPath, port = ftpPort, auth = {
    credentials: {
        username: ftpUsername,
        password: ftpPassword
    }
}, fileNamePattern = ftpFileNamePattern, host = ftpHost, pollingInterval = ftpPollingInterval);

service ftp:Service on file_listener {
    remote function onFileChange(ftp:WatchEvent & readonly event, ftp:Caller caller) returns error? {
        do {
            log:printInfo("Files Received: " + event.addedFiles.length().toString());
            foreach ftp:FileInfo file in event.addedFiles {
                log:printInfo("Reading file:" + file.name);
                stream<byte[] & readonly, error?> fileStream = check caller->get(file.pathDecoded);
                string content = "";
                check fileStream.forEach(function(byte[] & readonly data) {
                    string|error chunk = string:fromBytes(data);
                    if (chunk !is error) {
                        content += chunk;
                    }
                });
                log:printInfo("Received file content: " + content);
                SimpleOrder simpleOrder = check fromEdiString(content);
                OrderDetails orderDetails = transform(simpleOrder);
                log:printInfo("Transformed Data: " + orderDetails.toString());
                sql:ExecutionResult sqlExecutionresult = check mysqlClient->execute(`INSERT INTO ORDER_DETAILS (orderId, orderDate, orderStatus) VALUES (${orderDetails.orderId}, ${orderDetails.date}, ${orderDetails.orderStatus})`);
                if sqlExecutionresult.affectedRowCount == 1 {
                    log:printInfo("Order saved to database with order ID: " + (orderDetails.orderId ?: ""));
                } else {
                    log:printInfo("Error saving order to database.");
                }
            }
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}