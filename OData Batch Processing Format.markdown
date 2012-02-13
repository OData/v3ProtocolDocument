# OData Batch Processing #

# 1. Introduction # 
The OData protocol defines a way to query and manipulate data (described using an EDM model) using a simple set of operations. This document builds on the 'Interaction Semantics' section of the core OData specification document and describes how an OData implementation MAY support executing multiple operations sent in a single HTTP request through the use of Batching.  This document covers both how Batch operations are represented and processed.

Unless otherwise specified, the contents of this document is defined as part of OData version 1.

# 2. Terminology #

# 3. Sending a Batch Request #

Batch requests allow grouping multiple operations, as described in [OData:Interaction], into a single HTTP request payload. A batch request MUST be represented as a Multipart MIME v1.0 message [RFC2046], a standard format allowing the representation of multiple parts, each of which may have a different content type (as described in [OData-Atom] and [OData-JSON]), within a single request.

## 3.1 Batch Request Headers ##
//todo: need to add ref in section below
Batch requests MUST be submitted as a single HTTP POST request to the batch endpoint of a service, which MUST be located at the URI http://<ServiceRootUri>/$batch. Service Root URIs are defined in [OData:Core], section xxx.   

The batch request MUST contain a Content-Type header specifying a content type of "multipart/mixed" and a boundary specification as defined in [RFC2046]. <Batch Request Body> is defined in the Batch Request Body section below. 

//TODO: wrap this in some markup so it is output as an HTTP sample snippet
POST /service/$batch HTTP/1.1
Host: odata.org
DataServiceVersion: 1.0 
MaxDataServiceVersion: 3.0 
content-type: multipart/mixed; boundary=batch(36522ad7-fc75-4b56-8c71-56071383e77b)

<Batch Request Body>

//TODO: ref to add to section below
As shown in the example above and, as described in [OData: core] section XXX, batch requests SHOULD contain applicable DataServiceVersion headers.  

Finally, batch requests MUST NOT include an X-HTTP-Method header (i.e. use POST tunelling) as batch requests are by definition POST only.

## 3.2 Batch Request Body ##
The body of a batch request is made up of an ordered series of query operations (as described in [OData:Core]) and/or ChangeSets.  A ChangeSet is an atomic unit of work consisting of an unordered group of one or more of the insert, update or delete operations described in [OData:Core]. //TODO: what about actions/functions calls - can they be in changesets?  ChangeSets MUST NOT contain query requests and MUST NOT be nested (i.e. a ChangeSet cannot contain a ChangeSet).
 
//TOOD: add refs to below
In a batch request body, each query request and ChangeSet MUST be represented as a distinct MIME part (i.e. is separated by the boundary defined in the Content-Type header). The contents of the MIME part representing a ChangeSet MUST itself be a multipart MIME document (see [RFC 2046]) with one part for each operation that makes up the ChangeSet.
 
The example below shows a sample batch request that contains the following operations in the order listed:
* query request
* Change Set that contains the following requests:
	- Insert Entity 
	- Update request
* second query request 


//TOOD: add markup to make this a sample snippet
POST /service/$batch HTTP/1.1 
Host: host 
Content-Type: multipart/mixed; boundary=batch_36522ad7-fc75-4b56-8c71-56071383e77b 

--batch_36522ad7-fc75-4b56-8c71-56071383e77b
Content-Type: application/http 
Content-Transfer-Encoding:binary

GET /service/Customers('ALFKI') 
Host: host
 
--batch_36522ad7-fc75-4b56-8c71-56071383e77b 
Content-Type: multipart/mixed; boundary=changeset_77162fcd-b8da-41ac-a9f8-9357efbbd621 
Content-Length: ###       
 
--changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621) 
Content-Type: application/http 
Content-Transfer-Encoding: binary 

POST /service/Customers HTTP/1.1 
Host: host  
Content-Type: application/atom+xml;type=entry 
Content-Length: ### 
 
<AtomPub representation of a new Customer> 
 
--changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621) 
Content-Type: application/http 
Content-Transfer-Encoding:binary 
 
PUT /service/Customers('ALFKI') HTTP/1.1 
Host: host 
Content-Type: application/json 
If-Match: xxxxx 
Content-Length: ### 
 
<JSON representation of Customer ALFKI> 
 
--changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621)-- 
 
--batch(36522ad7-fc75-4b56-8c71-56071383e77b) 
Content-Type: application/http 
Content-Transfer-Encoding:binary 
 
GET service/Products HTTP/1.1 
Host: host 

--batch(36522ad7-fc75-4b56-8c71-56071383e77b)--

Note: For brevity, in the example, request bodies are excluded in favor of English descriptions inside '<>' brackets and DataServiceVersion headers are omitted.

