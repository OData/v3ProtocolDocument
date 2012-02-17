# OData Atom Format #

#todo: #
* read through
* instance annotations 
* Relationship links 
* Actions/Functions 
* Extensibility 
* Encoding of primitive types

# 1. Overview #

The OData protocol is comprised of a set of specifications for representing and interacting with structured content.  This document describes the OData Atom Format.

An OData payload may represent:

* a single Primitive value  
* a sequence of Primitive values  
* a single structured value  
* a sequence of structured values  
* a single resource, where a resource represents an Entity (a structured type with an identity)  
* a sequence of resources  
* a media resource  
* a single instance of a mime type  
* a service document describing the resource collections (EntitySets) exposed by the service  
* an xml document describing the entity model exposed by the service  
* an error  
* a batch of requests to be executed in a single request  
* a set of responses returned from a batch request  

For a description of batch requests and responses please see <todo: insert reference here…>


# 2. Notational Conventions #

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [[RFC2119](http://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")].

# 3. OData Namespaces #

Attributes and elements that have special meaning in OData are defined in one of two OData Namespaces.

## 3.1.	OData Data Namespace #

Elements that describe the actual data values for a resource are qualified with the OData Data Namespace: "http://schemas.microsoft.com/ado/2007/08/dataservices"

In this specification the namespace prefix "data" is used to represent the OData Data Namespace, however the prefix name is not prescriptive.

## 3.2.	OData Metadata Namespace ##

Attributes and elements that represent metadata (such as type, null usage, and entry-level etags) are defined within the OData Metadata Namespace: "http://schemas.microsoft.com/ado/2007/08/dataservices/metadata"

In this specification the namespace prefix "metadata" is used to represent the OData Metadata Namespace, however the prefix name is not prescriptive.

# 4. xml:base Attribute #

OData payloads may use the xml:base attribute to define a base URI for relative references defined within the scope of the element containing the xml:base attribute.

# 5. Primitive Types in Atom #

OData supports the following primitive types.

* Edm.Binary 
* Edm.Boolean  
* Edm.Byte  
* Edm.DateTime  
* Edm.Decimal  
* Edm.Double  
* Edm.Single  
* Edm.Guid  
* Edm.Int16  
* Edm.Int32  
* Edm.Int64  
* Edm.SByte
* Edm.Stream   
* Edm.String  
* Edm.Time  
* Edm.DateTimeOffset  
* Edm.Geography 
* Edm.GeographyPoint 
* Edm.GeographyLineString 
* Edm.GeographyPolygon 
* Edm.GeographyCollection 
* Edm.GeographyMultiPoint 
* Edm.GeographyMultiLineString 
* Edm.GeographyMultiPolygon 
* Edm.Geometry 
* Edm.GeometryPoint 
* Edm.GeometryLineString 
* Edm.GeometryPolygon 
* Edm.GeometryCollection 
* Edm.GeometryMultiPoint 
* Edm.GeometryMultiLineString 
* Edm.GeometryMultiPolygon 

todo: define atom encodings for each type

# 6. Use of Atom #

The Atom Syndication Format RFC4287 (http://atompub.org/rfc4287.html) defines an XML-based format for describing streams ("feeds") made up of individual "entries". The Atom Publishing Protocol (http://www.ietf.org/rfc/rfc5023.txt) defines an application-level protocol based on HTTP transfer of Atom-formatted representations.
Atom elements and attributes are defined within the Atom namespace: "http://www.w3.org/2005/Atom".

In this specification the namespace prefix "atom" is used to represent the Atom Namespace, however the prefix name is not prescriptive.

OData's Atom format defines extensions and conventions on top of RFC4287 and RFC5023 for representing structured data. In particular, OData defines meaning to defined Atom elements as follows:

## 6.1.	Entity Instances as atom:entry Elements ##

An atom:entry element is used to represent a single resource, or entity, which is an instance of a structured type with an identity.  Within an atom:entry element, the following attributes and elements are assigned meaning. 

### 6.1.1.	metadata:etag Attribute ###

The etag attribute defined on an atom:entry element represents an opaque string value that can be used in a subsequent request to determine if the value of the resource has changed.  For details on how ETags are used, refer to the <todo:insert reference here> spec.

### 6.1.2.	atom:id Element ###

The atom:id element defines a durable, opaque, globally unique identifier for the entry. Its content must be an IRI as defined in http://www.ietf.org/rfc/rfc3987. The consumer of the feed must not assume this IRI can be de-referenced, nor assume any semantics from its structure.

### 6.1.3.	Self and Edit Links as atom:link Elements ###

Atom defines two types of links within an entry that represent retrieve or update/delete operations on the entry. atom:link elements with a rel attribute of "self" can be used to retrieve the resource, atom:link elements with a rel attribute of "edit" can be used to retrieve, update, or delete the resource.

An OData endpoint SHOULD contain a self link, an edit link, or both for a particular entry, but MUST NOT contain more than one edit link for a given entry.  Absence of an edit link implies that the entry is read-only.

### 6.1.4.	Media and Media-Edit links as atom:link Elements ###

Atom defines links that can be used to retrieve or update a Media Resource associated with an entry. 

An atom:link element within an entry with a rel attribute of "media" is used to identify a URI (via the "href" attribute) that can be used to retrieve a Binary Large OBject ("BLOB") associated with the entry.  

Similarly, an atom:link element with a rel attribute of "media-edit" can be used to write a BLOB associated with the entry. 

### 6.1.5.	Relationships as atom:link Elements ###

OData uses atom:link elements to represent relationships between entities.  

For example, the set of related products for a particular category may be represented through a link element as a child of the category entry element as follows:

`<atom:link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/Products"
	type=application/atom+xml;type=feed" title=Products" href="Categories(0)/Products"/>`

The rel attribute for an atom:link element that represents a relationship is made up of the name of the OData Data Namespace, followed by the string "/related/" followed by the name of the navigation property on the entity.  Note that the full name must be used; the use of relative URLs in the rel attribute is not allowed.

The href attribute of an atom:link element describing an OData relationship contains the URI that can be used to retrieve the related resource(s).  This URI may be relative or absolute.

The type attribute on an atom:link element describing an OData relationship determines whether the cardinality of the related end is:
 a single entity, in which case, the type="application/atom+xml;type=entry", or
a collection of entities, in which case the type="application/atom+xml;type=feed"

The title attribute on an atom:link element describing an OData relationship provides human-readable information about the link. It has no implied semantics in OData.

#### 6.1.5.1.	Inline Content within a metadata:inline Element ####

An atom:link element describing an OData relationship MAY contain a single metadata:inline element, in which case the element contains the feed (in the case of a collection) or entry (in the case of a single entity), where the feed or entry is a child of the metadata:inline element formatted as per this document.  

An empty metadata:inline element means that there is no content associated with the relationship (i.e., the navigation property is null). Note that this case is distinct from the absence of a metadata:inline element which simply means that the contents of the relationship is deferred (not included in the payload). It is valid to include the metadata:inline element in only a subset of the entries within a feed.

### 6.1.6.	Enitity Type as an atom:category Element ###

An OData entry MAY contain a single atom:category element with a scheme attribute equal to "http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" to identify the entity type of the entry. This element MUST be present if the entry represents an entity that is part of a hierarchy.

An atom:category element describing an OData entity type MUST have a term attribute whose value is the namespace qualified name of the entity type of the entry.

The entry MAY contain additional atom:category elements with different scheme values; such atom:category elements have no semantic meaning in OData.

### 6.1.7.	Entity Content within an atom:content Element ###

The atom:content element defines the content of the entry according to the rules defined in this subsection. 

The atom:content element MAY contain a src attribute, in which case the entry represents a Media Resource. In this case, the value of the src attribute is the URI that can be used to retrieve the content of the Media Resource and the content of the atom:content element MUST be empty. In this case, the metadata:properties element described below appears as a sibling to, rather than a child of, the atom:content element. 

### 6.1.8.	Entity Properties within a metadata:properties Element ###

The metadata:properties element represents a subset of the property values for a resource that are not exclusively mapped to defined or custom elements, as described below <todo:insert reference>. The metadata:properties element MUST be a direct child of the atom:content element EXCEPT for the case where the entry represents a media resource, in which case the metadata:properties element MUST be a sibling of the atom:content element.  In the case that all properties of the resource are exclusively mapped to defined or custom elements, an empty metadata:properties element MAY be present.

#### 6.1.8.1. Entity Property as a data:[propertyName] Element ####

Within the metadata:properties element, individual data values of the resource are represented as elements where the name of the element is the name of the resource property within the Data Namespace.

##### 6.1.8.1.1. Simple Typed Properties #####

For simple typed properties, the content of the data:[propertyName] element represents the value of the property.  For example, the following would represent the value "CEO" for the Title property of an entity.
<data:Title>CEO</data:Title>

##### 6.1.8.1.2. Complex Typed Properties ######

For complex typed properties, the content of the data:[propertyName] element consists of nested data:[propertyName] elements describing the properties of the complex type.  

For example, the complex type "FullName" with properties "FirstName" and "LastName" would be respresented as:

`<data:FullName>
    <data:FirstName>Julie</data:FirstName>
    <data:LastName>Swansworth</data:LastName>
</data:FullName>`

##### 6.1.8.1.3. Collection of Simple Typed Properties #####

For properties that represent a collection of simple types, the data:[propertyName] element may include a metadata:type="Collection([SimpleTypeName])" attribute. The content of the element consists of nested child elements named "element", in the Data Service namespace, for each value in the collection. 

The value of each simple-typed data:element in the collection follows the syntax for the simple typed property as defined in <todo: insert link>.

<data:element> elements MUST NOT contain the metadata:null="true" attribute.

For example, the collection typed property "Emails" would be respresented as:

`<data:Emails metadata:type="Collection(Edm.String)"> 
    <data:element>Julie@Swansworth.com</data:element> 
    <data:element>Julie.Swansworth@work.com</data:element> 
 </data:Emails>`

##### 6.1.8.1.4.	Collection of Complex Typed Properties #####

For properties that represent a collection of complex types, the data:[propertyName] element may include a metdata:type="Collection([ComplexTypeName])" attribute. The content of the element consists of nested child elements named "element", in the Data Service namespace, for each complex typed value in the collection. 

The <data:element> element representing the instance may include a metadata:type attribute to specify the type of the individual element. The value of each complex-typed <data:element> follows the syntax for Complex Typed Properties <todo:insert link>. 

<data:element> elements MUST NOT be empty and MUST NOT contain the metadata:null="true" attribute.

For example, the collection typed property "PhoneNumbers" would be respresented as:

`<data:PhoneNumbers metadata:type="Collection(Person.PhoneNumber)""> 
    <data:element metadata:type="Person.PhoneNumber"> 
        <data:Number>425-555-1212</data:Number> 
    	<data:PhoneType>Home</data:PhoneType> 
    </data:element> 
    <data:element metadata:type="Person.CellPhoneNumber"> 
        <data:Number>425-555-0178</data:Number> 
    	<data:PhoneType>Cell</data:PhoneType> 
    	<data:CellCarrier>Sprint</data:CellCarrier> 
    </data:element> 
</data:PhoneNumbers> `

#### 6.1.9. Nulls represented using the metadata:null Attribute ####

Null valued properties are represented as empty elements with the metadata:null=true attribute. 

The metadata:null attribute distinguishes null values from other empty content (such as an empty string).  

For example, the following represents an empty apartment number:

<data:Apartment metadata:null="true"></data:Apartment>

The absence of the metadata:null attribute is equivalent to specifying metadata:null="false".

### 6.1.10. Data Type represented using the metadata:type Attribute ###

Primitive-valued properties and Complex-valued properties that are not part of a hierarchy MAY contain a metadata:type to specify the primitive type of the property. 

Complex-valued properties that are part of a hierarchy MUST contain a metadata:type attribute. 

For Complex-valued properties, the value of the attribute is the namespace-qualified name of the complex type.

For example, the following specifies that the Age property is a 32bit integer with the value 25:

`<data:Age metadata:type="Edm.Int32">25</data:Age>`

## 6.2.	Sequences of Entities as an atom:feed Element ##

Sequences of entities are represented using an atom:feed Element, where each entity is represented as an atom:entry as described above.

### 6.2.1	atom:id Element within an atom:feed ###

The atom:id element defines a durable, opaque, globally unique identifier for the feed. Its content must be an IRI as defined in http://www.ietf.org/rfc/rfc3987. The consumer of the feed must not assume this IRI can be de-referenced, nor assume any semantics from its structure.

### 6.2.2.	Count as a metadata:count Element ###

The atom:feed element may contain an m:count element to specify the total count of rows in the result. This may be greater than the number of rows in the feed if server side paging has been applied, in which case the feed will include a next results link, as described below.

### 6.2.3.	Self Links as atom:link Elements ###

Atom requires that feeds contain a "self link".  A self link is represented as an atom:link with a rel attribute of "self" and an href that can be used to retrieve the feed from which the current entries are taken.  

Note that the actual set of entries contained within the atom:feed may be a subset of those retrieved using the self link, for example, if filtering has been applied.

### 6.2.4.	Additional Results as an atom:link element ###

The atom:feed element may contain a "next link" to indicate the presence of additional entries that belong to the feed.  Such a link is represented as an atom:link with a rel attribute of "next" and an href attribute containing a URI that can be used to retrieve the next set of results.  

For example, the following atom:link element within an atom:feed element indicates that additional results can be returned by following the specified href:
<atom:link rel="next" href="http://myservice/customers/?$skiptoken=1237"/>
The contents of the href should be treated as an opaque URI that can be used to fetch the next set of results.

# 7.	Custom Mapping to Atom Elements #

Individual property values may be mapped to predefined atom elements or custom content within the entry.  The mapping is described through attributes in the metadata.
The mapping may specify whether the property value appears within the m:properties element as well as being mapped, however in the case of a null value the property MUST always appear within the metadata:properties element as an empty element and the metadata:null=true attribute as described above. 
For more information on the format of the mapping specification, see <todo: insert reference>.

# 8.	Individual Primitive or Complex Scalar Values #

A valid OData payload may consist of a single primitive or complex property, as defined above.  

For example, a request for the first name of a given customer may return the following payload:
`
   <Title xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">CEO</Title> 
`
Similarly, the following payload represents a full name:

`<FullName metadata:type="HumanResources.Address"
           xmlns:metadata="http://schemas.microsoft.com/ado/2007/08/dataservices"
          xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">
    <FirstName>Julie</FirstName>
   <LastName>Swansworth</LastName>
</FullName>
`
# 9.	Collections of Primitive or Complex Scalar Values #

A valid OData payload may consist of a collection of primitive or complex properties. A collection is a single root element containing zero or more <metadata:element> elements whose content is an individual primitive or complex property as defined above.

For example, the following payload represents a collection of phone numbers.

`<PhoneNumbers xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">
    <element>(203)555-1718</element>
    <element>(203)555-1719</element>
</PhoneNumbers>
`
Similarly, the following payload represents a collection of start times.

`<StartTimes 
           xmlns:metadata="http://schemas.microsoft.com/ado/2007/08/dataservices"
          xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">
    <element metadata:type="Edm.DateTime">2010-01-01T00:00:00</element>
    <element metadata:type="Edm.DateTime">2010-01-01T00:00:15</element>
    <element metadata:type="Edm.DateTime">2010-01-01T00:00:30</element>
</StartTimes>`

Similarly, the following payload represents a collection of full names.

`<Names 
           xmlns:metadata="http://schemas.microsoft.com/ado/2007/08/dataservices"
          xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">
    <element metadata:type="HumanResources.FullName">
         <FirstName>Julie</FirstName>
         <LastName>Swansworth</LastName>
    </element>
    <element metadata:type="HumanResources.FullName">
         <FirstName>Mark</FirstName>
         <LastName>Swansworth</LastName>
    </element>
</Names>`

# 10.	Entity Container as a Workspace within a Service Document #

Atom defines the concept of a Service Document to represent the set of available collections. OData uses Service Documents to describe the set of EntitySets available through the service.

## 10.1.	AtomPub Document Namespace ##

Service Documents are described in AtomPub using elements from the following namespace: "http://www.w3.org/2007/app".

In this specification the namespace prefix "app" is used to represent the app Namespace, however the prefix name is not prescriptive.

## 10.2.	app:service element ##

The atom ServiceDocument is represented by the app:service element.  The app:service element contains one or more app:workspaces, which represents a set of collections.

### 10.2.1.	EntityContainer as an app:workspace element ###

OData represents EntityContainers as app:workspace elements.  An app:workspace element contains zero or more app:collections. 

#### 10.2.1.1.	EntitySets as an app:collection elements ####

OData describes available EntitySets as app:collection elements.
The app:collection element contains an href attribute which represents a URI that can be used to retrieve the members of the EntitySet.

##### 10.2.1.1.1	EntitySet Name as atom:title element #####

The atom:title element within the app:collection contains the name of the EntitySet.

