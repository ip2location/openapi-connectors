// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# This is a generated connector for [Sendgrid API v3](https://docs.sendgrid.com/api-reference/how-to-use-the-sendgrid-v3-api/) OpenAPI Specification. 
# The Beta endpoints for the new Email Activity APIs - functionality is subject to change without notice. You may not have access to this Beta endpoint.
# Email Activity offers filtering and search by event type for two days worth of data. There is an optional add-on to store 60 days worth of data. This add-on also gives you access to the ability to download a CSV of the 60 days worth of email event data.
@display {label: "SendGrid", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials. 
    # Create a [Sendgrid](https://sendgrid.com/) account and obtain an API Key visiting [Settings -> APIKeys](https://app.sendgrid.com/settings/api_keys). Use the obtained API Key as the token at connector initialization. Configure [required permissions](https://docs.sendgrid.com/ui/account-and-settings/api-keys) when generating the API Key.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.sendgrid.com/v3") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Send Mail
    #
    # + payload - Mail content 
    # + return - No Content 
    @display {label: "Send Email"}
    remote isolated function sendMail(@display {label: "Email Content"} SendEmailRequest payload) returns http:Response|error {
        string resourcePath = string `/mail/send`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Retrieve all alerts
    #
    # + onBehalfOf - The subuser's username. This header generates the API call as if the subuser account was making the call. 
    # + return - Details related to alerts 
    @display {label: "Get All Alerts"}
    remote isolated function getAlerts(@display {label: "Subuser's Username"} string? onBehalfOf = ()) returns AlertResponse[]|error {
        string resourcePath = string `/alerts`;
        map<any> headerValues = {"on-behalf-of": onBehalfOf};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        AlertResponse[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Create a new Alert
    #
    # + onBehalfOf - The subuser's username. This header generates the API call as if the subuser account was making the call. 
    # + payload - Alert Content 
    # + return - Created alert details 
    @display {label: "Create Alert"}
    remote isolated function postAlerts(@display {label: "Alert Content"} PostAlertsRequest payload, @display {label: "Subuser's Username"} string? onBehalfOf = ()) returns PostAlertsResponse|error {
        string resourcePath = string `/alerts`;
        map<any> headerValues = {"on-behalf-of": onBehalfOf};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        PostAlertsResponse response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Delete an alert
    #
    # + alertId - The ID of the alert you would like to retrieve. 
    # + onBehalfOf - The subuser's username. This header generates the API call as if the subuser account was making the call. 
    # + return - Succesful - No Content 
    @display {label: "Delete Alert by Id"}
    remote isolated function deleteAlertById(@display {label: "Alert Id"} int alertId, @display {label: "Subuser's Username"} string? onBehalfOf = ()) returns http:Response|error {
        string resourcePath = string `/alerts/${getEncodedUri(alertId)}`;
        map<any> headerValues = {"on-behalf-of": onBehalfOf};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Response response = check self.clientEp->delete(resourcePath, headers = httpHeaders);
        return response;
    }
    # Update an alert
    #
    # + alertId - The ID of the alert you would like to retrieve. 
    # + onBehalfOf - The subuser's username. This header generates the API call as if the subuser account was making the call. 
    # + payload - Alert content to update 
    # + return - Updated alert details 
    @display {label: "Update Alert by Id"}
    remote isolated function updateAlertbyId(@display {label: "Alert Id"} int alertId, UpdateAlertbyIdRequest payload, @display {label: "Subuser's Username"} string? onBehalfOf = ()) returns UpdateAlertbyIdResponse|error {
        string resourcePath = string `/alerts/${getEncodedUri(alertId)}`;
        map<any> headerValues = {"on-behalf-of": onBehalfOf};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        UpdateAlertbyIdResponse response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # List all Subusers
    #
    # + username - The username of this subuser. 
    # + 'limit - The number of results you would like to get in each request. 
    # + offset - The number of subusers to skip. 
    # + return - List of Subusers 
    @display {label: "List All Subusers"}
    remote isolated function getSubusers(@display {label: "Username"} string? username = (), @display {label: "Limit"} int? 'limit = (), @display {label: "Offset"} int? offset = ()) returns Subuser[]|error {
        string resourcePath = string `/subusers`;
        map<anydata> queryParam = {"username": username, "limit": 'limit, "offset": offset};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Subuser[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create Subuser
    #
    # + payload - New subuser details 
    # + return - Created subuser's details 
    remote isolated function postSubusers(@display {label: "New Subuser Details"} PostSubusersRequest payload) returns SubuserPost|error {
        string resourcePath = string `/subusers`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        SubuserPost response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a subuser
    #
    # + subuserName - Subuser name 
    # + return - Successful - No Content 
    @display {label: "Update Subuser by Subuser Name"}
    remote isolated function deleteSubuserByName(@display {label: "Subuser Name"} string subuserName) returns http:Response|error {
        string resourcePath = string `/subusers/${getEncodedUri(subuserName)}`;
        http:Response response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Retrieve all blocks
    #
    # + startTime - Refers start of the time range in unix timestamp when a blocked email was created (inclusive). 
    # + endTime - Refers end of the time range in unix timestamp when a blocked email was created (inclusive). 
    # + 'limit - Limit the number of results to be displayed per page. 
    # + offset - The point in the list to begin displaying results. 
    # + onBehalfOf - The subuser's username. This header generates the API call as if the subuser account was making the call. 
    # + return - List of all blocks 
    @display {label: "Get Suppression Blocks"}
    remote isolated function getSuppressionBlocks(@display {label: "Start Time"} int? startTime = (), @display {label: "End Time"} int? endTime = (), @display {label: "Limit"} int? 'limit = (), @display {label: "Offset"} int? offset = (), @display {label: "Subuser's Username"} string? onBehalfOf = ()) returns SuppressionBlocks[]|error {
        string resourcePath = string `/suppression/blocks`;
        map<anydata> queryParam = {"start_time": startTime, "end_time": endTime, "limit": 'limit, "offset": offset};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"on-behalf-of": onBehalfOf};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        SuppressionBlocks[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all spam reports
    #
    # + startTime - Refers start of the time range in unix timestamp when a spam report was created (inclusive). 
    # + endTime - Refers end of the time range in unix timestamp when a spam report was created (inclusive). 
    # + 'limit - Limit the number of results to be displayed per page. 
    # + offset - Paging offset. The point in the list to begin displaying results. 
    # + onBehalfOf - The subuser's username. This header generates the API call as if the subuser account was making the call. 
    # + return - Received spam reports 
    @display {label: "Get Suppression Spam Reports"}
    remote isolated function getSuppressionSpamReports(@display {label: "Start Time"} int? startTime = (), @display {label: "End Time"} int? endTime = (), @display {label: "Limit"} int? 'limit = (), @display {label: "Offset"} int? offset = (), @display {label: "Subuser's Username"} string? onBehalfOf = ()) returns SpamReportDetails[]|error {
        string resourcePath = string `/suppression/spam_reports`;
        map<anydata> queryParam = {"start_time": startTime, "end_time": endTime, "limit": 'limit, "offset": offset};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"on-behalf-of": onBehalfOf};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        SpamReportDetails[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
}