### 3.2.1 Referencing Requests in a Change Set ###
If a MIME part representing an Insert request within a ChangeSet includes a Content-ID header, then the new entity represented by that part may be referenced by subsequent requests within the same ChangeSet by referring to the Content-ID value prefixed with a "$" character. When used in this way, $<contentIdValue> acts as an alias for the URI that identifies the new entity.

The example below shows a sample batch request that contains the following operations in the order listed:
* A ChangeSet that contains the following requests:
	- Insert a new entity (with Content-ID = 1)
	- Insert a second new entity (references request with Content-ID = 1)

//TODO: add markup to below so it is a paylaod snippet
POST /service/$batch HTTP/1.1 
Host: host 
Content-Type: multipart/mixed; boundary=batch_36522ad7-fc75-4b56-8c71-56071383e77b 
 
 
--batch_36522ad7-fc75-4b56-8c71-56071383e77b 
Content-Type: multipart/mixed; boundary=changeset_77162fcd-b8da-41ac-a9f8-9357efbbd621 
Content-Length: ###       
 
 
--changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621) 
Content-Type: application/http 
Content-Transfer-Encoding: binary 
Content-ID: 1 
 
POST /service/Customers HTTP/1.1 
Host: host  
Content-Type: application/atom+xml;type=entry 
Content-Length: ### 
 
<AtomPub representation of a new Customer> 
 
--changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621) 
Content-Type: application/http 
Content-Transfer-Encoding: binary 
 
POST $1/Orders HTTP/1.1 
Host: host 
Content-Type: application/atom+xml;type=entry 
Content-Length: ### 
 
<AtomPub representation of a new Order> 
 
--changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621)-- 
--batch(36522ad7-fc75-4b56-8c71-56071383e77b)--

# 5. Responding to a Batch Request #
Requests within a batch MUST be evaluated according to the same semantics used when the request appears outside the context of a batch.

The order of ChangeSets and query requests in a Batch request is significant as a service MUST process the components of the Batch in the order recieved. The order of requests within a ChangeSet is not significant as a service MAY process the requests within a ChangeSet in any order.
  
All operations in a ChangeSet represent a single change unit so a service MUST successfully process and apply all the requests in the ChangeSet or else apply none of them. It is up to the service implementation to define rollback semantics to undo any requests within a ChangeSet that may have been applied before another request in that same ChangeSet failed and thereby honor this all-or-nothing requirement.

If the set of request headers of a Batch request are valid (the Content-Type is set to multipart/mixed, etc) the MUST server return a 202 Accepted HTTP response code to indicate that the request was accepted for processing, but the processing yet to be completed. The requests within the body of the batch may subsequently fail or be malformed; however, this enables batch implementatios to stream the results.

If the service receives a Batch request with an invalid set of headers it MUST return a 4xx response code and perform no further processing of the request.   

A response to a batch request MUST contain a Content-Type header with value 'multipart/mixed'. 

Within the body of the response is a response for each query request and ChangeSet that was in the batch request. The order of such responses MUST match the order of requests in the body of the batch request. Each response MUST include a Content-Type header with value of "application/http" and a Content-Transfer-Encoding header with a value of "binary".

//todo: add ref to below
A response to a query request in a batch is formatted exactly as it would have appeared outside of a batch as described in [OData:Core], section XXX.

//TODO: add ref to below
The body of a ChangeSet response is either a response for all the successfully processed change requests within the ChangeSet, formatted exactly as it would have appeared outside of a batch (see [OData:Core], section XXX) or a single error response indicating a failure of the entire ChangeSet (see "wherever we put error formats").

For example, referencing the batch request in section 3.2, assume all the requests except the final query request succeed. In this case the response would be as shown in the following example.

//TODO: add markup to make below an http sample snippet

HTTP/1.1 202 Accepted
DataServiceVersion: 1.0
Content-Length: ####
Content-Type: multipart/mixed; boundary=batch(36522ad7-fc75-4b56-8c71-56071383e77b)

--batch(36522ad7-fc75-4b56-8c71-56071383e77b)
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 200 Ok
Content-Type: application/atom+xml;type=entry
Content-Length: ###

<AtomPub representation of the Customer entity with EntityKey ALFKI>

--batch(36522ad7-fc75-4b56-8c71-56071383e77b)
Content-Type: multipart/mixed; boundary=changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621)
Content-Length: ###      

--changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621)
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 201 Created
Content-Type: application/atom+xml;type=entry
Location: http://host/service.svc/Customer('POIUY')
Content-Length: ###

<AtomPub representation of a new Customer entity>

--changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621)
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 204 No Content
Host: host

--changeset(77162fcd-b8da-41ac-a9f8-9357efbbd621)--

--batch(36522ad7-fc75-4b56-8c71-56071383e77b)
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 404 Not Found
Content-Type: application/xml
Content-Length: ###

<Error message>
--batch(36522ad7-fc75-4b56-8c71-56071383e77b)--

