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

The value of the `properties` name/value pair MAY contain a JSON object for each NavigationProperty. See [Representing a NavigationProperty](#representinganavigationproperty) for details.

### 4.1.1.1 Entity Metadata for Media Link Entries ###

The `media_src` and `content_type` name/value pairs MUST be included and the `edit_media` and `media_etag` name/value pairs MAY be included if the Entity is a Media Link Entry.

The value of the `media_src` name/value pair MUST be the source URI for the data corresponding to this MLE.

The value of the `content_type` name/value pair MUST be the MIME type of the data corresponding to this MLE.

The value of the `edit_media` name/value pair MUST be the edit URI for the data corresponding to this MLE.

The value of the `media_etag` name/value pair MUST be the concurrency token for the data corresponding to this MLE.

## 4.2 Representing a Property ##

### 4.2.1 Representing a PrimitiveProperty ###

### 4.2.2 Representing a ComplexProperty ###

### 4.2.3 Representing a NavigationProperty ###

*** Work in Progress ***

The rest of this section is random stuff copied in from elsewhere in the original document.




Each NavigationProperty is serialized as name/value pairs in which the value is a JSON object that contains a single name/value pair, with the name equal to the name of the NavigationProperty and a value equal to the URI that can be used to manage the relationship between the related entities.



## 4.3 Representing Multiple Entities ##

## Primitive Values ##

- All of the types, by category (numeric, string, spatial, temporal, special)
- Specific statement of representation in payload.

## Complex Types ##

### Properties ###

### Metadata ###

# Request Specifics #

- All the stuff that only applies to request payloads.

## HTTP Headers ##

- proper accept header to request this format.
- other stuff?

# Response Specifics #

- All the stuff that only applies to response payloads.

## Errors ##

## HTTP Headers ##

- proper content type for this format.
- other stuff?

## Next Links ##

## Response-Level Properties ##

- Inline count
- Others?
