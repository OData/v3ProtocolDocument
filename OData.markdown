# OData #

We have a few statuses:

Assigned to Someone, Review, Reviewing(name), Edit

# 1. Overview #

------

- ASSIGNED TO: Review

------

The OData Protocol is an application-level protocol for interacting with data via RESTful web services. The protocol supports the description of data models and editing and querying of data according to those models. It provides facilities for:

- Metadata: A machine-readable description of the data model exposed by a particular data provider.
- Data: Sets of data entities and the relationships between them.
- Querying: Requesting that the server perform a set of filtering and other transformations to its data, then return the results.
- Editing: Creating, editing, and deleting data.

The OData Protocol is different from other REST-based web service approaches in that it provides a uniform way to describe both the data and the data model. This improves semmantic interoperability between systems and allows an ecosystem to emerge.

Towards that end, the OData Protocol follows these design principles:

- Prefer mechanisms that work on a variety of data stores. In particular, do not assume a relational data model.
- Backwards compatability is paramount. Clients and servers which speak different versions of the OData Protocol should interoperate, supporting everything allowed in the lower of the two versions.
- Follow REST principles unless there is a good and specific reason not to.
- OData should degrade gracefully. It should be easy to make a very basic but compliant OData endpoint, with additional work necessary only to support additional capabilities.

# 2. Data Model #

------

- ASSIGNED TO: MikeF

------

- high level overview of the data model that describes the system (not a full/formal definition of EDM, but just what you need to know to reason about the contents of the spec)
- ideally we can put the full/formal definition of EDM into an appendix or something.  We should also consider any changes or omissions to EDM we might need/want
- Should include the type system (unless we put that in another section), including, e.g., a list of the primitive types supported and the operations that are allowed on properties of those types.
 - As an abstract type system. Avoid its representation in EDM/CSDL. That remains in appendices.

## 2.1 Entities

## 2.2 Entity Sets ##

## 2.3 Primitive Values ##

## 2.4 Complex Values ##

## 2.5 Navigations ##

# 3. Terminology #

------

- ASSIGNED TO: MikeF/All

------

- glossary of terms used throughout the doc 

# 4. Notational Conventions #

------

- ASSIGNED TO: Edit

