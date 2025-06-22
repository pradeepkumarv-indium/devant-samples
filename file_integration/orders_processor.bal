
import ballerina/edi;

# Convert EDI string to Ballerina SimpleOrder record.
# 
# + ediText - EDI string to be converted
# + return - Ballerina record or error
public isolated function fromEdiString(string ediText) returns SimpleOrder|error {
    edi:EdiSchema ediSchema = check edi:getSchema(schemaJson);
    json dataJson = check edi:fromEdiString(ediText, ediSchema);
    return dataJson.cloneWithType();
}

# Convert Ballerina SimpleOrder record to EDI string.
# 
# + data - Ballerina record to be converted
# + return - EDI string or error
public isolated function toEdiString(SimpleOrder data) returns string|error {
    edi:EdiSchema ediSchema = check edi:getSchema(schemaJson);
    return edi:toEdiString(data, ediSchema);    
} 

# Get the EDI schema.
# 
# + return - EDI schema or error
public isolated function getSchema() returns edi:EdiSchema|error {
    return edi:getSchema(schemaJson);
}

# Convert EDI string to Ballerina SimpleOrder record with schema.
# 
# + ediText - EDI string to be converted
# + schema - EDI schema
# + return - Ballerina record or error
public isolated function fromEdiStringWithSchema(string ediText, edi:EdiSchema schema) returns SimpleOrder|error {
    json dataJson = check edi:fromEdiString(ediText, schema);
    return dataJson.cloneWithType();
}

# Convert Ballerina SimpleOrder record to EDI string with schema.
# 
# + data - Ballerina record to be converted
# + ediSchema - EDI schema
# + return - EDI string or error
public isolated function toEdiStringWithSchema(SimpleOrder data, edi:EdiSchema ediSchema) returns string|error {
    return edi:toEdiString(data, ediSchema);    
}

public type Header_Type record {|
   string code = "HDR";
   string orderId?;
   string organization?;
   string date?;
|};

public type Items_Type record {|
   string code = "ITM";
   string item?;
   int? quantity?;
|};

public type SimpleOrder record {|
   Header_Type header;
   Items_Type[] items = [];
|};



final readonly & json schemaJson = {"name":"SimpleOrder", "delimiters":{"segment":"~", "field":"*", "component":":", "repetition":"^"}, "segments":[{"code":"HDR", "tag":"header", "minOccurances":1, "fields":[{"tag":"code"}, {"tag":"orderId"}, {"tag":"organization"}, {"tag":"date"}]}, {"code":"ITM", "tag":"items", "maxOccurances":-1, "fields":[{"tag":"code"}, {"tag":"item"}, {"tag":"quantity", "dataType":"int"}]}]};
    