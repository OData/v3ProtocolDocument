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

This section provides a high-level description of the Entity Data Model (EDM); the abstract data model that MUST be used to describe the data exposed by an OData service. <ref>Section XXXX</ref> defines an OData Metadata Document which is a representation of a service's data model exposed for client consumption.  

The central concepts in the EDM are **entities** and **associations**. Entities are instances of **Entity Types** (e.g. Customer, Employee, etc) which are nominal structured records with a key that consist of named primitive or complex properties. 

**Complex Types** are nominal structured types also consisting of a list of properties but with no key, thus can only exist as a property of a containing Entity Type or as a temporary value. 

The **Entity Key** of an Entity Type is formed from a subset of primitive properties of the Entity Type. The Entity Key (e.g. CustomerId, OrderId, etc) is a fundamental concept to uniquely identify instances of Entity Types (entities) and allows entities to participate in relationships. 

Properties statically declared as part of the Entity Type's structural definition are called **declared properties** and those which are not are **dynamic properties**. Entity Types which allow dynamic properties are called Open Entity Types. If an instance of an Open Entity Type does not include a value for a dynamic property, the instance must be treated as if it included the property with a value of null. A dynamic property MAY NOT have the same name as a declared property.

Entities are grouped in named collections called **Entity Sets** (e.g. Customers is a set of Customer Entity Type instances).

**Association Types** define the relationship between two or more Entity Types (e.g. Employee WorksFor Department). Instances of Association Types are grouped in **Association Sets**. **Navigation Properties** are special properties on Entity Types which are bound to a specific association and are used to refer to specific associations of an entity. 
 
Finally, all instance containers (Entity Sets and Association Sets) are grouped in an **Entity Container**.

//TODO: put primitive type table here in subsection
//TODO: what about named streams?  anything else core that I missed?

//TODO: Do we really need association sets? Can we describe the core data model in terms of entities and navigations instead?  --Arlo

//TODO: I think we need subsections here. This does a reasonable job of giving an overview. However, we need somewhere where we go into more details on each of the concepts. Unless we put it here, this stuff will end up in the format-specific documents. I've put some examples here as subsections, but don't think this is complete, nor do I think that everything here necessarily should be here.

## 2.1 Entities ##

## 2.2 NavigationProperties ##

Entities are related to each other via NavigationProperties. A NavigationProperty is a one-way relationship with cardinality 1:many, 1:1, or 1:[0,1]. The property's name defines the relationship. Its value is a reference to the related Entity or collection of Entities.

A NavigationProperty can be seen as a Property on its source Entity. It can also be seen as a relationship. The NavigationLink is the URI that addresses the relationship itself.

## 2.3 EntitySets and collections of Entities ##

## 2.4 Annotations ##

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

OData payloads are representable in multiple formats. Those formats are specified in separate documents. In this document, when an example is necessary, it will be given in the Json Light format.

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

The OData protocol supports both user- and version- driven extensibility through a combination of versioning, convention, and explicit extension points.

## 6.1. Query Option Extensibility ##

Query Options within the Request URL can control how a particular request is processed by the service. 

OData-defined system query options are prefixed with "$". Services MAY support additional query options not defined in the OData specification, but they MUST NOT begin with the "$" character.

OData Services SHOULD NOT require any query options to be specified in a request, and MUST fail any request that contains query options that it does not understand. 

*REVIEWER: Alex: is this too strong - for example WCF Data Services would be forced to fail a request with $format in the url, even though an intermediary might make it unnecessary to correctly understand it?*

## 6.2. Payload Extensibility ##

OData supports extensibility in the payload, according to the specific format.

Regardless of the format, additional content MAY be present only if it need not be understood by the receiver in order to correctly interpret the payload. Thus, clients and services MAY safely ignore any content not specifically defined in the version of the payload specified by the DataServiceVersion header.

### 6.3. Action/Function Extensibility ###

Actions and Functions extend the set of operations that can be performed on or with a service or resource. Actions MAY have side-effects and be used, for example, to extend CUD operations, invoke custom operations, etc. Functions MUST NOT have side-effects, and can generally be invoked directly on a service or resource or composed within, for example, a predicate.

Services MAY support additional actions and functions not defined in the OData specification. Such functions MUST be qualified with a namespace other than one of the OData namespaces specified in [todo]. 

Servers MUST fail any request that contains actions or functions that it does not understand.

### 6.4. Vocabulary Extensibility ###

Vocabularies provide the ability to annotate metadata as well as instance data, and define a powerful extensibility point for OData.

Metadata annotations can be used to define additional characteristics or capabilities of a metadata element, such as a service, entitytype, property, function, action, parameter, or association. For example, a metadata annotation may define ranges of valid values for a particular field, or required query operators for a particular entityset.

Instance annotations can be used to define additional information associated with a particular feed, resource or property; for example whether a particular property is read-only for a particular instance.

Annotations that apply across instances SHOULD be specified within the metadata. Where the same annotation is defined at both the metadata and instance level, the instance-annotation overrides whatever defaults have been specified at the metadata level.

Metadata and instance annotations defined outside of the OData specification SHOULD NOT be required to be understood in order to correctly interact with an OData Service or correctly interpret an OData payload.


### 6.5. Header Field Extensibility ###

OData defines semantics around certain HTTP Header Fields that may be included in requests to, and responses from, the data service. Services advertising compliance with a particular version of the OData Specification MUST understand and comply with the header fields defined in that version of the specification, either by honoring the semantics of the header field or by failing the request.

Individual services MAY define additional header fields specific to that particular service. Such header fields MUST NOT be begin with "OData-" and, for maximum interoperability, SHOULD be optional when making requests against the service. Custom header fields MUST NOT be required to be understood by the client in order to accurately interpret the response.

