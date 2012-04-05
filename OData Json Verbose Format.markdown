# OData Verbose JSON Format #

# Overview #

The OData protocol is comprised of a set of specifications for representing and interacting with structured content. The core specification for the protocol is in <ref>core</ref>; this document is an extension of the core protocol. This document defines representations for the OData requests and responses using a verbose JSON format.

An OData JSON payload may represent:

* a single Primitive value
* a sequence of Primitive values
* a single ComplexType
* a sequence of ComplexTypes
* a single Entity
* a sequence of Entities
* a service document describing the EntitySets exposed by the service
* an error
* a batch of requests to be executed in a single request
* a set of responses returned from a batch request

Most payloads are represented identically in requests and responses. There are some differences. This document first defines the common formats, then discusses details that are specific to request or response.

# 2. Notational Conventions #

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [[RFC2119](http://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")].

## 2.1 Normative References ##

-- TODO: fixx in the normative refs.

- Normative reference to the OData core document
- Normative reference to the ABNF for OData

## 2.2 Informational Examples ##

This document contains many example JSON payloads or partial JSON payloads. These examples are informative only. The text shall be taken as the normative specification.

# 3 Requesting Verbose JSON Format #

Verbose JSON is not the default OData format. To receive responses in Verbose JSON, the client MUST explicitly ask for them.

To request this format using <ref>$format</ref>, use the value `jsonverbose`. To request this format using the <ref>Accept header</ref>, use the MIME type `application/json;odata=verbose`.

## 3.1 Client/Server Format Compatibility and Versions ##

Prior to version 3.0, Verbose JSON format was simply the only OData JSON format. In version 3.0 and later, <ref>JSON Light</ref> is the default JSON format.

A request with Accept header `application/json` or with a $format value of `json` MUST be treated as a request for the server's default JSON format.

Therefore, such a request on a version 1.0 or 2.0 server, or if specified with a <ref>MaxDataServiceVersion header</ref> of 1.0 or 2.0 will result in Verbose JSON. However, a request for default JSON on a version 3.0 or higher server with a MaxDataServiceVersion of 3.0 or higher will result in <ref>JSON Light</ref>

Clients and servers SHOULD prefer the new <ref>JSON Light</ref> format as long as they both support it. To maximize compatibility, clients MAY use one of the following sets of headers.

If the client does not understand OData version 3.0:

	MaxDataServiceVersion: 2.0
	Accept: application/json

If the client understands OData version 3.0 but does not support JSON Light:

	MaxDataServiceVersion: 3.0
	Accept: application/json;odata=verbose

If the client fully supports OData version 3.0:

	MaxDataServiceVersion: 3.0
	Accept: application/json;odata=light;q=1,application/json;odata=verbose;q=0.5

Optionally, Atom can be added as a further fallback in case the server supports neither JSON format.

# 4 Common Payload Format #

This section describes the representation for OData values in Verbose JSON. A request or response body consists of several parts. It contains OData values as part of a larger document. See <ref>Request Formats</ref> and <ref>Response Formats</ref> for the specification of request and response bodies.

## 4.1 Representing an Entity ##

An instance of an EntityType MUST be serialized as a JSON object.

Each Property to be transmitted MUST be represented as a name/value pair within the object. See [Representing a Property](#representingaproperty) for details. The order Properties appear within the object MUST be considered insignificant. Name/value pairs not representing a property defined on the EntityType SHOULD NOT be included.

An Entity in a payload MAY be a complete Entity, a projected Entity (see <ref>`$select`</ref>), or a partial Entity update (see <ref>Patch</ref>). A complete Entity MUST transmit every property, including NavigationProperties. A projected Entity MUST transmit the requested properties and MAY transmit other properties. A partial Entity MUST transmit the properties that it intends to change; it MUST NOT transmit any other properties.

The name in a property's name/value MUST NOT be `__metadata`. There is no JSON Verbose representation for a property named `__metadata`.

An Entity JSON object MAY include a name/value pair named `__metadata`. This name/value pair does not represent a property. It specifies the metadata for the Entity. The ordering of this name/value pair with respect to name/value pairs that represent properties MUST be considered insignificant.

### 4.1.1 Entity Metadata ###

The value of the `__metadata` property MUST be a JSON object.

In OData 1.0 and OData 2.0, the value of the `__metadata` property contains up to seven name/value pairs: `uri`, `type`, `etag`, `edit_media`, `media_src`, `media_etag`, and `content_type`. In OData 3.0, four more name/value pairs are added: `properties`, `actions`, `functions`, and `id`. The order of these name/value pairs MUST be considered insignificant.

If the entity is not a Media Link Entry, then the `edit_media`, `media_src`, `media_etag`, and `content_type` name/value pairs MUST NOT be included.

The value of the `uri` name/value pair MUST be present and MUST be the canonical URI identifying the entity.

The `type` name/value pair MUST be included if the Entity's EntityType is part of an inheritance hierarchy, as described in <ref>CSDL</ref>. If the EntityType is not part of an inheritance hierarchy, then the `type` name/value pair MAY be included. The value of the `type` name/value pair MUST be the namespace qualified name of the Entity's EntityType.

The `etag` name/value pair MAY be included. When included, it MUST represent the concurrency token associated with the Entity <ref>ETag</ref>. When present, this value MUST be used instead of the <ref>ETag HTTP header</ref>.

The `id` name/value pair MAY be included if the server is using OData 2.0 and MUST be included if the server is using OData 3.0.

The value of the `properties` name/value pair MUST be a JSON object. It SHOULD contain a name/value pair for each NavigationProperty. See [Representing NavigationProperty Metadata](#representingnavigationpropertymetadata) for details.

The `actions` name/value pair MAY be included in a response if the server is advertising actions. See [Entity Metadata for Actions](#entitymetadataforactions) for details.

The `functions` name/value pair MAY be included in a response if the server is advertising functions. See [Entity Metadata for Functions](#entitymetadataforfunctions) for details.

The `actions` and `functions` name/value pairs MAY be included in request payloads. In requests they are without meaning and MUST be ignored by the server.

#### 4.1.1.1 Entity Metadata for Media Link Entries ####

If the entity is a media link entity, the `media_src` name/value pair MUST be included and the `edit_media`, `content_type`, and `media_etag` name/value pairs MAY be included.

The value of the `media_src` name/value pair MUST be the source URI for the data corresponding to this MLE.

The value of the `content_type` name/value pair SHOULD be the MIME type of the data corresponding to this MLE. This is only a hint. The actual content type will be included in a header when the resource is requested.

The value of the `edit_media` name/value pair MUST be the edit URI for the data corresponding to this MLE.

The value of the `media_etag` name/value pair MUST be the concurrency token for the data corresponding to this MLE.

#### 4.1.1.2 Entity Metadata for Actions ####

Starting in the OData 3.0 protocol, the `actions` name/value pair MAY be included in `__metadata`. The value is a JSON object that contains Action advertisement name/value pairs. See [Advertisement for a Function or Action](#advertisementforafunctionoraction) for details.

#### 4.1.1.3 Entity Metadata for Functions ####

Starting in the OData 3.0 protocol, the `functions` name/value pair MAY be included in `__metadata`. The value is a JSON object that contains Function advertisement name/value pairs. See [Advertisement for a Function or Action](#advertisementforafunctionoraction) for details.

The name MUST only identify functions that are bindable to the current EntityType. If overloads exist that cannot be bound to the current EntityType, 

-- TODO:

**Don't know what to do here. The OIPI had a bug; Alex will answer and then I'll fix it**.

If all Function overloads can be bound to the current EntityType, the server SHOULD advertise a single Function Metadata URL that identifies all of the overloads.

## 4.2 Representing a Property ##

A Property is represented as a name/value pair. The name is the Property's name.

The value for a PrimitiveProperty, a ComplexTypeProperty, or a CollectionProperty is the Property's value. It MUST be formatted appropriately for its type.

-- TODO: verify. Is this correct for collection types? Does a collection value contain the same object & metadata?

### 4.2.1 Representing a NamedResourceStreamProperty ###

-- TODO: write this.

### 4.2.2 Representing a NavigationProperty ###

A NavigationProperty represents a reference from a source Entity to zero or more other Entities.

There are two representations for a NavigationProperty: deferred and expanded. The deferred representation represents each related entity with a URI. The expanded representation represents each related entity with its expanded contents.

By default, a server SHOULD represent each NavigationProperty in the deferred format. This conserves resources.

A client MAY request that a NavigationProperty be expanded, using a combination of $expand and $select. The server MUST represent each NavigationProperty so requested in the expanded format.

#### 4.2.2.1 Example Deferred NavigationProperty ####

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

#### 4.2.2.2 Example Expanded NavigationProperty ####

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

#### 4.2.2.3 Representing a Deferred NavigationProperty ####

A deferred NavigationProperty is represented as a name/value pair. The name MUST be the name of the property. The value must be a JSON object.

The value must contain a single name/value pair. This name MUST be `__deferred`. The inner value MUST be another JSON object.

The inner JSON Object must contain a single name/value pair. The name must be `uri`. The value must be the URI for the NavigationProperty (this is not the NavigationLink URI).

See [Example Deferred NavigationProperty](#exampledeferrednavigationproperty) for an example.

#### 4.2.2.4 Representing an Expanded NavigationProperty ####

An expanded NavigationProperty is represented as a name/value pair. The name MUST be the name of the property.

The value MUST be the correct representation of the related Entity or EntitySet. See [Representing an Entity](#representinganentity), [Representing Multiple Entities in a Response](#representingmultipleentitiesinaresponse), or  [Representing Multiple Entities in a Request](#representingmultipleentitiesinarequest) for details.

See [Example Expanded NavigationProperty](#exampleexpandednavigationproperty) for an example.

## 4.3 Representing NavigationProperty Metadata ##

Metadata for a NavigationProperty is represented as a name/value pair.

The name MUST be the Property's name.

The value MUST be a JSON object containing a single name/value pair. The name must be `associationuri`. The value must be a string containing the NavigationLink URI for that property.

See [Example Deferred NavigationProperty](#exampledeferrednavigationproperty) for an example.

## 4.4 Representing a Primitive Value ##

The representation for primitives in JSON Verbose is specified in <ref>the ABNF</ref>.

## 4.5 Representing a ComplexType Value ##

In the following example, Address is a Property with a ComplexType value.

	{
		"CustomerID": "ALFKI",
		"Address": { "Street": "57 Contoso St", "City": "Seattle" }
	}

A ComplexType value MUST be represented as a single JSON object. It MUST have one name/value pair for each Property that makes up the complex type. Each Property MUST be formatted as appropriate for the property. See [Representing a Property](representingaproperty) for details.

The object representing a ComplexType value SHOULD NOT contain any other name/value pairs.

## 4.6 Representing a Collection of ComplexType Values ##

A Collection of ComplexType values MUST be represented as a JSON array. Each element in the array MUST be the representation for a ComplexType value. See [Representing a ComplexType Value](#representingacomplextypevalue) for details.

## 4.7 Representing a Set of Links ##

A set of links expresses a relation from one Entity to zero or more related Entities.

The following example shows a set of links represented as appropriate for a request.

	[
		{"uri": "http://host/service.svc/Orders(1)"},
		{"uri": "http://host/service.svc/Orders(2)"}
	]

A set of links MUST be represented as a single JSON array. This array MUST contain one item per link.

Each link item MUST be represented as a single JSON object. This object MUST contain a single name/value pair. The name MUST be `uri`. The value MUST be a URI for the related Entity.

There are additional considerations for representing a set of links in a response. See [Representing a Set of Links in a Response](#representingasetoflinksinaresponse) for details.

## 4.8 Representing Annotations ##

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

### 4.8.1 Annotate a Value Represented as a JSON Object ###

This section applies when annotating a name/value pair for which the value is represented as a JSON object.

Each annotation MUST be applied internally. Each annotation MUST be represented as a single name/value pair.

The name MUST be the fully-scoped name of the annotation. This name MUST include namespace and name, separated by a period (`.`).

The value MUST be the appropriate value for the annotation.

### 4.8.2 Annotate a Value Represented as a JSON Array or Primitive ###

This section applies when annotating a name/value pair for which the value is not represented as a JSON object.

The set of all annotations that apply to this name/value pair MUST be applied externally. This set of annotations is represented as a single name/value pair.

The name MUST be the same as the name of the name/value pair being annotated, prefixed with the at sign (`@`).

The value MUST be a JSON object. Each annotation in the set MUST be represented as a single name/value pair within this object.

The name MUST be the fully-scoped name of the annotation. This name MUST include namespace and name, separated by a period (`.`).

The value MUST be the appropriate value for the annotation.

## 4.9 Advertisement for a Function or Action ##

A Function or Action is advertised via a name/value pair. The name MUST be a Metadata URL. The value MUST be an array of JSON objects.

Any number of JSON objects is allowed in this array. Each object in this array MUST have at least two name/value pairs: `title` and `target`. The order of these name/value pairs MUST be considered insignificant.

The `target` name/value pair MUST contain a bound Action Target URL.

The `title` name/value pair MUST contain the Action Title as a string.

# 5 Request Specifics #

This section describes additional payload semantics that only apply to request payloads.

## 5.1 Representing Multiple Entities in a Request ##

An EntitySet or collection of entities MUST be represented as a JSON array. Each element MUST be a correctly formatted Entity (see [Representing an Entity](#representinganentity)).

An empty EntitySet or collection of entities (one that contains no EntityType instances) MUST be represented as an empty JSON array.

# 6 Response Specifics #

This section describes additional payload semantics that only apply to response payloads.

## 6.1 Response body ##





-- TODO: write this. Talk about the d object, etc.






## 6.2 MIME Type ##

Verbose JSON is represented with a Content-Type of "application/json;odata=verbose".

In OData 1.0 and 2.0, it was also represented with a Content-Type of "applicaton/json". However, in OData 3.0, "application/json" has been redefined to mean <ref>JSON Light</ref>.

## 6.3 Representing Multiple Entities in a Response ##

In OData 1.0, an EntitySet of collection of Entities in a response is formatted just like in a request. See [Representing Multiple Entities in a Request](#representingmultipleentitiesinarequest) for details.

The rest of this section applies to OData 2.0 and 3.0 only.

An EntitySet or collection of Entities MUST be represented as a JSON object. This object MUST contain a `results` name/value pair. It MAY contain `__count`, `__next`, or `__metadata` name/value pairs.

The `results` value MUST be a JSON array. Each element MUST be a correctly formatted Entity (see [Representing an Entity](#representinganentity)).

The `__count` name/value pair represents the inlinecount. Its value MUST be an integer. See <ref>inlinecount</ref> for details on when it is required and when it is prohibited.

The `__next` name/value pair MAY be included. If provided, its value MUST be a string containing a URL. If provided, then the response MUST be interpreted as a partial result. The client MAY request this URL if it wishes to receive the next part of the collection or EntitySet.

The `__metadata` name/value pair MAY be included. If provided, its value MUST be a JSON object. This object represents the metadata for the set of Entities.

An empty EntitySet or collection of entities (one that contains no EntityType instances) MUST be represented as a JSON object with a `results` name/value pair. The `results` name/value pair MUST be an empty JSON array.

## 6.3.1 Representing Actions Bound to Multiple Entities ##

In the ODATA 3.0 protocol, it is possible to advertise Actions that are bound to the definition of a set of Entities.

Actions are advertised in the metadata for a set of Entities. The metadata object MAY contain an `actions` name/value pair. The value is a JSON object that contains Action advertisement name/value pairs. See [Advertisement for a Function or Action](#advertisementforafunctionoraction) for details.

## 6.3.2 Representing Functions Bound to Multiple Entities ##

In the ODATA 3.0 protocol, it is possible to advertise Functions that are bound to the definition of a set of Entities.

Functions are advertised in the metadata for a set of Entities. The metadata object MAY contain a `functions` name/value pair. The value is a JSON object that contains Function advertisement name/value pairs. See [Advertisement for a Function or Action](#advertisementforafunctionoraction) for details.

The function metadata URL MUST identify only functions that are bindable to the current feed definition. If overloads exist that cannot be bound to the current feed definition, 

-- TODO:

**Don't know what to do here. There's a bug in the OIPI. Alex will fix, then I'll incorporate his fix here.**

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

## 6.5 Errors ##

-- TODO: write this.

## 6.6 Next Links ##

-- TODO: write this.

## 6.7 Inline Count ##

-- TODO: write this.

## 6.8 Service Document ##

-- TODO: write this.
