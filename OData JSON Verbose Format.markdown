# OData Verbose JSON Format #

# Overview #

The OData protocol is comprised of a set of specifications for representing and interacting with structured content. The core specification for the protocol is in <ref>core</ref>; this document is an extension of the core protocol. This document defines representations for the OData requests and responses using a verbose JSON format.

An OData JSON payload may represent:

* a single primitive value
* a sequence of primitive values
* a single complex type
* a sequence of complex types
* a single entity
* a sequence of entities
* a service document describing the entity sets exposed by the service
* an error
* a batch of requests to be executed in a single request
* a set of responses returned from a batch request

Most payloads are represented identically in requests and responses. There are some differences. This document first defines the common formats, then discusses details that are specific to request or response.

# 2. Notational Conventions #

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [[RFC2119](http://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")].

## 2.1 Normative References ##

- Normative reference to the OData core document
- Normative reference to the ABNF for OData
- Normative reference to the JSON specification

## 2.2 Informational Examples ##

This document contains many example JSON payloads or partial JSON payloads. These examples are informative only. The text shall be taken as the normative specification.

# 3 Requesting Verbose JSON Format #

Verbose JSON is not the default OData format. To receive responses in Verbose JSON, the client MUST explicitly ask for them.

To request this format using <ref>$format</ref>, use the value `jsonverbose`. To request this format using the <ref>Accept header</ref>, use the MIME type `application/json;odata=verbose`.

## 3.1 Client/Service Format Compatibility and Versions ##

Prior to version 3.0, Verbose JSON format was simply the only OData JSON format. In version 3.0 and later, <ref>JSON</ref> is the default JSON format.

A request with Accept header `application/json` or with a $format value of `json` MUST be treated as a request for the service's default JSON format.

Therefore, such a request on a version 1.0 or 2.0 service, or if specified with a <ref>MaxDataServiceVersion header</ref> of 1.0 or 2.0 will result in Verbose JSON. However, a request for default JSON on a version 3.0 or higher service with a MaxDataServiceVersion of 3.0 or higher will result in <ref>JSON</ref>

Clients and services SHOULD prefer the new <ref>JSON</ref> format as long as they both support it. To maximize compatibility, clients MAY use one of the following sets of headers.

If the client does not understand OData version 3.0:

	MaxDataServiceVersion: 2.0
	Accept: application/json

If the client understands OData version 3.0 but does not support JSON:

	MaxDataServiceVersion: 3.0
	Accept: application/json;odata=verbose

If the client fully supports OData version 3.0:

	MaxDataServiceVersion: 3.0
	Accept: application/json;odata=light;q=1,application/json;odata=verbose;q=0.5

Optionally, Atom can be added as a further fallback in case the service supports neither JSON format.

# 4 Common Payload Format #

This section describes the representation for OData values in Verbose JSON. A request or response body consists of several parts. It contains OData values as part of a larger document. See <ref>Request Formats</ref> and <ref>Response Formats</ref> for the specification of request and response bodies.

## 4.1 Representing an Entity ##

An instance of an entity type MUST be serialized as a JSON object.

Each Property to be transmitted MUST be represented as a name/value pair within the object. See [Representing a Property](#representingaproperty) for details. The order Properties appear within the object MUST be considered insignificant. Name/value pairs not representing a property defined on the entity type SHOULD NOT be included.

An entity in a payload MAY be a complete entity, a projected entity (see <ref>`$select`</ref>), or a partial entity update (see <ref>Patch</ref>). A complete entity MUST transmit every property, including navigation properties. A projected entity MUST transmit the requested properties and MAY transmit other properties. A partial entity MUST transmit the properties that it intends to change; it MUST NOT transmit any other properties.

The name in a property's name/value MUST NOT be `__metadata`. There is no JSON Verbose representation for a property named `__metadata`.

An entity JSON object MAY include a name/value pair named `__metadata`. This name/value pair does not represent a property. It specifies the metadata for the entity. The ordering of this name/value pair with respect to name/value pairs that represent properties MUST be considered insignificant.

### 4.1.1 Entity Metadata ###

The value of the `__metadata` property MUST be a JSON object.

In OData 1.0 and OData 2.0, the value of the `__metadata` property contains up to seven name/value pairs: `uri`, `type`, `etag`, `edit_media`, `media_src`, `media_etag`, and `content_type`. In OData 3.0, four more name/value pairs are added: `properties`, `actions`, `functions`, and `id`. The order of these name/value pairs MUST be considered insignificant.

If the entity is not a Media Link Entry, then the `edit_media`, `media_src`, `media_etag`, and `content_type` name/value pairs MUST NOT be included.

The value of the `uri` name/value pair MUST be present and MUST be the canonical URI identifying the entity.

The `type` name/value pair MUST be included if the entity's type is part of an inheritance hierarchy, as described in <ref>CSDL</ref>. If the entity type is not part of an inheritance hierarchy, then the `type` name/value pair MAY be included. The value of the `type` name/value pair MUST be the namespace qualified name of the entity's type.

The `etag` name/value pair MAY be included. When included, it MUST represent the concurrency token associated with the entity <ref>ETag</ref>. When present, this value MUST be used instead of the <ref>ETag HTTP header</ref>.

The `id` name/value pair MAY be included if the service is using OData 2.0 and MUST be included if the service is using OData 3.0.

The value of the `properties` name/value pair MUST be a JSON object. It SHOULD contain a name/value pair for each navigation property. See [Representing Navigation Property Metadata](#representingnavigationpropertymetadata) for details.

The `actions` name/value pair MAY be included in a response if the service is advertising actions. See [Entity Metadata for Actions](#entitymetadataforactions) for details.

The `functions` name/value pair MAY be included in a response if the service is advertising functions. See [Entity Metadata for Functions](#entitymetadataforfunctions) for details.

The `actions` and `functions` name/value pairs MAY be included in request payloads. In requests they are without meaning and MUST be ignored by the service.

#### 4.1.1.1 Entity Metadata for Media Link Entries ####

If the entity is a media link entity, the `media_src` name/value pair MUST be included and the `edit_media`, `content_type`, and `media_etag` name/value pairs MAY be included.

The value of the `media_src` name/value pair MUST be the source URI for the data corresponding to this MLE.

The value of the `content_type` name/value pair SHOULD be the MIME type of the data corresponding to this MLE. This is only a hint. The actual content type will be included in a header when the resource is requested.

The value of the `edit_media` name/value pair MUST be the edit URI for the data corresponding to this MLE.

The value of the `media_etag` name/value pair MUST be the concurrency token for the data corresponding to this MLE.

#### 4.1.1.2 Entity Metadata for Actions ####

Starting in the OData 3.0 protocol, the `actions` name/value pair MAY be included in `__metadata`. The value is a JSON object that contains action advertisement name/value pairs. See [Advertisement for a Function or Action](#advertisementforafunctionoraction) for details.

#### 4.1.1.3 Entity Metadata for Functions ####

Starting in the OData 3.0 protocol, the `functions` name/value pair MAY be included in `__metadata`. The value is a JSON object that contains function advertisement name/value pairs. See [Advertisement for a Function or Action](#advertisementforafunctionoraction) for details.

The name MUST only identify functions that are bindable to the current entity type. If overloads exist that cannot be bound to the current entity type, the name SHOULD address a specific function overload.

If all function overloads can be bound to the current entity type, the service SHOULD advertise a single function Metadata URL that identifies all of the overloads.

## 4.2 Representing a Navigation Property

A navigation property represents a reference from a source entity to zero or more other entities.

There are two representations for a navigation property: deferred and expanded. The deferred representation represents each related entity with a URI. The expanded representation represents each related entity with its expanded contents.

By default, a service SHOULD represent each navigation property in the deferred format. This conserves resources.

A client MAY request that a navigation property be expanded, using a combination of $expand and $select. The service MUST represent each navigation property so requested in the expanded format.

### 4.2.1 Example Deferred Navigation Property

	{
		"CustomerID": "ALFKI",
		"Orders":  {
			"__deferred": {
				"uri": "Customers(\'ALFKI\')/Orders" 
			}
		},
		"__metadata": {
			"properties" : {
				"Orders" : {
					"associationuri" : "Customers(\'ALFKI\')/$links/Orders"
				}
			}
		}
	}

### 4.2.2 Example Expanded Navigation Property

	{
		"CustomerID": "ALFKI",
		"Orders": {
			"results": [
				{
					"__metadata": { ... },
					"OrderID": 1,
					...
				},
				{ ... }
			],
		},
		"__metadata": {
			"properties" : {
				"Orders" : {
					"associationuri" : "Customers(\'ALFKI\')/$links/Orders"
				}
			}
		}
	}

### 4.2.3 Representing a Deferred Navigation Property

A deferred navigation property is represented as a name/value pair. The name MUST be the name of the property. The value must be a JSON object.

The value must contain a single name/value pair. This name MUST be `__deferred`. The inner value MUST be another JSON object.

The inner JSON Object must contain a single name/value pair. The name must be `uri`. The value must be the URI for the navigation property (this is not the NavigationLink URI).

See [Example Deferred Navigation Property](#exampledeferrednavigationproperty) for an example.

### 4.2.4 Representing an Expanded Navigation Property

An expanded navigation property is represented as a name/value pair. The name MUST be the name of the property.

The value MUST be the correct representation of the related entity or entity set. See [Representing an Entity](#representinganentity), [Representing Multiple Entities in a Response](#representingmultipleentitiesinaresponse), or  [Representing Multiple Entities in a Request](#representingmultipleentitiesinarequest) for details.

See [Example Expanded Navigation Property](#exampleexpandednavigationproperty) for an example.

## 4.3 Representing Navigation Property Metadata ##

Metadata for a navigation property is represented as a name/value pair.

The name MUST be the property's name.

The value MUST be a JSON object containing a single name/value pair. The name must be `associationuri`. The value must be a string containing the NavigationLink URI for that property.

See [Example Deferred Navigation Property](#exampledeferrednavigationproperty) for an example.

## 4.4 Representing a Named Resource Stream Value

The value of a named resource stream property is represented like in the following example.

	{
		"__mediaresource": {
			"edit_media": "http://server/uploads/Thumbnail546.jpg",
			"media_src": "http://server/Thumbnail546.jpeg",
			"content-type": "img/jpeg",
			"media_etag": "####"
		}
	}

This would typically show up in the definition of an entity, as in the following example:

	{
		"__metadata": {...},
		"ID": 3,
		"Thumbnail": {
			"__mediaresource": {...}
		},
		"PrintReady": {
			"__mediaresource": {...}
		},
	}

The named stream value MUST be represented as a JSON object. That object MUST contain a single name/value pair. The name MUST be `__mediaresource`. The value MUST be a JSON object.

The JSON object contains up to 4 name/value pairs. Each pair is described below.

The `media_src` name/value pair MUST be included. The value of the name/value pair MUST be a URI that can be used to retrieve the stream of bytes with a GET request.

The `content_type` name/value pair MUST be included. If the `edit_media` name/value pair is present the value of the `content_type` name/value pair MUST specify the content type of the binary stream represented by the `edit_media` URI. The value of the `content_type` name/value pair MAY match the content type of the binary stream represented by the `media_src` URI.

The `edit_media` name/value pair MAY be included. This name/value pair MUST be supplied if the named resource stream instance can be updated. The value of the `edit_media` name/value pair MUST be a URI that can be used to replace the existing stream with a HTTP PUT request.

The `media_etag` name/value pair MAY be included. When included, the value MUST be the value of the ETag for the named resource stream last PUT to the `edit_media URI.

## 4.4 Representing a Primitive Value ##

The representation for primitives in JSON Verbose is specified in <ref>the ABNF</ref>.

## 4.5 Representing a Complex Type Value ##

In the following example, Address is a property with a complex type value.

	{
		"CustomerID": "ALFKI",
		"Address": { "Street": "57 Contoso St", "City": "Seattle" }
	}

A complex type value MUST be represented as a single JSON object. It MUST have one name/value pair for each Property that makes up the complex type. Each property MUST be formatted as appropriate for the property. See [Representing a Property](representingaproperty) for details.

The object representing a complex type value SHOULD NOT contain any other name/value pairs.

## 4.6 Representing a Set of Links ##

A set of links expresses a relation from one entity to zero or more related entities.

The following example shows a set of links represented as appropriate for a request.

	[
		{"uri": "http://host/service.svc/Orders(1)"},
		{"uri": "http://host/service.svc/Orders(2)"}
	]

A set of links MUST be represented as a single JSON array. This array MUST contain one item per link.

Each link item MUST be represented as a single JSON object. This object MUST contain a single name/value pair. The name MUST be `uri`. The value MUST be a URI for the related entity.

There are additional considerations for representing a set of links in a response. See [Representing a Set of Links in a Response](#representingasetoflinksinaresponse) for details.

## 4.7 Representing Annotations ##

Annotations MAY be applied to any name/value pair in a JSON payload that represents a value of any type from the EDM.

The following example shows annotations applied to many different constructs.

	{
		"@results": {
			"com.constoso.customer.setkind" : "VIPs"
		},
		"results" : [
			{
				"__metadata": { ... },
				"com.constoso.customer.kind" : "VIP",
				"com.constoso.display.order" : 1,
				"CustomerID": "ALFKI",
				"@CompanyName" : { 
					"com.contoso.display" : { "title" : true, "order" : 1 }
				}
				"CompanyName": "Alfreds Futterkiste",
				"Orders": { 
					"com.contoso.purchaseorder.priority" : 1,
					"__deferred": { "uri": "Customers('ALFKI')/Orders" }   
				}
			}
		]
	}

In general, it is possible to express an annotation internally or externally to a value. However, an annotation is always a name/value pair. Therefore, it can only be expressed within a JSON object. Some EDM constructs are not represented with JSON objects. Therefore some types may only be annotated externally.

See the specific subsections of this section for normative rules abuot how to represent annotations on various types.

### 4.7.1 Annotate a Value Represented as a JSON Object ###

This section applies when annotating a name/value pair for which the value is represented as a JSON object.

Each annotation MUST be applied internally. Each annotation MUST be represented as a single name/value pair.

The name MUST be the fully-scoped name of the annotation. This name MUST include namespace and name, separated by a period (`.`).

The value MUST be the appropriate value for the annotation.

### 4.7.2 Annotate a Value Represented as a JSON Array or Primitive ###

This section applies when annotating a name/value pair for which the value is not represented as a JSON object.

The set of all annotations that apply to this name/value pair MUST be applied externally. This set of annotations is represented as a single name/value pair.

The name MUST be the same as the name of the name/value pair being annotated, prefixed with the at sign (`@`).

The value MUST be a JSON object. Each annotation in the set MUST be represented as a single name/value pair within this object.

The name MUST be the fully-scoped name of the annotation. This name MUST include namespace and name, separated by a period (`.`).

The value MUST be the appropriate value for the annotation.

## 4.8 Advertisement for a Function or Action ##

A function or action is advertised via a name/value pair. The name MUST be a Metadata URL. The value MUST be an array of JSON objects.

Any number of JSON objects is allowed in this array. Each object in this array MUST have at least two name/value pairs: `title` and `target`. The order of these name/value pairs MUST be considered insignificant.

The `target` name/value pair MUST contain a bound action target URL.

The `title` name/value pair MUST contain the action title as a string.

# 5 Request Specifics #

This section describes additional payload semantics that only apply to request payloads.

## 5.1 Representing a Property in a Request

A Property is represented as a name/value pair. The name is the Property's name.

The value for a primitive, complex type, collection, or named stream property is the property's value. It MUST be formatted appropriately for its type.

A property's representation is always contained within a JSON object. If the request does not already contain a wrapping JSON object, then one is wrapped around the described name/value pair.

## 5.2 Representing Multiple Entities in a Request ##

A collection of entities MUST be represented as a JSON array. Each element MUST be a correctly formatted entity (see [Representing an Entity](#representinganentity)).

An empty entity set or collection of entities (one that contains no entity type instances) MUST be represented as an empty JSON array.

## 5.3 Representing a Collection of Complex Type or Primitive Values in a Request ##

A collection of complex type or primitive values MUST be represented as a JSON array. Each element in the array MUST be the representation for a value. See [Representing a Primitive Value](#representingaprimitivevalue) or [Representing a Complex Type Value](#representingacomplextypevalue) for details.

# 6 Response Specifics #

This section describes additional payload semantics that only apply to response payloads.

## 6.1 Response body ##

All JSON Verbose responses are wrapped in a single object for security reasons.

Each response body MUST be represented as a single JSON object. This object contains a single name/value pair. The name MUST be `d`. The value MUST be the correct representation for the data being returned.

## 6.2 MIME Type ##

Verbose JSON is represented with a Content-Type of "application/json;odata=verbose".

In OData 1.0 and 2.0, it was also represented with a Content-Type of "applicaton/json". However, in OData 3.0, "application/json" has been redefined to mean <ref>JSON</ref>.

## 6.3 Representing a Property in a Response

In OData 1.0, a property in a response is formatted just like in a request. See [Representing a Property in a Request](#representingapropertyinarequest) for details.

Additionally, any property that is being represented as part of a larger item is represented as in a request.

The rest of this section applies only to representing a top-level property in OData 2.0 and 3.0.

A property is represented as in the following example.

	{
		"results": {
			"CustomerName": "the value of the property"
		}
	}

A property is represented as a JSON object with a single name/value pair. The name is `results`. The value is a JSON object.

The object contains the representation that would be used for this property in a request. See [Representing a Property in a Request](#representingapropertyinarequest) for details.

## 6.3 Representing Multiple Entities in a Response ##

In OData 1.0, a collection of entities in a response is formatted just like in a request. See [Representing Multiple Entities in a Request](#representingmultipleentitiesinarequest) for details.

The rest of this section applies to OData 2.0 and 3.0 only.

A collection of entities is represented as in the following example.

	{
		"__metadata": { ... },
		"__count": 37,
		"results": [
			{ ... },
			{ ... },
			{ ... }
		],
		"__next": "/next?$skiptoken=342r89",
	}

A collection of entities MUST be represented as a JSON object. This object MUST contain a `results` name/value pair. It MAY contain `__count`, `__next`, or `__metadata` name/value pairs.

The `results` value MUST be a JSON array. Each element MUST be a correctly formatted entity (see [Representing an Entity](#representinganentity)).

The `__count` name/value pair represents the inlinecount. Its value MUST be an integer corresponding to the total count of members in the collection represented by the request. If present, this name/value pair MUST come before the `results` name/value pair. See <ref>`$inlinecount`</ref> for details on when it is required and when it is prohibited. 

The `__next` name/value pair MAY be included. If provided, its value MUST be a string containing a URL. If provided, then the response MUST be interpreted as a partial result. The client MAY request this URL if it wishes to receive the next part of the collection or entity set.

The `__metadata` name/value pair MAY be included. If provided, its value MUST be a JSON object. This object represents the metadata for the set of entities.

An empty collection of entities (one that contains no entity type instances) MUST be represented as a JSON object with a `results` name/value pair. The `results` name/value pair MUST be an empty JSON array.

## 6.3.1 Representing Actions Bound to Multiple Entities ##

In the ODATA 3.0 protocol, it is possible to advertise actions that are bound to the definition of a set of entities.

Actions are advertised in the metadata for a set of entities. The metadata object MAY contain an `actions` name/value pair. The value is a JSON object that contains action advertisement name/value pairs. See [Advertisement for a Function or Action](#advertisementforafunctionoraction) for details.

## 6.3.2 Representing Functions Bound to Multiple Entities ##

In the ODATA 3.0 protocol, it is possible to advertise functions that are bound to the definition of a set of entities.

Functions are advertised in the metadata for a set of entities. The metadata object MAY contain a `functions` name/value pair. The value is a JSON object that contains function advertisement name/value pairs. See [Advertisement for a Function or Action](#advertisementforafunctionoraction) for details.

The function metadata URL MUST identify only functions that are bindable to the current feed definition. If overloads exist that cannot be bound to the current feed definition, the name SHOULD address a specific function overload.

If all function overloads can be bound to the current feed definition, the service SHOULD advertise a single function metadata URL that identifies all of the overloads.

## 6.4 Representing a Set of Links in a Response ##

In OData 1.0 responses, a set of Links is represented exactly as described in [Representing a Set of Links](#representingasetoflinks).

In OData 2.0 and 3.0 responses, a set of Links is represented as shown in the following example.

	{
		"results": [
			{"uri": "http://host/service.svc/Orders(1)"},
			{"uri": "http://host/service.svc/Orders(2)"}
		]
	}

A set of Links MUST be formatted as a single JSON object. This object MUST contain a name/value pair. The name MUST be `results`. The value MUST be the JSON array used to represent that set of Links in a request. See [Representing a Set of Links](#representingasetoflinks) for details.

The outer JSON object MAY contain additional name/value pairs. One such example is the [Inline Count](#inlinecount).

## 6.5 Representing a Collection of Complex Type or Primitive Values in a Response ##

In OData 1.0, collection of complex type or primitive values in a response is formatted just like in a request. See [Representing a Collection of Complex Type or Primitive Values in a Response](#representingacollectionofcomplextypeorprimitivevaluesinaresponse) for details.

The rest of this section applies to OData 2.0 and 3.0 only.

An collection of complex type or primitive values MUST be represented as a JSON object. This object MUST contain a `results` name/value pair. It MAY contain a `__metadata` name/value pair.

The `results` value MUST be a JSON array. Each element MUST be a correctly formatted value (see [Representing a Complex Type Value](#representingacomplextypevalue) or [Representing a Primitive Value](#representingaprimitivevalue)).

The `__metadata` name/value pair MAY be included. If provided, its value MUST be a JSON object. This object represents the metadata for the collection of complex type values.

An empty collection (one that contains no instances) MUST be represented as a JSON object with a `results` name/value pair. The `results` name/value pair MUST be an empty JSON array.

## 6.6 Representing Errors in a Response

Top-level errors in JSON Verbose responses MUST be represented as in the following example.

	{
		"error": {
			"code": "A custom error code",
			"message": {
				"lang": "en-us",
				"value": "A custom long message for the user."
			},
			"innererror": {
				"trace": [...],
				"context": {...}
			}
		}
	}

The error response MUST be a single JSON object. This object MUST have a single name/value pair. The name MUST be `error`. The value must be a JSON object.

This object can have 2 or 3 name/value pairs. It MUST contain name/value pairs with the names `code` and `message`. In debug environments, it MAY contain a name/value pair with the name `innererror`. A production service MUST NOT ever respond with an error that includes an `innererror` name/value pair.

The value for the `code` name/value pair MUST be a string. Its value MUST be a service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.

The value for the `message` name/value pair MUST be an object. This object MUST have two name/value pairs, with names `lang` and `message`. The `message` name/value pair MUST contain a human-readable representation of the error. The `lang` name/value pair MUST contain the language code from <ref>[[RFC 4646]][]</ref> corresponding to the language in which the value for `message` is written.

The value for the `innererror` name/value pair MUST be an object. The contents of this object are service-defined. Usually this object contains information that will help debug the service.

## 6.7 Representing the Service Document ##

The root URL of an OData service MUST identify a service document. This document is represented as show in the following example.

	{
		"EntitySets": [
			"Customers",
			"Orders",
			"OrderDetails"
		]
	}
	
The service document MUST consist of a single JSON object. This object MUST have a single name/value pair. The name MUST be `EntitySets`. The value MUST be a JSON Array.

There MUST be one element in this array for each entity set exposed by the service. Each element MUST be a JSON string with a value equal to the name of the entity set.