# 7. Interaction Semantics #

## 7.1. Metadata ##

### 7.1.1. Service Document ###

make sure to reference service root in this section

------

- ASSIGNED TO: MikeP

------

### 7.1.2. Metadata Document ###

An OData Metadata Document is an representation of the data model (<ref> see section 2. Data Model</ref>) that describes the data and operations exposed by an OData service. 

<ref>Appendix A</ref> describes an XML representation for OData Metadata Documents and provides an XSD to validate its syntax rules. The media type of the XML representation of an OData Metadata Document is 'application/xml'      

As of OData v3, OData services MUST expose a Metadata Document which defines all data exposed by the service.  The URI of the document MUST be http://<service root>/$metadata, where <service root> is the root URI of the OData service as described in <ref>//TODO</ref>. 

Retrieval of a Metadata Document by a client MUST be done by issuing a HTTP GET request to document's URI.  If the request doesn't specify a format preference (via Accept header or <ref>$format query string option</ref>) then the XML representation MUST be returned.

## 7.2. Querying Data ##

------

- ASSIGNED TO: Mike(*)

------

- description of how data is queried in OData (i.e. GET requests).  Might need some additional structure, but figured that can be flushed out as we progress
- this would include description of everything after the ? ($filter, select, top, skip, etc)

## 7.3. Data Modification ##

An OData server MAY support Create, Update, and Delete operations for some of all of the Entities that it exposes.

For all operations, the format of request and response bodies is format specific. See the format-specific specifications ([[JSON](JSON)], [[JSON Verbose](JSON_Verbose_format)], [[Atom](Atom_Format)]) for details.

Any response may use any valid HTTP status code, as appropriate for the action taken. A server SHOULD be as specific as possible in its choice of HTTP status codes. Each request specification, below, indicates the most common success response code. In some cases, a server might respond with a more specific success code. For example, a server might decide to perform an action asynchronously, in which case it SHOULD use the HTTP status codes designed for that purpose.

In all failure responses, the server MUST provide an accurate failure HTTP status code. The response body MUST contain a human-readable description of the problem, and SHOULD contain suggested resolution steps, if the server knows what those are. This information MUST be supplied in the <ref>Error format</ref>.

### Responses for Updates ###

Many different parts of the model can be updated. Responses to update requests for all parts of the model share some common traits. Rather than repeating them for all responses, the common traits are identified here.

On success, the response to any update request MUST be either 204 with an empty response body or 200 with a valid response body.

A non-empty body MUST contain the new, post-update, value for the identified resource. This MUST be formatted exactly as would the response for a GET to the same URL as was specified in the update request.

### Modifying Entities ###