------

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [[RFC2119](http://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")].

## 4.1. Json Example Payloads ##

------

- ASSIGNED TO: Review

------

Some sections of this specification are illustrated with non-normative example OData request and response payloads. However, the text of this specification provides the definition of conformance.

OData payloads are representable in multiple formats. Those formats are specified in separate documents. In this document, when an example is necessary, it will be given in the minimal Json format.

## 4.2. CSDL Schema ##

------

- ASSIGNED TO: Review

------

Some sections of this specification are illustrated with fragments of a non-normative RELAX NG Compact schema [[RNC](http://tools.ietf.org/html/rfc5023#ref-RNC "RELAX NG Compact Syntax")]. However, the text of this specification provides the definition of conformance. Complete schemas appear in Appendix B.

# 5. Versioning#

------

- ASSIGNED TO: Review

------

This document defines version 3.0 of the OData Specification.

The OData protocol supports a versioning scheme for enabling services to expose new features and format versions without breaking compatibility with older clients.

OData clients MAY use the DataServiceVersion header on a request to specify the version of the protocol used to generate the request. 

If the DataServiceVersion header is present, the service MUST interpret the request according to the rules defined in the specified version of the protocol, or fail the request with a 4xx response code. If not specified, the server MUST assume the request is generated using the maximum version of the protocol that the service understands.

The OData client MAY also use the MinDataServiceVersion and MaxDataServiceVersion headers. The server MUST generate a response compatible with a version greater than or equal to the specified MinDataServiceVersion and less than or equal to the specified MaxDataServiceVersion, and SHOULD generate a response formatted according to the maximum version supported by the service that is less than or equal to the specified MaxDataServiceVersion. If MaxDataServiceVersion is not specified, then the service SHOULD return a response formatted according to the latest version of the format supported by the service.

If the MinDataService header is not specified by the client, it is assumed by the service to be version 1.0.

DataServiceVersion, MinDataServiceVersion, and MaxDataServiceVersion header fields MUST be of the following form:  

   **majorversionnumber + "." + minorversionnumber**. 

This version of the specification defines the following valid data service version values: "1.0", "2.0", and "3.0", corresponding to OData versions 1.0, 2.0, and 3.0, respectively.

The service MUST include a DataServiceVersion header to specify the version of the format according to which the response is generated. If the service is unable to generate a response that is within the specified version range it MUST fail the request with a 4xx response code and a description of the error using the error format defined in [todo].

# 6. Extensibility #

------

- ASSIGNED TO: Review

------
The OData protocol supports both user- and version- driven extensibility through a combination of versioning, convention, and explicit extension points.

## 6.1. Query Option Extensibility ##
Query Options within the Request URL can control how a particular request is processed by the service. 

OData-defined system query options are prefixed with "$". Services MAY support additional query options not defined in the OData specification, but they MUST NOT begin with the "$" character.

OData Services SHOULD NOT require any query options to be specified in a request, and MUST fail any request that contains query options that it does not understand.

## 6.2. Payload Extensibility ##
OData supports extensibility in the payload, according to the specific format.

Regardless of the format, additional content may be present only if it need not be understood by the receiver in order to correctly interpret the payload. Thus, clients and services may safely ignore any content not specifically defined in the version of the payload specified by the DataServiceVersion header.

### 6.3. Action/Function Extensibility ###
Actions and Functions extend the set of operations that can be performed on or with a service or resource. Actions MAY have side-effects and be used, for example, to extend CUD operations, invoke custom operations, etc. Functions MUST NOT have side-effects, and can generally be invoked directly on a service or resource or composed within, for example, a predicate.

Services MAY support additional actions and functions not defined in the OData specification. Such functions MUST be qualified with a namespace other than one of the OData namespaces specified in [todo]. 

Servers MUST fail any request that contains actions or functions that it does not understand.

### 6.4. Vocabulary Extensibility ###
Vocabularies provide the ability to annotate metadata as well as instance data, and define a powerful extensibility point for OData.

Metadata annotations can be used to define additional characteristics or capabilities of a metadata element, such as a service, entitytype, property, function, action, parameter, or association. For example, a metadata annotation may define ranges of valid values for a particular field, or required query operators for a particular entityset.

Instance annotations can be used to define additional information associated with a particular feed, resource or property; for example whether a particular property is read-only for a particular instance.

Annotations that apply across instances SHOULD be specified within the metadata. Where the same annotation is defined at both the metadata and instance level, the instance-annotation overrides whatever defaults have been specified at the metadata level.

Metadata and instance annonations defined outside of the OData specification SHOULD NOT be required to be understood in order to correctly interact with an OData Service or correctly interpret an OData payload.

# 7. Interaction Semantics #

## 7.1. Metadata ##

### 7.1.1. Service Document ###

------

- ASSIGNED TO: MikeP

------

### 7.1.2. Metadata Document ###

------

- ASSIGNED TO: Alex

------

- i.e. $metadata

## 7.2. Querying Data ##

------

- ASSIGNED TO: Mike(*)

------

- description of how data is queried in OData (i.e. GET requests).  Might need some additional structure, but figured that can be flushed out as we progress
- this would include description of everything after the ? ($filter, select, top, skip, etc)

## 7.3. Data Modification ##

------

- ASSIGNED TO: Arlo

------

For all operations, the format of request and response bodies is format specific. See the format-specific specifications ([[Json](Json)], [[Json with metadata](Json_With_Metadata_Format)], [[Atom](Atom_Format)]) for details.

Any response may use any valid HTTP status code, as appropriate for the action taken. A server SHOULD be as specific as possible in its choice of HTTP status codes. Each request specification, below, indicates the most common success response code. In some cases, a server might respond with a more specific success code. For example, a server might decide to perform an action asynchronously, in which case it SHOULD use the HTTP status codes designed for that purpose.

In all failure responses, the server MUST provide an accurate failure HTTP status code. The response body MUST contain a human-readable description of the problem, and SHOULD contain suggested resolution steps, if the server knows what those are.

### Modifying Entities ###

Entities are described in [Section 2.1](#entities). URI conventions for entites are described in [URI Conventions](uri_conventions).

#### Create an Entity ####

To create an Entity in an entity set, send a POST request to that entity set's URI. The POST body MUST contain a single valid entity representation.

On success, the response SHOULD be 201 Created, with the Location header set to the edit URI for the new entity.

#### Update an Entity ####

To update an existing entity, send a PUT, PATCH, or MERGE request to that entity's edit URI. The request body must contain a single valid entity representation.

If the request is a PUT request, the server MUST replace all property values with those specified in the request body. Missing properties MUST be set to their default values.

If the request is a PATCH or MERGE request, the server MUST replace exactly those property values that are specified in the request body. Missing properties MUST NOT be altered.

On success, the response SHOULD be 200 OK.

The response body MAY contain the entity representation for the entity's new state.

If desired, the PUT, PATCH, or MERGE request can include a XXXXXXXXXXXX header. If this header is included in the request, then the response MUST contain the entity representation for the entity's new state.

#### Delete an Entity ####

To delete an existing entity, send a DELETE request to that entity's edit URI. The request body SHOULD be empty.

On success, the response SHOULD be 200 OK.

-------

This section is all stuff to cover, but not in the right ToC. I want to follow the Atom approach of discussing everything from the perspective of what the person is trying to accomplish, rather than from the perspective of stating the meaning of each thing (and all of its conditions and exceptions).

  ### POST ###

  ### DELETE ###

  ### PUT ###

  ### PATCH/MERGE ###

  ## Additional Operations ##

  ### Actions ###

-----

------

- ASSIGNED TO: Alex

------

### Functions ###

------

- ASSIGNED TO: Alex

------

### Service Operations ###

------

- ASSIGNED TO: Alex

------

(ideally we want to end of life these in favor of the above two – should consider if /how we include these)

### Batch Processing ###

------

- ASSIGNED TO: MikeP

------

# Appendices #

## A: Formal CSDL description ##

------

- ASSIGNED TO: Alex

------

## B: XSD for CSDL ##

------

- ASSIGNED TO: Alex

------
