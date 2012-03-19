# OData Verbose Json Format #

# Overview #

The OData protocol is comprised of a set of specifications for representing and interacting with structured content. The core specification for the protocol is in <ref>core</ref>; this document is an extension of the core protocol. This document defines representations for the OData requests and responses using a verbose Json format.

An OData Json payload may represent:

* a single Primitive value
* a Collection of Primitive values
* a single ComplexType
* a sequence of ComplexTypes
* a single Entity
* a sequence of Entities
* a service document describing the EntitySets exposed by the service
* an error
* a batch of requests to be executed in a single request
* a set of responses returned from a batch request

Most payloads are represented identically in requests and responses. There are some differences. This document first defines the common formats, then discusses formats that are specific to request or responses.

# 2. Notational Conventions #

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [[RFC2119](http://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")].

## 2.1 Normative References ##

- Normative reference to the OData core document

## 2.2 Informational Examples ##

This document contains many example Json payloads or partial Json payloads. These examples are informative only. The text shall be taken as the normative specification.

# 3 Requesting Verbose Json Format #

Verbose Json is not the default OData format. To receive responses in Verbose Json, the client MUST explicitly ask for them.

To request this format using <ref>$format</ref>, use the value "jsonverbose". To request this format using the <ref>Accepts header</ref>, use the MIME type "application/json;odata=verbose".

# 4 Common Payload Format #

This section describes the representation for OData values in Verbose Json. A request or response body consists of several parts. It contains OData values as part of a larger document. See <ref>Request Formats</ref> and <ref>Response Formats</ref> for the specification of request and response bodies.

## 4.1 Representing an Entity ##

An instance of an EntityType MUST be serialized as a JSON object.

Each Property to be transmitted MUST be represented as a name/value pair within the object. See [Representing a Property](#representingaproperty) for details. The order Properties appear withing the object MUST be considered insignificant. Name/value pairs not representing a property defined on the EntityType SHOULD NOT be included.

An Entity in a payload MAY be a complete Entity, a projected Entity (see <ref>`$select`</ref>), or a partial Entity update (see <ref>Patch</ref>). A complete Entity MUST transmit every property. A projected Entity MUST transmit the requested properties and MAY transmit other properties. A partial Entity MUST transmit the properties that it intends to change; it MUST NOT transmit any other properties.

The name in a property's name/value MUST NOT be `__metadata`. There is no Json Verbose representation for a property named `__metadata`.

An Entity Json object MAY include a name/value pair named `__metadata`. This name/value pair does not represent a property. It specifies the metadata for the Entity. The ordering of this name/value pair with respect to name/value pairs that represent properties MUST be considered insignificant.

### 4.1.1 Entity Metadata ###

The value of the `__metadata` property MUST be Json object.

In OData 1.0 and OData 2.0, the value of the `__metadata` property contains seven name/value pairs: `uri`, `type`, `etag`, `edit_media`, `media_src`, `media_etag`, and `content_type`. In OData 3.0, four more name/value pairs are added: `properties`, `actions`, `functions`, and `id`. The order of these name/value pairs MUST be considered insignificant.

If the Entity is not a Media Link Entry, then the `edit_media`, `media_src`, `media_etag`, and `content_type` name/value pairs MUST NOT be included.

The value of the `uri` name/value pair MUST be the Canonical URI identifying the Entity.

The `type` name/value pair MUST be included if the Entity's EntityType is part of an inheritance hierarchy, as described in <ref>CSDL</ref>. If the EntityType is not part of an inheritance hierarchy, then the `type` name/value pair MAY be included. The value of the `type` name/value pair MUST be the namespace qualified name of the Entity's EntityType.

The `etag` name/value pair MAY be included. When included, it MUST represent the concurrency token associated with the Entity <ref>ETag</ref>. When present, this value MUST be used instead of the <ref>ETag HTTP header</ref>.

The `id` name/value pair MAY be included if the server is using OData 2.0 and MUST be included if the server is using OData 3.0.

The value of the `properties` name/value pair MUST be an array. It MAY contain a JSON object for each NavigationProperty. See [Representing a NavigationProperty](#representinganavigationproperty) for details.

The `actions` name/value pair MAY be included in a response if the server is advertising actions. See [Entity Metadata for Actions](#entitymetadataforactions) for details.

The `functions` name/value pair MAY be included in a response if the server is advertising functions. See [Entity Metadata for Functions](#entitymetadataforfunctions) for details.

The `actions` and `functions` name/value pairs MAY be included in request payloads. In requests they are without meaning and MUST be ignored by the server.

#### 4.1.1.1 Entity Metadata for Media Link Entries ####

The `media_src` and `content_type` name/value pairs MUST be included and the `edit_media` and `media_etag` name/value pairs MAY be included if the Entity is a Media Link Entry.

The value of the `media_src` name/value pair MUST be the source URI for the data corresponding to this MLE.

The value of the `content_type` name/value pair MUST be the MIME type of the data corresponding to this MLE.

The value of the `edit_media` name/value pair MUST be the edit URI for the data corresponding to this MLE.

The value of the `media_etag` name/value pair MUST be the concurrency token for the data corresponding to this MLE.

#### 4.1.1.2 Entity Metadata for Actions ####

Starting in the OData 3.0 protocol, the `actions` name/value pair MAY be included in `__metadata`. The value is a JSON object that contains one name/value pair for each Action that the server wishes to advertise.

For each name/value pair, the name MUST be an Action Metadata URL. The value MUST be an array of JSON objects. Any number of JSON objects is allowed in this array. Each object in this array MUST have at least two name/value pairs: `title` and `target`. The order of these name/value pairs MUST be considered insignificant.

The `target` name/value pair MUST contain a bound action invocation URL.

The `title` name/value pair MUST contain a simple string. Servers SHOULD specify a value that would be easily understood by any user. The title is likely to be used by clients to display options to an end user.

#### 4.1.1.3 Entity Metadata for Functions ####

Starting in the OData 3.0 protocol, the `functions` name/value pair MAY be included in `__metadata`. The value is a JSON object that contains one name/value pair for each Action that the server wishes to advertise.

For each name/value pair, the name MUST be a Function Metadata URL. The value MUST be an array of JSON objects. Any number of JSON objects is allowed in this array. Each object in this array MUST have at least two name/value pairs: `title` and `target`. The order of these name/value pairs MUST be considered insignificant.

The name MUST only identify functions that are bindable to the current EntityType. If overloads exist that cannot be bound to the current EntityType, 

-- TODO:

**Don't know what to do here. The OIPI had a bug; Alex will answer and then I'll fix it**.

If all Function overloads can be bound to the current EntityType, the server SHOULD advertise a single Function Metadata URL that identifies all of the overloads.

The `target` name/value pair MUST contain a bound function invocation URL.

The `title` name/value pair MUST contain a simple string. Servers SHOULD specify a value that would be easily understood by any user. The title is likely to be used by clients to display options to an end user.

## 4.2 Representing a Property ##

A Property is represented as a name/value pair. The name is the Property's name.

The value for a PrimitiveProperty or ComplexTypeProperty is the Property's value. It MUST be formatted appropriately for its type.

The value for a NavigationProperty MUST be a string. This string MUST be  the URI that can be used to manage the relationship between the related entities.

## 4.3 Representing a Primitive Value ##

The representation for primitives in Json Verbose is specified in <ref>the ABNF</ref>.

## 4.4 Representing a ComplexType Value ##

# 5 Request Specifics #

## 5.1 Representing Multiple Entities in a Request ##

An EntitySet or collection of entities MUST be represented as a Json array. Each element MUST be a correctly formatted Entity (see [Representing an Entity](#representinganentity)).

An empty EntitySet or collection of entities (one that contains no EntityType instances) MUST be represented as an empty JSON array.

# 6 Response Specifics #

This section describes additional payloads semantics that only apply to response payloads.

## 6.1 Response body ##

## 6.2 MIME Type ##

Verbose Json is represented with a Content-Type of "application/json;odata=verbose".

In OData 1.0 and 2.0, it was also represented with a Content-Type of "applicaton/json". However, in OData 3.0, "application/json" has been redefined to mean <ref>Json Light</ref>.

## 6.3 Representing Multiple Entities in a Response ##

In OData 1.0, an EntitySet of collection of Entities in a response is formatted just like in a request. See [Representing Multiple Entities in a Request](#representingmultipleentitiesinarequest) for details.

The rest of this section applies to OData 2.0 and 3.0 only.

An EntitySet or collection of Entities MUST be represented as a Json object. This object MUST contain a `results` name/value pair. It MAY contain `__count`, `__next`, or `__metadata` name/value pairs.

The `results` value MUST be a Json array. Each element MUST be a correctly formatted Entity (see [Representing an Entity](#representinganentity)).

The `__count` name/value pair represents the inlinecount. Its value MUST be an integer. See <ref>inlinecount</ref> for details on when it is required and when it is prohibited.

The `__next` name/value pair MAY be included. If provided, its value MUST be a string containing a URL. If provided, then the response MUST be interpreted as a partial result. The client MAY request this URL if it wishes to receive the next part of the collection or EntitySet.

The `__metadata` name/value pair MAY be included. If provided, its value MUST be a Json object. This object represents the metadata for the set of Entities.

An empty EntitySet or collection of entities (one that contains no EntityType instances) MUST be represented as a Json object with a `results` name/value pair. The `results` name/value pair MUST be an empty JSON array.

## 6.3.1 Representing Actions Bound to Multiple Entities ##

In the ODATA 3.0 protocol, it is possible to advertise Actions that are bound to the definition of a set of Entities.

Actions are advertised in the metadata for a set of Entities. The metadata object MAY contain an `actions` name/value pair . The value is a JSON object that contains one name/value pair for each Action that the server wishes to advertise.

For each name/value pair, the name MUST be an Action Metadata URL. The value MUST be an array of JSON objects. Any number of JSON objects is allowed in this array. Each object in this array MUST have at least two name/value pairs: `title` and `target`. The order of these name/value pairs MUST be considered insignificant.

The `target` name/value pair MUST contain a bound action invocation URL.

The `title` name/value pair MUST contain a simple string. Servers SHOULD specify a value that would be easily understood by any user. The title is likely to be used by clients to display options to an end user.

Actions advertised in the set of Entities MUST be interpreted as being bound to the definition of the set and not to the items that are contained in it.

Actions that are advertised in the set of Entities MUST be advertised only if the server can fully encode the action, the resource path, and the appropriate system query options that define the set.

<ref>System query options</ref> that change the membership of the set of Entities MUST be considered part of the set definition. In practice, this means that the target URL that is used to invoke the action MUST encode the following system query options if they are used:

* $filter
* $expand
* $orderby
* $skip
* $top

## 6.3.2 Representing Functions Bound to Multiple Entities ##

## 6.4 Errors ##

## 6.5 Next Links ##

## Response-Level Properties ##

- Others?
