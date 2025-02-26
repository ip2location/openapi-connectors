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

# This is a generated connector for [DocuSign Monitor API](https://developers.docusign.com/docs/monitor-api/monitor101/) OpenAPI specification. DocuSign Monitor helps organizations protect their agreements with round-the-clock activity tracking.  The Monitor API delivers this activity tracking information directly to existing security stacks or data visualization  tools—enabling teams to detect unauthorized activity, investigate incidents, and quickly respond to verified threats.  It also provides the flexibility security teams need to customize dashboards and alerts to meet specific business needs.
@display {label: "DocuSign Monitor", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials.
    # Create a [DocuSign account](https://www.docusign.com/) and obtain tokens by following [this guide](https://developers.docusign.com/docs/monitor-api/monitor101/auth/).
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "//lens.docusign.net/") returns error? {
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
    # Gets customer event data for an organization.
    #
    # + dataSetName - The data product to which the endpoints are executed against. 
    # + 'version - Must be `2`. 
    # + cursor - A location in the DataSet that continues querying data. 
    # + 'limit - The maximum number of records to return. 
    # + return - Success 
    remote isolated function getDatasetsByDataSetName(string dataSetName, string 'version, string? cursor = (), int 'limit = 1000) returns CursoredResult|error {
        string resourcePath = string `/api/v${getEncodedUri('version)}/datasets/${getEncodedUri(dataSetName)}/stream`;
        map<anydata> queryParam = {"cursor": cursor, "limit": 'limit};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CursoredResult response = check self.clientEp->get(resourcePath);
        return response;
    }
}