Entities are described in [Section 2.1](#entities). URI conventions for entites are described in [URI Conventions](uri_conventions).

#### Create an Entity ####

To create an Entity in an entity set, send a POST request to that entity set's URI. The POST body MUST contain a single valid entity representation.

If the type being created is an OpenType, then additional values for properties beyond those specified in the metadata MAY be sent in the request body. The server MUST treat these as dynamic properties and add them to the created instance.

If the type being created is not an OpenType, then additional values for properties beyond those specified in the metadata SHOULD NOT be sent in the request body. The server MUST ignore any such values supplied.

On success, the response MUST be 201 and contain a Location header that expresses the edit URL of the created Entity. The response body MUST contain a representation of the new Entity. This MUST be formatted as would the response body for a GET request to the new Entity's edit URL.

The update request MAY include a <ref>Prefer</ref> header to suggest what the server should return.

##### Link to Related Entities When Creating Entity #####

A server that supports creating Entities SHOULD support linking those new Entities to existing Entities when they are created.

A request to create an Entity the MAY specify that the Entity should be automatically linked to other already-existing entities in the data service. To bind the new entity to one or more existing Entities, include the required <ref>binding information</ref> in the appropriate NavigationProperty in the request body.

The representation for binding information is format specific.

On success, the server MUST create the requested Entity and associate its NavigationProperty to the requested existing entity.

On failure, the server MUST NOT create the new Entity. In particular, it MUST NOT create an Entity in a partially-valid state (with the NavigationProperty not set).

##### Create Related Entities When Creating Entity #####

A server that supports creating Entities SHOULD support creating related Entities as part of the same request.

A request to create an Entity the MAY specify related Entites that should also be created. The related entities MUST be represented using the <ref>inline representation of the NavigationProperty</ref>.

On success, the server MUST create eaqch Entity requested and associate them via the NavigationProperty.

On failure, the server MUST NOT create any of the Entities requested.

#### Update an Entity ####

To update an existing entity, send a PUT, PATCH, or MERGE request to that entity's edit URI. The request body MUST contain a single valid entity representation.

If the request is a PUT request, the server MUST replace all property values with those specified in the request body. Missing properties MUST be set to their default values. Missing dynamic properties MUST be removed or set to NULL.

If the request is a PATCH or MERGE request, the server MUST replace exactly those property values that are specified in the request body. Missing properties, including dynamic properties, MUST NOT be altered. Exact semantics are defined in <ref>PATCH and MERGE</ref>.

If the type being updated is an OpenType, then additional values for properties beyond those specified in the metadata MAY be sent in the request body. The server MUST treat these as dynamic properties and involve them in the update.

If the type being updated is not an OpenType, then additional values for properties beyond those specified in the metadata SHOULD NOT be sent in the request body. The server MUST ignore any such values supplied.

On success, the response must be a valid [update response](#responsesforupdates).

#### Delete an Entity ####

To delete an existing entity, send a DELETE request to that entity's edit URI. The request body SHOULD be empty.

On success, the response SHOULD be 200 OK.

### Modifying Relationships Between Entities ###

Relationships between Entities are described by NavigationProperties. NavigationProperties are described in <ref>[Section ??](#navigationproperties)</ref>. URI conventions for NavigationProperties are described in [URI Conventions](uri_conventions).

#### Create a New Link Between Two Existing Entities in a One to Many NavigationProperty ####

To add an existing Entity to another Entity's NavigationProperty, send a POST request to the URI for that NavigationProperty's links collection. The request body MUST contain a URI that identifies the Entity to be added.

The body MUST be formatted as for Edm.SimpleType Property that contains a single link.

On success, the response MUST be 204 and contain an empty body.

#### Remove a Link Between Two Entities in a One to Many NavigationProperty ####

To remove an Entity from another Entity's NavigationProperty, send a DELETE request to a URI that represents the single link between those two Entities.

On success, the response MUST be 204 and contain an empty body.

#### Change the Relation in a One to One NavigationProperty ####

If the NavigationProperty is nullable, then a change MAY be perfomed by first removing the existing relationship and then adding the new one. Use the approach described for adding and removing links in one to many NavigationProperties.

Alternatively, a relationship MAY be updated as part of an update to the source Entity. Update the entity; the NavigationProperty MUST include the required binding information for the new target Entity. This binding information MUST be formatted as for a deferred NavigationProperty in a response.

### Managing Resources ###

Binary resources are one of the primitive types that can be used in the difinition of a Property. However, they are complex enough that there are special rules for manipulating them.

There are two ways to associate a Property with a particular value Resoruce: Media Link Entries (MLEs) or Named Streams.

#### Manage a Media Resource Using MLEs ####

A server MAY expose Media Resoruces using Media Link Entries. These are Entities which represent a single data BLOB. They behave very similarly to normal Entities, but they have a different representation for some operations.

MLE Entities have two parts: data and metadata. A given request body may refer to either of these parts, but not both.

The representation for the data part is however that data would normally be transmitted in raw HTTP. For example, the data portion of an image resource would have a content type of image/png, with a request body that contains the image data.

The metadata is always represented as a standard Entity. All MLE Entities have a certain set of common properties. They may have additional metadata properties. See <ref>MLE Metadata</ref> for details.

Because a MLE has two parts, it has multiple URIs. These URIs are defined as follows:

* **Entity URI**. The edit URI that may be used to modify the metadata part of the MLE.
* **Edit URI**. The URI which may be used to modify the data part of the MLE. This URI is contained in the MLE metadata, if the data is modifyable.
* **Source URI**. The URI which may be used to request the data part of the MLE. This URI is contained in the MLE metadata.

The edit URI for the Entity represents the metadata Entity. This metadata entity is manipulated as per a normal Entity.

A MLE MUST NOT exist with only one of data and metadata. Any time the server creates or destroys one part it MUST create or destroy the other part in the same request. This invariant MUST be maintained even when an error occurs while handling such a request.

##### Create a MLE #####

To create a MLE, send a POST request to the MLE metadata's EnititySet. The request body MUST contain the representation of the data for the resource, not the representation for the metadata.

The server MUST respond with the representation for the metadata. All MLE metadata entities include a property which contains the data URI for that resource.

##### Reference a Media Resource Modeled as a MLE #####

To refer to a MLE Media Resource from an Entitiy, associate a NavigationProperty with that resource's metadata Entity. Manage this relationship as per any other Entity to Entity relationship.

##### Delete a MLE #####

To delete a MLE, delete the MLE's metadata Entity, as described in [Delete An Entity](#deleteanentity).

#### Managing Resources Using Named Streams ####

TBD.

### Managing Values and Properties Directly ###

Values and Properties can be explicitly addressed with URIs. This allows them to be individually modified. See <ref>Uri conventions</ref> for details on addressing.

#### Update a Value ####

To update a value, the client MAY send a PUT, MERGE, or PATCH request to an edit URI for the value. The message body MUST contain the desired new value, formatted as a <ref>SimpleTypeProperty</ref>.

Regardless of which verb is used, the server MUST replace the entire value with the value supplied in the request body.

The same rules apply whether this is the value of a regular property or the value of a dynamic property.

On success, the response must be a valid [update response](#responsesforupdates).

#### Null a Value ####

There are two ways to set a value to NULL. The client may <ref>Update a Value</ref> to NULL. Alternatively the client MAY send a DELETE request with an empty message body to an edit URI for that value.

The server SHOULD consider a DELETE request to a non-nullable value to be malformed.

The same rules apply whether this is the value of a regular property or the value of a dynamic property. A missing dynamic property is defined to be the same as a dynamic property with value NULL. Therefore, all dynamical properties are implicitly nullable.

On success, the server MUST respond with 204 and an empty body.

#### Update a ComplexType ####

To update an complex type, send a PUT, PATCH, or MERGE request to that value's edit URI. The request body MUST contain a single valid representation for that type.

If the request is a PUT request, the server MUST replace all property values with those specified in the request body. Missing properties MUST be set to their default values.

If the request is a PATCH or MERGE request, the server MUST replace exactly those property values that are specified in the request body. Missing properties MUST NOT be altered. Exact semantics are defined in <ref>PATCH and MERGE</ref>.

On success, the response must be a valid [update response](#responsesforupdates).

#### Update a PrimitiveProperty ####

To update a value, the client MAY send a PUT, MERGE, or PATCH request to an edit URI for a SimpleProperty. The message body MUST contain the desired new value, formatted as a <ref>SimpleTypeProperty</ref>.

Regardless of which verb is used, the server MUST replace the entire value with the value supplied in the request body.

The same rules apply whether this is a regular property or a dynamic property.

On success, the response must be a valid [update response](#responsesforupdates).

#### Update a CollectionProperty ####

To update a value, the client MAY send a PUT request to an edit URI for a CollectionProperty. The message body MUST contain the desired new value, formatted as a <ref>CollectionProperty</ref>.

The server MUST replace the entire value with the value supplied in the request body.

On success, the response must be a valid [update response](#responsesforupdates).

### Common Rules for FunctionImport elements (or Operations) ###

Operations (ServiceOperations, Actions and Functions) are represented as FunctionImport elements under an EntityContainer element. 

The following rules apply to all FunctionImport elements:

- MUST have a 'Name' attribute set to a valid EDM identifier.
- MUST either omit a ReturnType (in the case of void operations) or specify a ReturnType either by including a 'ReturnType' attribute set to a valid TypeReference or by including a child 'ReturnType' element. 
- MAY have child Parameter elements.
- MAY have an 'IsSideEffecting' attribute set to either 'true' or 'false'. When omitted 'IsSideEffecting' MUST be interpretted as 'true'. 
- MAY have a 'm:HttpMethod' attribute set to value of either 'POST' or 'GET'. When omitted 'm:HttpMethod' MUST be interpretted as not specified.
- MAY have an 'IsBindable' attribute set to either 'true' or 'false'. When 'IsBindable' is set to 'true' the FunctionImport MUST have at least one child Parameter element, and the first child Parameter element MUST have a type that is either an EntityType or a collection of EntityTypes. When omitted 'IsBindable' MUST be assumed to have a value of 'false'.
- MAY have an 'm:IsAlwaysBindable' attribute set to either 'true' of 'false'. When omitted 'm:IsAlwaysBindable' MUST be assumed to have a value of 'false'. When 'IsAlwaysBindable' is 'true', 'IsBindable' MUST also be set to 'true'.
- MUST have an 'EntitySet' attribute set to either the name of an EntitySet or to an EntitySetPath expression if the 'ReturnType' of the FunctionImport is either an EntityType or a Collection of an EntityType.
- TODO: overload rules (i.e. unordered combination of parameter names & types must be unique).

#### EntitySetPathExpression ####

Functions or Actions that return an Entity or Entities MAY return results from an EntitySet that is dependent upon the EntitySet of one the parameter values used to invoke the Operation.

When such a dependency exists an EntitySetPathExpression is used. An EntitySetPathExpression MUST begin with the name of a parameter to the Operation, and optionally includes a series NavigationProperties (and occasional type casts) as a succinct way to describe the series of EntitySet transitions. 

The actual EntitySet transitions may be deduced by finding the AssociationSet backing each NavigationProperty, and moving from the current EntitySet which will be found on one End to the EntitySet found on the other End. 

The EntitySet of the results of an Operation Invocation with an EntitySetPathExpression can only be established once the EntitySet of the parameter that begins the EntitySetPathExpression is known.

For example this EntitySetPathExpression: "p1/Orders/Customer" can only be evaluted once the EntitySet of the p1 parameter value is known.

### Common Rules for Binding Operations ###

Some Operations (Actions and Functions but not ServiceOperations) support binding if the 'IsBindable' attribute is set to 'true'. When Binding is supported the first parameter of an Operation is the 'Binding Parameter'. 

In OData version 3 binding parameters MUST be of a Type that is either an EntityType or a collection of EntityType.

Any url that can identify a 'Binding Parameter' of the correct type MAY be used as the foundation of a uri to invoke an Operation that supports Binding using the resource identified by that url as the 'Binding Parameter Value'.

For example, the Function

	<FunctionImport Name="MostRecentOrder" ReturnType="SampleModel.Order" EntitySet="Orders" IsBindable="true" IsSideEffecting="false" m:IsAlwaysBindable="true">
		<Parameter Name="customer" Type="SampleModel.Customer" Mode="In" />
	</FunctionImport>`

can be bound to any url that identifies a SampleModel.Customer, two examples might be:

`GET http://server/Customers(6)/MostRecentOrder() HTTP/1.1`

Which invokes the MostRecentOrder Function with the 'customer' or binding parameter value being the resource identified by http://server/Customers(6)/.

`GET http://server/Contacts(23123)/Company/MostRecentOrder() HTTP/1.1`

Which again invokes the MostRecentOrder function, this time with the 'customer' or binding parameter value being the resource identified by http://server/Contacts(23123)/Company/. 

### Actions ###

Actions are operations exposed by an OData server that have side effects when invoked and optionally return some data.

#### Declaring Actions in Metadata ####

A server that supports Actions SHOULD declare them in $metadata. Actions that are declared MUST be specified using a FunctionImport element, that indicates the signature (Name, ReturnType and Parameters) of the Action. 

In addition to the [Common Rules for FunctionImports](#commonrulesforfunctionimports) the following rules apply for FunctionImport elements that represent Actions:

- Actions MUST NOT specify the 'm:HttpMethod' attribute as this is reserved for ServiceOperations.
- Actions MUST be side effecting, indicated by either omiting or setting the 'IsSideEffecting' attribute to 'true'.
- Actions MUST NOT be composable, indicated by either omiting or setting the 'IsComposable' attribute  to 'false'.

For example this FunctionImport represents an Action that Creates an Order for a customer using the specified quantity and discountCode, which can be bound to any resource path that represents a Customer entity:

	<FunctionImport Name="CreateOrder" IsBindable="true" IsSideEffecting="true" 
					m:IsAlwaysBindable="true">
    	<Parameter Name="customer" Type="SampleModel.Customer" Mode="In">
		<Parameter Name="quantity" Type="Edm.Int32" Mode="In">
		<Parameter Name="discountCode" Type="Edm.String" Mode="In">
	</FunctionImport>

#### Advertising Currently Available Actions ####

The existing OData Formats (application/atom+xml and application/json;odata=verbose) require all Actions that are currently available for the current entity or current collection of entities be advertized inside any representation of the entity or collection entities returned from the Server.

It may be resource intensive to determine whether an Action is currently available on a particular Entity or EntitySet. If this calculation would be too expensive, a server SHOULD advertize the Action as if it is available. The server MAY fail later if the client attempts to invoke the Action and it is found to be not available.

The following information MUST be included when an Action is advertized: 

- A 'Target Url' that MUST identify the resource that accepts requests to invoke the Action.
- A 'Metadata Url' that MUST identify the FunctionImport that declares the Action. This Url can be either relative or absolute, but when relative it MUST be assumed to be relative to the $metadata Url of the current server.
- A 'Title' that MUST contain a human readable description of the Action.

Example: Given this client request:

	GET /service.svc/Customers('ALFKI') HTTP/1.1
	Host: host
	Accept: application/json
	DataServiceVersion: 1.0
	MaxDataServiceVersion: 3.0

The server might respond with a Customer entity that advertizes a binding of the `SampleEntities.CreateOrder` Action to itself:

	HTTP/1.1 200 OK
	Date: Fri, 12 Dec 2008 17:17:11 GMT
	Content-Type: application/json
	Content-Length: nnn
	ETag: W/"X'000000000000FA01'"
	DataServiceVersion: 3.0

	{"d":
	 { 
	   "__metadata": { 
	       "uri": "Customers(\'ALFKI\')", 
	       "type": "SampleModel.Customer",
	       "etag": "W/\"X\'000000000000FA01\'\"" 
	       "properties" : {
	           "Orders" : {
	              "__associationuri" : "Customers(\'ALFKI\')/SampleModel.Customer/$links/Orders",
	           }
	       },
	       "actions" : {
	           "SampleEntities.CreateOrder" : [{
	               "title" : "Create Order",
	               "target" : "Customers(\'ALFKI\')/SampleEntities.CreateOrder"
	           }]
	       }
	   },  
	   "CustomerID": "ALFKI", 
	   "CompanyName": "Alfreds Futterkiste", 
	   "Version": "AAAAAAAA+gE=",
	   "Orders":  { "__deferred": { "uri": "Customers(\'ALFKI\')/SampleModel.Customer/Orders" } }
	 }
	}

When the resource retrieved represents a collection, the 'Target Url' of any Actions advertized MUST encode every System Query Option used to retrieve the collection. In practice this means that any of these System Query Options should be encoded: $filter, $expand, $orderby, $skip and $top.

An efficient format that assumes client knowledge of metadata SHOULD NOT advertize Actions whose availability ('IsAlwaysBindable' is set to 'true') and target url can be established via metadata. 

#### Invoking an Action ####

To invoke an Action a client MUST make a POST request to the 'Target Url' of the Action. 

If the Action supports binding the binding parameter value MUST be encoded in the 'Target Url'. Background: In OData version 3 only parameters of an EntityType or collection of EntityType are permitted to be binding parameters, and there is no way to specify these types of parameter values in the request body, hence the binding parameters can only be specified in the 'Target Url'.

If the invoke request contains any non-binding parameter values, the Content-Type of the request MUST be 'application/json', and the parameter values MUST be encoded in a single JSON object in the request body. 

Each non-binding parameter value specified MUST be encoded as a separate 'name/value' pair in a single JSON object that comprises the body of the request. Where the name is the name of the Parameter and the value is the Parameter value which is an instance of the type specified by the parameter in JSON format. Any parameter values not specified in the JSON object MUST be assumed to be null.

If the Action returns results the client SHOULD use content type negotiation to request the results in the desired format, otherwise the default content type will be used.

If a client only wants an Action invoke request to be processed when the binding parameter value, an Entity or collection of Entities, is unmodified, the client SHOULD include the 'If-Match' header with the latest known ETag value for the Entity or collection of Entities. When presents a Server MUST attempt to verify that the ETag found in the 'If-Match' header is current before processing the request. If the ETag cannot be verified or is found to be out of date the server response MUST be '412 Precondition Failed'. 

On success, the response SHOULD be '200 OK' for Actions with a return type or '204 No Content' for Action without a return type. 

Example: This request invokes the `SampleEntities.CreateOrder` action using `/Customers('ALFKI') `as the customer (or binding parameter): 

       POST /Customers('ALFKI')/SampleEntities.CreateOrder HTTP/1.1
       Host: host
       Content-Type: application/json
       DataServiceVersion: 3.0
       MaxDataServiceVersion: 3.0
       If-Match: ...ETag...
       Content-Length: ####

       {
          "quantity": 2,
          "discountCode": "BLACKFRIDAY"
       }

HTTP Response:
     HTTP/1.1 204 OK
     Date: Fri, 11 Oct 2008 04:23:49 GMT


### Functions ###

Functions are operations exposed by an OData server which MAY have parameters and MUST return data and MUST have no observable side effects.  

#### Declaring Functions in Metadata ####

A server that supports Functions SHOULD declare them in $metadata. Functions that are declared MUST be specified using a FunctionImport element, that indicates the signature (Name, ReturnType and Parameters) and semantics (composability, bindability and result entityset) of the Function. 

In addition to the [Common Rules for FunctionImports](#commonrulesforfunctionimports) the following rules apply for FunctionImport elements that represent Functions:

- Functions MUST NOT specify the 'm:HttpMethod' attribute as this is reserved for ServiceOperations.
- Functions MUST NOT be side effecting, indicated by setting the 'IsSideEffecting' attribute to 'false'.
- Functions MAY be composable, indicated by setting the 'IsComposable' attribute  to 'true'.

This is an example of an Function called MostRecent that returns the 'MostRecent' Order from amongst a collection of Orders:

	<FunctionImport Name="MostRecent" EntitySet="Orders" ReturnType="SampleModel.Order" IsBindable="true" IsSideEffecting="false"
					m:IsAlwaysBindable="true">
		<Parameter Name="orders" Type="Collection(SampleModel.Order)" Mode="In">
	</FunctionImport>

#### Advertizing currently available Functions ####

Servers are allowed to choose whether to advertize Functions that can be bound to the current entity or current collection of entities inside representations of the entity or collection entities returned from the Server. 

If the server chooses to advertize a Function the following information MUST be included: 

- A 'Target Url' that MUST identify the resource that accepts requests to invoke the Function.
- A 'Metadata Url' that MUST identify the FunctionImport (and potentially overload) that declares the Function. This Url can be either relative or absolute, but when relative it MUST be assumed to be relative to the $metadata Url of the current server.
- A 'Title' that MUST contain a human readable description of the Function.

Example: Given this client request:

	GET /service.svc/Orders HTTP/1.1
	Host: host
	Accept: application/json
	DataServiceVersion: 1.0
	MaxDataServiceVersion: 3.0

The server might respond with a collection of Orders that advertizing the `SampleEntities.MostRecent` Function bound to itself:

	HTTP/1.1 200 OK
	Date: Fri, 12 Dec 2008 17:17:11 GMT
	Content-Type: application/json
	Content-Length: nnn
	DataServiceVersion: 3.0

	{
		"__metadata": {
			"functions": "SampleEntities.MostRecent" : [{
	               "title" : "Most Recent Order",
	               "target" : "Orders/SampleEntities.MostRecent"
	           }]
		},
		"d": [
	         {
	            "__metadata": { "uri": "Orders(1)",
	                            "type": "SampleModel.Order",
	                            "properties" : {
	                              "Customer" : {
	                                "__associationuri" : "Orders(1)/SampleModel.Order/$links/Customer",
	                              },
	                              "OrderLines" : {
	                                "__associationuri" : "Orders(1)/SampleModel.Order/$links/OrderLines",
	                              }
	                            } 	
	                          },
	            "OrderID": 1,
	            "ShippedDate": "\/Date(872467200000)\/",
	            "Customer":   { "__deferred": { "uri": "Orders(1)/SampleModel.Order/Customer" } }
	            "OrderLines": { "__deferred": { "uri": "Orders(1)/SampleModel.Order/OrderLines"} }
	         },
	         {
	            "__metadata": { "uri": "Orders(2)",
	                            "type": "SampleModel.Order",
	                            "properties" : {
	                              "Customer" : {
	                                "__associationuri" : "Orders(2)/SampleModel.Order/$links/Customer",
	                              },
	                              "OrderLines" : {
	                                "__associationuri" : "Orders(2)/SampleModel.Order/$links/OrderLines",
	                              }
	                            } 
	
	                          },
	            "OrderID": 2,
	            "ShippedDate": "\/Date(875836800000)\/",
	            "Customer":   { "__deferred": { "uri": "Orders(2)/SampleModel.Order/Customer"} }
	            "OrderLines": { "__deferred": { "uri": "Orders(2)/SampleModel.Order/OrderLines"} }
	
	         }
	]}
 
 
When the resource retrieved represents a collection, the 'Target Url' of any Functions advertized MUST encode every System Query Option used to retrieve the collection. In practice this means that any of these System Query Options should be encoded: $filter, $expand, $orderby, $skip and $top.

An efficient format that assumes client knowledge of metadata SHOULD NOT advertize Functions whose availability ('IsAlwaysBindable' is set to 'true') and target url can be established via metadata.

#### Invoking a Function ####

To invoke a Function directly a client MUST issue a GET request to a Url that identifies the Function and that specifies any parameter values required by the Function. 

It is also possible to invoke a Function indirectly using GET, PUT, POST, PATCH or DELETE requests by formulating a Uri that identifies a Function and its parameters and then appending further path segments to create a Request Uri that identifies resources related to the results of the Function.

Parameter Values passed to Functions MUST be specified either as a Uri Literal (for Primitive Types) or as a JSON formatted OData object (for ComplexTypes or Collections of Primitive Types or ComplexTypes). 

Functions calls MAY be present in the Request Uri Path or the Request Uri Query inside either the $filter or $orderby Query Options. 

##### Inline Parameter Syntax #####

The simpliest way to pass parameter values to a Function is using inline parameter syntax.

To use Inline Parameter Syntax, whereever a Function is called, parameter values MUST be specified inside the parenthesis, i.e. `()`, appended directly to the Function name. 

The parameter values MUST be constructed by concatenating Name/Value pairs for each parameter separated by `,`'s, where the Name/Value pairs are in the format `Name=Value` and where `Name` is the Name of the parameter to the Function and `Value` is the parameter value.

For example this request:

	GET http://server/service.svc/NS.Foo(p1=3,p2="hello") HTTP/1.1

Invokes a `NS.Foo` function which takes two parameters (`p1` of type Edm.Int32 and `p2` of type Edm.String), by passing `3` and `"hello"` as the values of `p1` and `p2` respectively.

And this request:

	GET http://server/service.svc/Customer?$filter=NS.GetSalesRegion(p1=$it/City) eq "Western" HTTP/1.1

Filters `Customers` to those in the `Western` sales region, calculated for each Customer in the Collection by passing the Customer's City as the `p1` parameter value to the `NS.GetSalesRegion` function. 

Parameters values MAY be provided to Functions in the Request Uri path using inline syntax for primitive parameter types only, all other parameter types MUST be provided externally. 

##### Parameter Alias Syntax #####

Another way to pass parameter values is by using Parameter Alias Syntax.

To use Parameter Alias Syntax, whereever a Function is called, parameter aliases MUST be specified inside parenthesis, i.e. `()`, appended directly to the Function name, and actual parameter values MUST be specified as Query options in the Query part of the Request Uri. The Query option name is the Name of the Parameter Alias, and the Query option value is the Value of any parameter that refers to this Parameter Alias.

The parameter aliases MUST be constructed by concatenating Name/Value pairs for each parameter separated by `,`'s, where the Name/Value pairs are in the format `Name=Value` and where `Name` is the Name of the parameter to the Function and `Value` is a Parameter Alias. Parameter aliases MUST begin with `@`. 

For example these requests are equivalent:

	GET http://server/service.svc/NS.Foo(p1=3,p2="hello") HTTP/1.1
	GET http://server/service.svc/NS.Foo(p1=@p1,p2=@p2)?@p1=3&@p2="hello" HTTP/1.1

Parameter Alias Syntax has a number of advantages over Inline syntax:

- Parameter Values MAY be non-primitive
- A single Parameter Alias (and thus Parameter Value) MAY be bound to multiple Function calls, which can shorten urls significantly, especially when dealing with large Geospatial or structural parameter values.

If a Parameter Alias referenced by a Function call is not given a value in the Query part of the Request Uri, the value MUST be assumed to be null.

##### Parameter Name Syntax #####

The OData protocol allows parameter values for the last Function call in a Request Uri Path to be specified by appending Name/Value pairs, representing each parameter Name and Value for that Function, as query strings to the Query part of the Request Uri. 

This is useful because it means clients, in particular rudimentary clients, MAY invoke advertized Functions without parsing the advertized Target Url (as would be required to either inject parameter values using [Inline Parameter Syntax] or identify Parameter Aliases so that Parameter Values can be provided using [Parameter Alias Syntax]). 

This means that all of these requests are equivalent:

	GET http://server/service.svc/Entities(6)/NS.Foo(p1=3,p2="hello")/NavigationProperty HTTP/1.1
	GET http://server/service.svc/Entities(6)/NS.Foo(p1=@p1,p2=@p2)/NavigationProperty?@p1=3&@p2="hello" HTTP/1.1
	GET http://server/service.svc/Entities(6)/NS.Foo/NavigationProperty?p1=3&p2="hello" HTTP/1.1

Notice though that only the third request can be built without complicated Parsing logic when `http://server/service.svc/Entities(6)/NS.Foo/NavigationProperty` is advertized as the [Target Url] of an available Function to a client which has knowledge of signature for `NS.Foo`.  

#### Function overload resolution ####

Functions overloads are supported in OData, meaning a server MAY expose multiple Functions with the same name that take a different set of parameters.

When a function is invoked (using any of the 3 parameter syntaxes) the parameter names and parameter values are specified in the URL, and the parameter types can be deduced from each parameter value. The combination of the Function name, and the unordered parameter names and types is always sufficient to identify a particular Function overload. 

### Service Operations ###

Service Operations are Operations like Actions and Functions. However use of Service Operations is now discouraged because they are legacy and have a number of disadvantages:

- Service Operation Semantics are unclear - for example a Service Operation that is invoked with a GET MAY have side effects and a Service Operation that is invoked with a POST MAY have no side-effects.
- Service Operations only support primitive parameter types.
- Unlike Functions, composing Multiple Service Operations calls in the same request is not supported.

#### Declaring Service Operations in Metadata ####

A server that supports Service Operations MUST declare them in $metadata using a FunctionImport element, that indicates the signature (Name, ReturnType and Parameters) and semantics (http verb and result entityset) of the Service Operation. 

In addition to the [Common Rules for FunctionImports] the following rules apply for FunctionImport elements that represent Service Operations:

- Service Operations MUST specify the 'm:HttpMethod' attribute, to indicate which HttpMethod (GET or POST) is required to invoke the Service Operation.
- Service Operations MUST omit the 'IsComposable' attribute or set its value to 'false'.
- Service Operations MUST omit the 'IsBindable' attribute or set its value to 'false'.
- Service Operations MUST omit the 'm:IsAlwaysBindable' attribute or set its value to 'false'.

#### Invoking a Service Operation ####

To invoke a ServiceOperation the Request Uri used MUST begin with the Uri of the Service Document, followed by a path segment containing the Name or Namespace Qualified Name of the ServiceOperation and optionally parentheses.

For example:

	http://server/service.svc/ServiceOperation or http://server/service.svc/ServiceOperation()

The HttpMethod (either GET or POST) used to invoke the ServiceOperation MUST match the HttpMethod specified by the 'm:HttpMethod' attribute on the FunctionImport that defines the ServiceOperation. 

Even when the Service Operation when POST is required to invoke the ServiceOperation the Body of the Invoke Request SHOULD be empty. 

Any Parameter Values MUST be encoded into the Query part of the Request Uri, as individual Query string Name/Value pairs, where the Name is the Parameter Name and the Value is a UriLiteral representing the parameter value.

NOTE: Because all Service Operation parameters must be primitive all Service Operation Parameter can be represented as UriLiterals.

For example given this ServiceOperation:

	<FunctionImport Name="CreatePerson" EntitySet="People" ReturnType="NS.Person" m:HttpMethod="POST">
		<Parameter Name="Firstname" Type="Edm.String" Mode="In" />
		<Parameter Name="Surname" Type="Edm.String" Mode="In" />
		<Parameter Name="DateOfBirth" Type="Edm.Datetime" Mode="In" />
	</FunctionImport>

This request:

	POST http://server/service.svc/CreatePerson?Firstname="John"&Surname="Smith"&DateOfBirth=datetime'1971-07-07T13:03:00' HTTP/1.1

    DataServiceVersion: 3;
	Accept: application/json;
 
Invokes the `CreatePerson` ServiceOperation with the following Parameter values:

- Firstname: `"John"`
- Surname: `"Smith"`
- DateOfBirth: `datetime'1971-07-07T13:03:00'`

If the ServiceOperation specifies a ReturnType it MAY be possible to compose further OData path and/or Query Options after the segment that identifies the ServiceOperation. 

For example given this ServiceOperation:

	<FunctionImport Name="GetOrdersByDate" EntitySet="Orders" ReturnType="Collection(NS.Order)" m:HttpMethod="GET">
		<Parameter Name="OrderDate" Type="Edm.Datetime" Mode="In" />
	</FunctionImport>

This request:

	GET http://server/service.svc/GetOrdersByDate/$filter=Customer/Name eq 'ACME'&OrderDate=datetime'2012-07-07T01:03:00' HTTP/1.1

    DataServiceVersion: 3;
	Accept: application/json;

Invokes the `GetOrdersByDate` ServiceOperation with the `OrderDate` parameter value of `datetime'2012-07-07T01:03:00` and then further filters the results so only the Orders for `ACME` on that date are returned.

### Batch Processing ###

------

- ASSIGNED TO: MikeF

------
<<<<<<< HEAD
=======

# Appendices #

#Appendix A: Formal Common Schema Definition Langauge (CSDL)#

------

- ASSIGNED TO: MikeP

------

OData services are described by an Entity Data Model (EDM). The Common Schema Definition Language (CSDL) defines an XML-based description of the Entity Model exposed by an OData service.

## 1. Common Schema Defintion Language (CSDL) Namespaces ##

In addition to the (default) XML namespace, attributes and elements used to describe the entity model of an OData service are defined in one of the following namespaces.

### 1.1.	Entity Data Model For Data Services Packaging (EDMX) Namespace ###

Elements and attributes associated with the top-level wrapper that contains the CSDL used to define the entity model for an OData Service are qualified with the Entity Data Model For Data Services Packaging Namespace:  "http://schemas.microsoft.com/ado/2007/06/edmx".

In this specification the namespace prefix "edmx" is used to represent the Entity Data Model for Data Services Packaging Namespace, however the prefix name is not prescriptive.

### 1.2.	Entity Data Model (EDM) Namespace ###

Elements and attributes that define the entity model exposed by the OData Service are qualified with the Entity Data Model Namespace:  "http://schemas.microsoft.com/ado/2007/06/edm".

In this specification the namespace prefix "edm" is used to represent the Data Service Metadata Namespace, however the prefix name is not prescriptive.

### 1.3.	Data Service Metadata Namespace ###

Elements and attributes specific to how the entity model is exposed as an OData Service are qualified with the Data Service Metadata Namespace:  "http://schemas.microsoft.com/ado/2007/08/DataServices/Metadata".

In this specification the namespace prefix "metadata" is used to represent the Data Service Metadata Namespace, however the prefix name is not prescriptive.

## 2 Entity Model Wrapper Constructs ##
The Entity Model Wrapper wraps the Schemas that describe the entity model exposed by the the OData Service. 

### 2.1. The "edmx:EDMX" Element ###
The CSDL returned by an OData Service MUST contain a single root `edmx:EDMX` Element, containing a single child `edmx:DataServices` element describing the entity model(s) exposed by the OData service.

#### 2.1.1. The "Version" Attribute ####
The `Version` attribute, as described in **todo:ref xmlschema**, MUST be present on the `edmx:EDMX` element. 

The Version attribute is a string value that specifies the version of the EDMX wrapper, and must be of the form
`majorversion + "." + minorversion`. This version of the specification defines version `"1.0"` of the EDMX Wrapper.

### 2.2 The "edmx:DataServices" Element ###
The `edmx:EDMX` element MUST contain exactly one `edmx:DataService` element. The `edmx:DataService` element contains zero or more `Schema` elements, defining the schema(s) exposed by the OData service.

#### 2.2.1. The "metadata:DataServiceVersion" Attribute ####


## 3. Schema Constructs ##
Each Entity Model exposed by the OData service is described by a Schema.

### 2.3 The "Schema" Element ###
#### 2.3.1. The "Namespace" Attribute ####

## 3. Entity Type Constructs ##
Entity Types are nominal structured records with a key that consist of named primitive or complex properties.

### 3.1. The "edm:EntityType" Element ###
### 3.2 The "edm:Key" Element ###
### 3.3. The "edm:PropertyRef" Element ###
### 3.4. The "edm:Property" Element ###
### 3.5. The "edm:NavigationProperty" Element ###

## 4. Complex Type Elements ##
Complex Types are nominal structured types also consisting of a list of properties but with no key, thus can only exist as a property of a containing Entity Type or as a temporary value. 

### 4.1. The "edm:ComplexType" Element ###

## 5. Association Constructs ##
Associations define the relationship between two or more Entity Types 

### 5.1. The "edm:Association" Element ###

## 6. Entity Containers
Instances of EntityTypes live within EntitySets. Instances of Associations live within AssociationSets. All Entity Sets and Association Sets are grouped in an Entity Container.

### 6.1. The "edm:EntityContainer" Element ###
### 6.2. The "edm:EntitySet" Element ###
### 6.3. The "edm:AssociationSet" Element ###


## B: XSD for CSDL ##

------

- ASSIGNED TO: Alex

------

# C: Terminology #

------

- ASSIGNED TO: Everyone

------

*bound Action invocation URL*: the URL that can be used to invoke a particular Action bound to a particular Entity or collection of Entities.

*bound Function invocation URL*: the URL that can be used to invoke a particular Function bound to a particular Entity or collection of Entities.

Action *title*: a descriptive name used for an Action. This is intended to be presented to an end user.

Function *title*: a descriptive name used for a Function. This is intended to be presented to an end user.

>>>>>>> 847c543a84f5d90f0d5768dceca1cc4595103cf1
