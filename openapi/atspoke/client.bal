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

# This is a generated connector for [atSpoke API v0.1.0](https://askspoke.com/api/reference) OpenAPI specification.
# The atSpoke REST API provides a broad set of operations including:
# - Creation, manipulation, and deletion of requests in atSpoke
# - Management of users in atSpoke
# - Creation, manipulation, and deletion of knowledge resources in atSpoke
# The public API is served from https://api.askspoke.com/api/v1 – note `api` in the host name, not your usual organization id.
@display {label: "atSpoke", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    final readonly & ApiKeysConfig apiKeyConfig;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials.
    # Create a [atSpoke account](https://www.atspoke.com) and obtain tokens by following [this guide](https://help.atspoke.com/article/uga6efxps2-api-authentication).
    #
    # + apiKeyConfig - API keys for authorization 
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ApiKeysConfig apiKeyConfig, ConnectionConfig config =  {}, string serviceUrl = "https://api.askspoke.com/api/v1") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
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
        self.apiKeyConfig = apiKeyConfig.cloneReadOnly();
        return;
    }
    # List requests
    #
    # + filter - Parameter to filter queries 
    # + status - Parameter to get requests by status. Should be a comma-separated string of statuses. 
    # + team - Get requests belonging to this team 
    # + tag - Get requests tagged with this tag. Accepts a comma-separated string of many tags, and returns requests that match any provided tag. The keyword `none` can also be passed to return requests that are not tagged. 
    # + q - Searches and returns request with this text 
    # + 'start - The index of the request to start with 
    # + 'limit - The number of requests to return at once. Max is 100. 
    # + sort - The order by which requests should be returned. When querying with a `q` param, results will be sorted by their similarity to the query when no other `sort` is specified. 
    # + return - List of requests 
    remote isolated function getRequests(string filter = "inbox", string status = "OPEN", string? team = (), string? tag = (), string? q = (), int 'start = 0, int 'limit = 25, string sort = "updated") returns InlineResponse200|error {
        string resourcePath = string `/requests`;
        map<anydata> queryParam = {"filter": filter, "status": status, "team": team, "tag": tag, "q": q, "start": 'start, "limit": 'limit, "sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse200 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Create new request
    #
    # + payload - AddRequest payload 
    # + return - Request detail. 
    remote isolated function addRequest(RequestsBody payload) returns Request|error {
        string resourcePath = string `/requests`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Request response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Get open tasks
    #
    # + 'start - The index of the task to start with. 
    # + 'limit - The number of tasks to return. 
    # + byDueDate - Whether to sort tasks by due date or not. 
    # + return - List of pending tasks. 
    remote isolated function getOpenTasks(int? 'start = (), int? 'limit = (), boolean? byDueDate = ()) returns InlineResponse2001|error {
        string resourcePath = string `/requests/tasks`;
        map<anydata> queryParam = {"start": 'start, "limit": 'limit, "byDueDate": byDueDate};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2001 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Get a request
    #
    # + requestId - the ID of the request, 24 characters, hexadecimal 
    # + return - Request object. 
    remote isolated function getRequest(string requestId) returns Request|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Request response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Delete a request
    #
    # + requestId - the ID of the request, 24 characters, hexadecimal 
    # + return - No Content. 
    remote isolated function deleteRequest(string requestId) returns http:Response|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Response response = check self.clientEp->delete(resourcePath, headers = httpHeaders);
        return response;
    }
    # Update a request
    #
    # + requestId - the ID of the request, 24 characters, hexadecimal 
    # + payload - RequestPatchBody payload 
    # + return - Updated request object. 
    remote isolated function updateRequest(string requestId, RequestPatchBody payload) returns Request|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Request response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # Bulk add tags
    #
    # + payload - A payload containing the tag id of the tag to be added and a list of request ids that the tag will be added to. 
    # + return - No content 
    remote isolated function bulkAddTags(RequestsBulkAddTagBody payload) returns Request|error {
        string resourcePath = string `/requests/bulk_add_tag`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Request response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # Get merged requests
    #
    # + requestId - the request id of the request for which you wish to see the merged requests of 
    # + 'start - The index of merged requests to start with 
    # + 'limit - The number of requests merged with your initial request to return. Defaults to 25. 
    # + return - List of requests. 
    remote isolated function getMergedRequests(string requestId, int? 'start = (), int? 'limit = ()) returns InlineResponse2002|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}/secondary`;
        map<anydata> queryParam = {"start": 'start, "limit": 'limit};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2002 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Post a message
    #
    # + requestId - ID of the request. 
    # + payload - PostRequestMessage payload 
    # + return - Update object. 
    remote isolated function postRequestMessage(string requestId, RequestidMessagesBody payload) returns Update|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}/messages`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Update response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Merge requests
    #
    # + requestId - the request id of the request you wish to merge in to 
    # + payload - MergeRequest payload 
    # + return - No Content. 
    remote isolated function mergeRequest(string requestId, RequestidMergeBody payload) returns http:Response|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}/merge`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Add tags
    #
    # + requestId - ID of the request that needs to be updated. 
    # + payload - AddTagsToRequest payload 
    # + return - No Content. 
    remote isolated function addTagsToRequest(string requestId, RequestidTagsBody payload) returns http:Response|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}/tags`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # Delete tag
    #
    # + requestId - ID of the request that needs to be updated. 
    # + tagId - ID of the tag to remove from the request. 
    # + return - No Content. 
    remote isolated function deleteTagFromRequest(string requestId, string tagId) returns http:Response|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}/tags/${getEncodedUri(tagId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Response response = check self.clientEp->delete(resourcePath, headers = httpHeaders);
        return response;
    }
    # Add a subscriber
    #
    # + requestId - ID of the request that will have the new subscriber. 
    # + userId - ID of the user to subscribe to the request. 
    # + return - All request subscribers 
    remote isolated function addSubscriberToRequest(string requestId, string userId) returns SubscriberList|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}/subscribers/${getEncodedUri(userId)}`;
        http:Request request = new;
        //TODO: Update the request as needed;
        SubscriberList response = check self.clientEp-> post(resourcePath, request);
        return response;
    }
    # Remove a subscriber
    #
    # + requestId - ID of the request that will have the subscriber removed. 
    # + userId - ID of the user to remove as a subscriber. 
    # + return - All request subscribers 
    remote isolated function removeSubscriberFromRequest(string requestId, string userId) returns SubscriberList|error {
        string resourcePath = string `/requests/${getEncodedUri(requestId)}/subscribers/${getEncodedUri(userId)}`;
        SubscriberList response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # List request types
    #
    # + q - Parameter for text-searching requestTypes 
    # + team - Get request types belonging to a team. 
    # + 'start - The index of the request type to start with. 
    # + 'limit - The number of request types to return. Defaults to 25. 
    # + sort - sort order for the returned request types 
    # + return - List of request types. 
    remote isolated function getRequestTypes(string? q = (), string? team = (), int? 'start = (), int? 'limit = (), string? sort = ()) returns InlineResponse2003|error {
        string resourcePath = string `/request_types`;
        map<anydata> queryParam = {"q": q, "team": team, "start": 'start, "limit": 'limit, "sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2003 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Get a request type.
    #
    # + requestTypeId - id of the request type 
    # + return - A request type object. 
    remote isolated function getRequestType(string requestTypeId) returns RequestType|error {
        string resourcePath = string `/request_types/${getEncodedUri(requestTypeId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        RequestType response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # List resources
    #
    # + q - A search query to search resources for. 
    # + ai - Whether or not to use AI-based search. Requires q to be set as well. 
    # + status - Parameter to get resources by status.  0 = ok, 1 = needs_review, 2 = deprecated.. 
    # + team - Get resources belonging to one or more teams. Send comma-separated string for multiple teams, "none" for no team 
    # + author - Get resources created one or more authors. Send comma-separated string for multiple authors. 
    # + reviewBy - Get resources up for review before this timestamp (ms since epoch). 
    # + 'start - The index of the request to start with. 
    # + 'limit - The number of parameters to return. Defaults to 25. 
    # + return - List of resources. 
    remote isolated function getResources(string? q = (), boolean? ai = (), decimal? status = (), string? team = (), string? author = (), int? reviewBy = (), int? 'start = (), int? 'limit = ()) returns InlineResponse2004|error {
        string resourcePath = string `/resources`;
        map<anydata> queryParam = {"q": q, "ai": ai, "status": status, "team": team, "author": author, "reviewBy": reviewBy, "start": 'start, "limit": 'limit};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2004 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Create a resource
    #
    # + payload - ResourcePostBody payload 
    # + return - Updated resource object. 
    remote isolated function addResource(ResourcePostBody payload) returns Resource|error {
        string resourcePath = string `/resources`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Resource response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Get a resource
    #
    # + resourceId - ID of the resource. 
    # + return - Resource object. 
    remote isolated function getResource(string resourceId) returns Resource|error {
        string resourcePath = string `/resources/${getEncodedUri(resourceId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Resource response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Delete a resource
    #
    # + resourceId - ID of resource that needs to be deleted. 
    # + return - No Content. 
    remote isolated function deleteResource(string resourceId) returns http:Response|error {
        string resourcePath = string `/resources/${getEncodedUri(resourceId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Response response = check self.clientEp->delete(resourcePath, headers = httpHeaders);
        return response;
    }
    # Update a resource
    #
    # + resourceId - ID of the resource that needs to be updated. 
    # + payload - ResourcePostBody payload 
    # + return - Updated resource object. 
    remote isolated function updateResource(string resourceId, ResourcePostBody payload) returns Resource|error {
        string resourcePath = string `/resources/${getEncodedUri(resourceId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Resource response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # List tags
    #
    # + 'start - The index of the tag to start with. 
    # + 'limit - The number of tags to return. Defaults to 25. 
    # + q - A search query to search tags for 
    # + tagId - A comma separated list of tags 
    # + return - List of tags. 
    remote isolated function getTags(int? 'start = (), int? 'limit = (), string? q = (), string? tagId = ()) returns InlineResponse2005|error {
        string resourcePath = string `/tags`;
        map<anydata> queryParam = {"start": 'start, "limit": 'limit, "q": q, "tagId": tagId};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2005 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # List teams
    #
    # + q - Text search to search teams for. 
    # + ai - Whether or not to use AI-based search. Requires q to be set as well. 
    # + slug - Comma-separated list of team slugs to get. 
    # + 'start - The index of the request to start with. Ignored if ai is set to true. 
    # + 'limit - The number of parameters to return. Defaults to 25. Ignored if ai is set to true. 
    # + return - List of teams. 
    remote isolated function getTeams(string? q = (), boolean? ai = (), string? slug = (), int? 'start = (), int? 'limit = ()) returns InlineResponse2006|error {
        string resourcePath = string `/teams`;
        map<anydata> queryParam = {"q": q, "ai": ai, "slug": slug, "start": 'start, "limit": 'limit};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2006 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Get a team
    #
    # + teamId - ID of the team. 
    # + return - Team object. 
    remote isolated function getTeam(string teamId) returns Team|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Team response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Update a team
    #
    # + teamId - ID of the team. 
    # + payload - TeamPatchBody payload 
    # + return - Team object. 
    remote isolated function updateTeam(string teamId, TeamPatchBody payload) returns Team|error {
        string resourcePath = string `/teams/${getEncodedUri(teamId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Team response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # List users
    #
    # + q - Text search to search user for. 
    # + status - Filter user based on status. 
    # + team - Filter user based on team. 
    # + 'start - The index of the request to start with. 
    # + 'limit - The number of parameters to return. Defaults to 10. 
    # + return - List of users. 
    remote isolated function getUsers(string? q = (), string? status = (), string? team = (), int? 'start = (), int? 'limit = ()) returns InlineResponse2007|error {
        string resourcePath = string `/users`;
        map<anydata> queryParam = {"q": q, "status": status, "team": team, "start": 'start, "limit": 'limit};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2007 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Get a user
    #
    # + userId - ID of the user. 
    # + return - User object. 
    remote isolated function getUser(string userId) returns User|error {
        string resourcePath = string `/users/${getEncodedUri(userId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        User response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Update a user
    #
    # + userId - ID of user that needs to be updated. 
    # + payload - UpdateUser payload 
    # + return - User detail. 
    remote isolated function updateUser(string userId, UsersUseridBody payload) returns User|error {
        string resourcePath = string `/users/${getEncodedUri(userId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        User response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # Get a user by email
    #
    # + address - Email address of the user. Case insensitive. 
    # + return - User object. 
    remote isolated function getUserByEmail(string address) returns User|error {
        string resourcePath = string `/users/email/${getEncodedUri(address)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        User response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Get API user details
    #
    # + return - User and Org details 
    remote isolated function whoami() returns InlineResponse2008|error {
        string resourcePath = string `/whoami`;
        InlineResponse2008 response = check self.clientEp->get(resourcePath);
        return response;
    }
    # List config lists
    #
    # + q - Parameter for text-searching lists by name or item name 
    # + 'start - The index of the list to start with. 
    # + 'limit - The number of lists to return. Defaults to 25. 
    # + listId - comma-separated list of listids to return 
    # + withItem - comma-separated list of itemids to return 
    # + return - List of config lists. 
    remote isolated function getConfigLists(string? q = (), int? 'start = (), int? 'limit = (), string? listId = (), string? withItem = ()) returns InlineResponse2009|error {
        string resourcePath = string `/configlists`;
        map<anydata> queryParam = {"q": q, "start": 'start, "limit": 'limit, "listId": listId, "withItem": withItem};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2009 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Create a config list.
    #
    # + listId - List ID 
    # + payload - ConfigList payload 
    # + return - A config list object. 
    remote isolated function addConfigList(string listId, ConfigList payload) returns ConfigList|error {
        string resourcePath = string `/configlists/${getEncodedUri(listId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ConfigList response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Delete a config list.
    #
    # + listId - the ID of the configlist, 24 characters, hexadecimal 
    # + return - No Content. 
    remote isolated function deleteConfigList(string listId) returns http:Response|error {
        string resourcePath = string `/configlists/${getEncodedUri(listId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Response response = check self.clientEp->delete(resourcePath, headers = httpHeaders);
        return response;
    }
    # Update a config list.
    #
    # + listId - the ID of the configlist, 24 characters, hexadecimal 
    # + payload - ConfigList payload 
    # + return - A config list object. 
    remote isolated function updateConfigList(string listId, ConfigList payload) returns ConfigList|error {
        string resourcePath = string `/configlists/${getEncodedUri(listId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ConfigList response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # Lists webhook subscriptions
    #
    # + return - Lists all the webhook subscriptions for this user on this org. 
    remote isolated function getWebhooks() returns InlineResponse20010|error {
        string resourcePath = string `/webhooks`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse20010 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Creates a new webhook subscription
    #
    # + payload - WebhookSubscriptionPostBody payload 
    # + return - Webhook subscription detail. 
    remote isolated function addWebhook(WebhookSubscriptionPostBody payload) returns WebhookSubscription|error {
        string resourcePath = string `/webhooks`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        WebhookSubscription response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Get a webhook subscription
    #
    # + webhookId - The ID of the webhook to get. 
    # + return - Webhook Subscription object. 
    remote isolated function getWebhook(string webhookId) returns WebhookSubscription|error {
        string resourcePath = string `/webhooks/${getEncodedUri(webhookId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        WebhookSubscription response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Delete a  webhook subscription.
    #
    # + webhookId - ID of  webhook subscription to deleted. 
    # + return - No Content. 
    remote isolated function deleteWebhook(string webhookId) returns http:Response|error {
        string resourcePath = string `/webhooks/${getEncodedUri(webhookId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Response response = check self.clientEp->delete(resourcePath, headers = httpHeaders);
        return response;
    }
    # Update a webhook subscription
    #
    # + webhookId - ID of the webhook subscription that needs to be updated. 
    # + payload - WebhookSubscriptionPostBody payload 
    # + return - Updated webhook subscription object. 
    remote isolated function updateWebhook(string webhookId, WebhookSubscriptionPostBody payload) returns WebhookSubscription|error {
        string resourcePath = string `/webhooks/${getEncodedUri(webhookId)}`;
        map<any> headerValues = {"Api-Key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        WebhookSubscription response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
}
