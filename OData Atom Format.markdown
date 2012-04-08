# OData Atom Format #

# 1. Overview #

The OData protocol is comprised of a set of specifications for representing and interacting with structured content.  This document describes the OData Atom Format.

An OData payload may represent:

* a single Primitive value  
* a sequence of Primitive values  
* a single structured ("Complex") value  
* a sequence of structured ("Complex") values  
* an Entity (a structured type with an identity)  
* a sequence of Entities  
* a media resource  
* a single instance of a mime type  
* a single link to a related entity
* a collection of links to related entities
* a service document describing the collections (EntitySets) exposed by the service  
* an xml document describing the entity model exposed by the service  
* an error  
* a batch of requests to be executed in a single request  
* a set of responses returned from a batch request  

For a description of batch requests and responses please see [OData:Batch](ODataBatchProcessingFormat).

# 2. Notational Conventions #

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [[RFC2119](http://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")].

## 2.1 Normative References ##

- Normative reference to ATOM
- Normative reference to ATOMPUB
- Normative reference to OData:Core

# 3. xml:base Attribute #

OData payloads may use the `xml:base` attribute to define a base URI for relative references defined within the scope of the element containing the `xml:base` attribute.

# 4. Primitive Types in Atom #

OData Atom and XML payloads serialize primitive types as shown in the table below.

For full syntax rules, see [OData:ABNF](odatabnf):

<table border="1" cellspacing="0" cellpadding="0">
    <tr>
      <th>Primitive Type</th>
      <th>Literal Form</th>
      <th>Example</th>
    </tr>
    <tr>
      <td>
        <strong>Null</strong><br/>Represents the absence of a value</td>
      <td>"null"</td>
      <td>null</td>
    </tr>
    <tr>
      <td><strong>Edm.Binary</strong><br/>Represent fixed- or variable- length binary data</td>
      <td>((A-F | a-f | 0-9)(A-F | a-f | 0-9))*
      </td>
      <td>23ABFF</td>
    </tr>
    <tr>
      <td><strong>Edm.Boolean</strong><br />Represents the mathematical concept of binary-valued logic</td>
      <td>"true" | "1" <br/> "false" | "0" </td>
      <td>true <br/>false</td>
    </tr>
    <tr>
      <td><strong>Edm.Byte</strong><br />Unsigned 8-bit integer value</td>
      <td>(A-F | a-f | 0-9)(A-F | a-f | 0-9)</td>
      <td>FF</td>
    </tr>
    <tr>
      <td><strong>Edm.DateTime</strong><br/>Represents date and time with values ranging from 12:00:00 midnight, January 1, 1753 A.D. through 11:59:59 P.M, December 9999 A.D.</td>
      <td>yyyy "-" mm "-" dd "T" hh ":" mm [":" ss["." fffffff]]</td>
      <td>2000-12-12T12:00</td>
    </tr>
    <tr>
      <td><strong>Edm.Decimal</strong><br/>Represents numeric values with fixed precision and scale. This type can describe a numeric value ranging from negative 10^255 + 1 to positive 10^255 -1</td>
      <td>["-"][0-9]+[.][0-9]*</td>
      <td>2.345</td>
    </tr>
    <tr>
      <td><strong>Edm.Double</strong><br/>Represents a floating point number with 15 digits precision that can represent values with approximate range of ± 2.23e -308 through ± 1.79e +308</td>
      <td>["-"][0-9]+ ((.[0-9]+) | [E[+ | -][0-9]+])</td>
      <td>2.345</td>
    </tr>
    <tr>
      <td><strong>Edm.Single</strong><br/>Represents a floating point number with 7 digits precision that can represent values with approximate range of ± 1.18e -38 through ± 3.40e +38</td>
      <td>["-"][0-9]+.[0-9]</td>
      <td>2.5</td>
    </tr>
    <tr>
      <td><strong>Edm.Float</strong><br/>Represents a floating point number with 7 digits precision that can represent values with approximate range of ± 1.18e -38 through ± 3.40e +38</td>
      <td>["-"][0-9]+.[0-9]</td>
      <td>2.5</td>
    </tr>    
    <tr>
      <td><strong>Edm.Guid</strong><br/>Represents a 16-byte (128-bit) unique identifier value</td>
      <td>dddddddd "-" dddd "-" dddd "-" dddd "-" dddddddddddd <br/><br/>d= A-F |a-f | 0-9</td>
      <td>12345678-aaaa-bbbb-cccc-ddddeeeeffff</td>
    </tr>
    <tr>
      <td><strong>Edm.Int16</strong><br/>Represents a signed 16-bit integer value</td>
      <td>[-][0-9]+</td>
      <td>16</td>
    </tr>
    <tr>
      <td><strong>Edm.Int32</strong><br/>Represents a signed 32-bit integer value</td>
      <td>[-] [0-9]+</td>
      <td>32</td>
    </tr>
    <tr>
      <td><strong>Edm.Int64</strong><br/>Represents a signed 64-bit integer value</td>
      <td>[-] [0-9]+</td>
      <td>64</td>
    </tr>
    <tr>
      <td><strong>Edm.SByte</strong><br/>Represents a signed 8-bit integer value</td>
      <td>[-] [0-9]+</td>
      <td>8</td>
    </tr>
    <tr>
      <td><strong>Edm.String</strong><br/>Represents fixed- or variable-length character data</td>
      <td>any UTF-8 character <br/> Note: See definition of UTF8-char in <a href="http://tools.ietf.org/html/rfc3629">[RFC3629]</a>
      </td>
      <td>OData</td>
    </tr>
    <tr>
      <td><strong>Edm.Time</strong><br/>Represents the time of day with values ranging from 0:00:00.x to 23:59:59.y, where x and y depend upon the precision</td>
      <td>Defined by the lexical representation for
        time at <a href="http://www.w3.org/TR/xmlschema-2">http://www.w3.org/TR/xmlschema-2</a></td>
      <td>13:20:00</td>
    </tr>
    <tr>
      <td><strong>Edm.DateTimeOffset</strong><br/>Represents date and time as an Offset in minutes from GMT, with values ranging from 12:00:00 midnight, January 1, 1753 A.D. through 11:59:59 P.M, December 9999 A.D</td>
      <td>Defined by
        the lexical representation for datetime (including timezone offset) at <a href="http://www.w3.org/TR/xmlschema-2">
          http://www.w3.org/TR/xmlschema-2</a></td>
      <td>2002-10-10T17:00:00Z</td>
    </tr>
    <tr>
        <td><strong>Edm.Geography</strong><br/>Abstract base type for all Geography types.</td>
		<td>N/A</td>
		<td>N/A</td>
    </tr>
    <tr>
        <td><strong>Edm.GeographyPoint</strong><br/>Represents a point in a round-earth coordinate system.</td>
		<td>srid "Point(" point ")" <br/><i>srid=</i> "SRID=" 1*5DIGIT ";"<br/><i>point=</i> LONG LAT <br/><br/>Where LONG and LAT are EDM.Doubles representing Longitude and Latitude.</td>
		<td>SRID=123435;Point(33.84 -117.91)</td>
    </tr>
    <tr>
        <td><strong>Edm.GeographyLineString</strong><br/>Represents a linestring in a round-earth coordinate system.</td>
		<td>srid "LineString(" linestring ")" <br/><i>linestring=</i> point ["," point]+</td>
		<td>SRID=123435;Linestring(33.84 -117.91,48.87 2.78)</td>
    </tr>
    <tr>
        <td><strong>Edm.GeographyPolygon</strong>Represents a polygon in a round-earth coordinate system.</td>
		<td>srid "Polygon(" polygon ")"<br/><i>polygon=</i> ring "," [ring ","]* <br/><i>ring=</i> "(" firstpoint "," [point ","]* firstpoint ")" ]* ")"<br/><i>firstpoint</i> = point</td>
		<td>SRID=123435;Polygon((33.84 -117.91,48.87 2.78,33.84 -117.91))</td>
    </tr>
    <tr>
        <td><strong>Edm.GeographyCollection</strong><br/>Represents a collection of Geography Values.</td>
		<td>srid "GeographyCollection(" geographycollection ")"<br/><i>geographycollection</i>= geographyvalue [","  geographyvalue]*<br/><i>geographyvalue=</i>"Point("point")" |<br/> "LineString(" linestring ")" | <br/>"Polygon(" polygon ")" |<br/>"GeographyCollection(" geographycollection ")" |<br/>"MultiPoint("multipoint ")" |<br/>"MultiLineString("multilinestring ")" |<br/>"MultiPolygon("multipolygon ")"<br/></td>
        <td>SRID=123435;GeographyCollection(Point(33.84 -117.91),Point(48.87 2.78))</td>
    </tr>
    <tr>
        <td><strong>Edm.GeographyMultiPoint</strong>Represents a collection of points in a round-earth coordinate system</td>
		<td>srid "MultiPoint(" multipoint ")" <br/><i>multipoint=</i> point ["," point]*</td>
		<td>SRID=123435;MultiPoint((33.84 -117.91),(48.87 2.78))</td>
    </tr>
    <tr>
        <td><strong>Edm.GeographyMultiLineString</strong>Represents a collection of linestrings in a round-earth coordinate system.</td>
		<td>srid "MultiLineString(" multilinestring ")"<br/><i>multilinestring=</i> "(" linestring ")" [",(" linestring ")" ]*</td>
		<td>SRID=123435;MultiLineString((33.84 -117.91,48.87 2.78),(33.84 -117.91, 28.36 -81.56))</td>
    </tr>
    <tr>
        <td><strong>Edm.GeographyMultiPolygon</strong>Represents a collection of polygons in a round-earth coordinate system.</td>
		<td>srid "MultiPolygon(" multipolygon ")"<br/><i>multipolygon=</i> "(" polygon ")" [",(" polygon ")"]*</td>
		<td>SRID=123435;MultiPolygon(((33.84 -117.91,(33.84 -117.91,28.36 -81.56,33.84 -117.91)))</td>
    </tr>
    <tr>
        <td><strong>Edm.Geometry</strong><br/>Abstract base type for all Geometry types</td>
		<td>N/A</td>
		<td>N/A</td>
    </tr>
    <tr>
        <td><strong>Edm.GeometryPoint</strong><br/>Represents a point in a flat-earth coordinate system.</td>
		<td>srid "Point(" point ")"</td>
		<td>SRID=123435;Point(33.84 -117.91)</td>
    </tr>
    <tr>
        <td><strong>Edm.GeometryLineString</strong><br/>Represents a linestring in a flat-earth coordinate system.</td>
		<td>srid "LineString(" linestring ")"</td>
		<td>SRID=123435;Linestring(33.84 -117.91,48.87 2.78)</td>
    </tr>
    <tr>
        <td><strong>Edm.GeometryPolygon</strong>Represents a polygon in a flat-earth coordinate system.</td>
		<td>srid "Polygon(" polygon ")"</td>
		<td>SRID=123435;Polygon((33.84 -117.91,48.87 2.78,33.84 -117.91))</td>
    </tr>
    <tr>
        <td><strong>Edm.GeometryCollection</strong><br/>Represents a collection of Geometry Values.</td>
		<td>srid "GeometryCollection(" geometrycollection ")"<br/><i>geometrycollection=</i> geometryvalue [","  geometryvalue]*<br/><i>geometryvalue=</i> "Point("point")" |<br/> "LineString(" linestring ")" | <br/>"Polygon(" polygon ")" |<br/>"GeometryCollection(" geometrycollection ")" |<br/>"MultiPoint("multipoint ")" |<br/>"MultiLineString("multilinestring ")" |<br/>"MultiPolygon("multipolygon ")"<br/></td>
        <td>SRID=123435;GeometryCollection(Point(33.84 -117.91),Point(48.87 2.78))</td>
    </tr>
    <tr>
        <td><strong>Edm.GeometryMultiPoint</strong>Represents a collection of points in a flat-earth coordinate system.</td>
		<td>srid "MultiPoint(" multipoint ")"</td>
		<td>SRID=123435;MultiPoint((33.84 -117.91),(48.87 2.78))</td>
    </tr>
    <tr>
        <td><strong>Edm.GeographyMultiLineString</strong>Represents a collection of linestrings in a flat-earth coordinate system.</td>
		<td>srid "MultiLineString(" multilinestring ")"<br/></td>
		<td>SRID=123435;MultiLineString((33.84 -117.91,48.87 2.78),(33.84 -117.91, 28.36 -81.56))</td>
    </tr>
    <tr>
        <td><strong>Edm.GeographyMultiPolygon</strong>Represents a collection of polygons in a flat-earth coordinate system.</td>
		<td>srid "MultiPolygon(" multipolygon ")"</td>
		<td>SRID=123435;MultiPolygon(((33.84 -117.91,(33.84 -117.91,28.36 -81.56,33.84 -117.91)))</td>
    </tr>
</table>

# 5. Use of Atom #

The Atom Syndication Format [RFC4287](http://www.ietf.org/rfc/rfc4287) defines an XML-based format for describing collections ("feeds") made up of individual "entries". The Atom Publishing Protocol [RFC5023](http://www.ietf.org/rfc/rfc5023.txt) defines an application-level protocol based on HTTP transfer of Atom-formatted representations.

# 5.1 Namespaces #
OData defines meaning for elements and attributes defined in the following namespaces.

# 5.1.1 Atom Namespace #
Atom elements and attributes are defined within the Atom namespace: "http://www.w3.org/2005/Atom".

In this specification the namespace prefix "atom" is used to represent the Atom Namespace, however the prefix name is not prescriptive.

# 5.1.2. Atom Publishing Protocol Namespace # 
Atom Publishing Protocol (AtomPub) elements and attributes are defined within the AtomPub namespace: "http://www.w3.org/2007/app".

In this specification the namespace prefix "app" is used to represent the AtomPub Namespace, however the prefix name is not prescriptive.

# 5.1.3. OData Data Namespace #

Elements that describe the actual data values for an entity are qualified with the OData Data Namespace: "http://schemas.microsoft.com/ado/2007/08/dataservices"

In this specification the namespace prefix "data" is used to represent the OData Data Namespace, however the prefix name is not prescriptive.

## 5.1.4. OData Metadata Namespace ##

Attributes and elements that represent metadata (such as type, null usage, and entry-level etags) are defined within the OData Metadata Namespace: "http://schemas.microsoft.com/ado/2007/08/dataservices/metadata". Custom elements or attributes MUST NOT use this namespace.

In this specification the namespace prefix "metadata" is used to represent the OData Metadata Namespace, however the prefix name is not prescriptive.

# 6. Atom Element Definition #

OData's Atom format defines extensions and conventions on top of [RFC4287](http://www.ietf.org/rfc/rfc4287) and [RFC5023](http://www.ietf.org/rfc/rfc5023.txt) for representing structured data as follows:

## 6.1.	Entity Instances ##
Entity Instances, whether individual or within an ATOM feed, are represented as `atom:entry` elements. 

For example, the following `atom:entry` element describes a Product:
 
	<entry>
	  <id>http://services.odata.org/OData/OData.svc/Products(0)</id> 
	  <title type="text">Bread</title> 
	  <summary type="text">Whole grain bread</summary> 
	  <updated>2012-03-30T07:11:05Z</updated> 
	  <author>
	    <name /> 
	  </author>
	  <link rel="edit" title="Product" href="Products(0)" /> 
	  <link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/Category" type="application/atom+xml;type=entry" title="Category" href="Products(0)/Category" /> 
	  <link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/Supplier" type="application/atom+xml;type=entry" title="Supplier" href="Products(0)/Supplier" /> 
	  <category term="ODataDemo.Product" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /> 
	  <content type="application/xml">
	    <m:properties>
	      <d:ID m:type="Edm.Int32">0</d:ID> 
	      <d:ReleaseDate m:type="Edm.DateTime">1992-01-01T00:00:00</d:ReleaseDate> 
	      <d:DiscontinuedDate m:type="Edm.DateTime" m:null="true" /> 
	      <d:Rating m:type="Edm.Int32">4</d:Rating> 
	      <d:Price m:type="Edm.Decimal">2.5</d:Price> 
	    </m:properties>
	  </content>
	</entry>

This section defines the elements and attributes within an `atom:entry` element that are assigned meaning in OData.

### 6.1.1.	The `atom:entry` Element ###
An `atom:entry` element is used to represent a single entity, which is an instance of a structured type with an identity.

The `atom:entry` element MAY contain a `metadata:etag` attribute, representing an opaque string value that can be used in a subsequent request to determine if the value of the entity has changed.  For details on how ETags are used, refer to the <todo:insert reference here> spec.

### 6.1.2.	The `atom:id` Element ###
The `atom:id` element defines a durable, opaque, globally unique identifier for the entry. Its content must be an IRI as defined in [RFC3987](http://www.ietf.org/rfc/rfc3987). The consumer of the feed must not assume this IRI can be de-referenced, nor assume any semantics from its structure.

### 6.1.3.	Self and Edit Links as `atom:link` Elements ###
Atom defines two types of links within an entry that represent retrieve or update/delete operations on the entry. `atom:link` elements with a rel attribute of `"self"` can be used to retrieve the entity (via the URL specified in the `href` attribute). `atom:link` elements with a rel attribute of `"edit"` can be used to retrieve, update, or delete the entity (via the URL specified in the `href` attribute).

An `atom:entry` element representing an OData entity SHOULD contain a self link, an edit link, or both for a particular entry, but MUST NOT contain more than one edit link for a given entry.  Absence of an edit link implies that the entry is read-only.

#### 6.1.5 Stream Properties as `atom:link` Elements ####
An entity may have one or stream properties (for example, a photo property of an employee entity). Properties that represent streams have a type of "Edm.Stream".

OData uses `atom:link` elements to represent named stream properties of an Entity.

For example, a stream property named "Photo" be represented through an `atom:link` element as a child of the `atom:entry` element as follows:

	<atom:link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/mediaresource/Photo" 
	type="img/jpg" title="Photo" href="Categories(0)/Photo"/>

A stream property named "Photo" be edited through an `atom:link` element as a child of the `atom:entry` element as follows:

	<atom:link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/edit-media/Photo" 
	type="img/jpg" title="Photo" href="Categories(0)/Photo"/>

#### 6.1.5.1 The `rel` attribute of a Link Representing a Stream Property ####
The `rel` attribute for an `atom:link` element that can be used to retrieve a stream property is made up of the name of the [OData Data Namespace](#ODataDataNamespace), followed by the string "/mediaresource/", followed by the name of the stream property on the entity.  

The `rel` attribute for an `atom:link` element that can be used to write a stream property is made up of the name of the [OData Data Namespace](#ODataDataNamespace), followed by the string "/edit-media/", followed by the name of the stream property on the entity.

Note that the full name must be used; the use of relative URLs in the rel attribute is not allowed.

#### 6.1.5.2 The `href` attribute of a Link Representing a Stream Property ####
The `href` attribute of an `atom:link` element describing an OData stream property contains the URI that can be used to specify the URI that can be used to read, or write, the stream, according to the [`rel`](#The`rel`attributeofaLinkRepresentingaStreamProperty) attribute. This URI may be relative or absolute.

#### 6.1.5.3 The `title` attribute of a Link Representing a Stream Property ####
The `title` attribute on an `atom:link` element describing an OData relationship provides human-readable, possibly language-dependent, and not necessarily unique information about the link. It has no implied semantics in OData.

### 6.1.6.	Relationships as `atom:link` Elements ###
OData uses `atom:link` elements to represent relationships between entities.

For example, the set of related products for a particular catagory may be represented through an `atom:link` element as a child of a category `entry` element as follows:

	<atom:link 
		rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/Products" 
		href="Categories(0)/Products"
		type="application/atom+xml;type=feed" 
		title="Products" />

The related data for the relationship MAY be included in the Entity using a single child [`metadata:inline`](#InlineContentwithina`metadata:inline`Element) element.
	
#### 6.1.6.1. The `rel` attribute of an `atom:link` element Representing a Relationship ####
The `rel` attribute for an `atom:link` element that represents a relationship MUST be present and is made up of the name of the [OData Data Namespace](#ODataDataNamespace), followed by the string "`/related/`" followed by the name of the navigation property on the entity.  

Note that the full name must be used; the use of relative URLs in the rel attribute is not allowed.

#### 6.1.6.2 The `href` attribute of an `atom:link` element Representing a Relationship ####
The `href` attribute of an `atom:link` element describing an OData relationship MUST be present and specifies the URL that can be used to retrieve the related entities. This URL may be relative or absolute.

#### 6.1.6.3. The `type` attribute of an `atom:link` element Representing a Relationship ####
The `type` attribute on an `atom:link` element describing an OData relationship MUST be present and determines whether the cardinality of the related end is:  

* a single entity, in which case, the `type`="application/atom+xml;type=entry", or   
* a collection of entities, in which case the `type`="application/atom+xml;type=feed"  

#### 6.1.6.4. The `title` attribute of an `atom:link` element Representing a Relationship ####
The `title` attribute on an `atom:link` element describing an OData relationship SHOULD be present and equal to the name of the navigation property, and provides human-readable, possibly language-dependent, and not necessarily unique information about the link.

#### 6.1.7.	Inline Content within a `metadata:inline` Element ####
An [`atom:link`](#RelationshipsasAtomLinkElements) element describing an OData relationship MAY contain a single `metadata:inline` element, in which case the element contains the feed (in the case of a collection) or entry (in the case of a single entity), where the feed or entry is a child of the `metadata:inline` element formatted as per this document.  

An empty `metadata:inline` element means that there is no content associated with the relationship (i.e., the navigation property is null). Note that this case is distinct from the absence of a `metadata:inline` element which simply means that the contents of the relationship is deferred (not included in the payload). 

It is valid to include the `metadata:inline` element in only a subset of the entries within a feed.

### 6.1.8.	Relationship Links as `atom:link` Elements ###
OData uses `atom:link` elements to represent the collection of relationship [link(s)](#LinksAsXMLElements) between entities.

For example, the set of [links](#LinksAsXMLElements) between a category and related products may be represented through an `atom:link` element as a child of a category entry element as follows:

	<atom:link 
	  rel="http://schemas.microsoft.com/ado/2007/08/dataservices/relatedlinks/Products" 
	  href="Categories(0)/$links/Products"
	  type="application/xml"
	  title="Products" />
	
#### 6.1.8.1. The `rel` attribute of an `atom:link` element Representing Relationship Links ####
The `rel` attribute for an `atom:link` element that represents a collection of relationship links MUST be present and is made up of the name of the [OData Data Namespace](#ODataDataNamespace), followed by the string `"/relatedlinks/"` followed by the name of the navigation property on the entity.  

Note that the full name must be used; the use of relative URLs in the rel attribute is not allowed.

#### 6.1.8.2 The `href` attribute of an `atom:link` element Representing Relationship Links####
The `href` attribute of an `atom:link` element describing relationship links MUST be present and specifies the URI that represents the collection of relationship links.  This URI may be relative or absolute.

#### 6.1.8.3. The `type` attribute of an `atom:link` element Representing Relationship Links ####
The `type` attribute on an `atom:link` element describing relationship links MUST be present and equal to the content type "application/xml"

#### 6.1.8.4. The `title` attribute of an `atom:link` element Representing Relationship Links ####
The `title` attribute on an `atom:link` element describing relationship links SHOULD be present and equal to the name of the navigation property, and provides human-readable, possibly language-dependent, and not necessarily unique information about the link.

### 6.1.11.	Entity Type as an `atom:category` Element ###
An OData entry MAY contain a single `atom:category` element with a scheme attribute equal to `"http://schemas.microsoft.com/ado/2007/08/dataservices/scheme"` to identify the entity type of the entry. This element MUST be present if the entry represents an entity whose type is part of a type hierarchy.

An `atom:category` element describing an OData entity type MUST have a `term` attribute whose value is the namespace qualified name of the entity type of the entry.

The entry MAY contain additional `atom:category` elements with different scheme values; such `atom:category` elements have no semantic meaning in OData.

### 6.1.12.	Entity Content within an `atom:content` Element ###
The `atom:content` element defines the content of the entry.

#### 6.1.12.1. Media Entities As Media Link Entries using the `src` Attribute ####
The `atom:content` element MAY contain a `src` attribute, in which case the entry is a Media Link Entry, used to represent a Media Resource (for example, a photo). The value of the `src` attribute MUST be a URI that can be used to retrieve the content of the Media Resource.

For Media Link Entries the `atom:content` element MUST be empty. In this case, Properties of the Media Resource (other than the stream) are represented by the [`metadata:properties`](#EntityPropertieswithinametadata:propertiesElement) element  as a sibling to, rather than a child of, the `atom:content` element. 

#### 6.1.nn. `atom:link` element for Updating Media Link Entries ####
A [Media Link Entry](#StreamedEntitiesAsMediaLinkEntriesUsingthesrcAttribute) MAY contain an `atom:link` element with a rel attribute of "edit-media" to specify a URL that can be used to write to the BLOB associated with the entity.

##### 6.1.nn.1 The `rel` attribute for writing to Media Link Entries #####
Within an `atom:entry` representing a Media Link Entry, an `atom:link` element with a `rel` attribute of "edit-media" is used to identify a link that can be used to write to the BLOB associated with the entry.

##### 6.1.nn.2 The `href` attribute for writing to Media Link Entries #####
An atom:link element representing the link used to write to the BLOB associated with the entity MUST include an `href` attribute to specify the URI that can be used to write the stream. This URI may be relative or absolute. 

### 6.1.13.	Entity Properties within a `metadata:properties` Element ###
The `metadata:properties` element represents a subset of the property values for an entity that are not exclusively mapped to defined or custom elements, as described in [Custom Mapping to Atom Elements](). The `metadata:properties` element MUST be a direct child of the `atom:content` element EXCEPT for the case where the entry represents a media resource, in which case the `metadata:properties` element MUST be a sibling of the `atom:content` element.  In the case that all properties of the entity are exclusively mapped to defined or custom elements, an empty `metadata:properties` element MAY be present.

#### 6.1.13.1. Entity Property as a `data:[propertyName]` Element ####
Within the `metadata:properties` element, individual data values of the entity are represented as elements where the name of the element is the name of the entity property within the [OData Data Namespace]().

The `data:[PropertyName]` element MAY include a [`metadata:type`](#DataTyperepresentedusingthemetadata:typeAttribute) attribute to specify the type of the simple- or complex-typed instance.

##### 6.1.13.1.1. Simple Typed Properties #####
For simple typed properties, the content of the `data:[propertyName]` element represents the value of the property.  For example, the following would represent the value "CEO" for the Title property of an entity:  
`<data:Title>CEO</data:Title>`

##### 6.1.13.1.2. Complex Typed Properties ######
For complex typed properties, the content of the `data:[propertyName]` element consists of nested `data:[propertyName]` elements describing the properties of the complex type. It MAY include a `metadata:type` attribute to specify the type.   

For example, the complex typed property "Name", with properties "FirstName" and "LastName" would be respresented as:

	<data:Name metadata:type="MyModel.FullName">  
	    <data:FirstName>Julie</data:FirstName>  
	    <data:LastName>Swansworth</data:LastName>  
	</data:Name>
	
##### 6.1.13.1.3. Collection of Simple Typed Properties #####
For properties that represent a collection of simple types, the `data:[propertyName]` element may include a `metadata:type` attribute with a value of `"Collection([SimpleTypeName])"`. The content of the element consists of nested child elements named "`element`", in the Data Service namespace, for each value in the collection. 

The value of each simple-typed data:element in the collection follows the syntax for the simple typed property as defined in <todo: insert link>.

`<data:element>` elements MUST NOT contain the `metadata:null="true"` attribute value.

For example, the collection typed property "Emails" would be respresented as:

	<data:Emails metadata:type="Collection(Edm.String)">  
	    <data:element>Julie@Swansworth.com</data:element>  
	    <data:element>Julie.Swansworth@work.com</data:element>  
	</data:Emails>
	
##### 6.1.13.1.4.	Collection of Complex Typed Properties #####

For properties that represent a collection of complex types, the `data:[propertyName]` element may include a `metdata:type` attribute with a value of `"Collection([ComplexTypeName])`" attribute. The content of the element consists of nested child elements named "`element`", in the Data Service namespace, for each complex typed value in the collection. 

The `<data:element>` element representing the instance may include a `metadata:type` attribute to specify the type of the individual element. The value of each complex-typed `<data:element>` follows the syntax for Complex Typed Properties <todo:insert link>. 

<data:element> elements MUST NOT be empty and MUST NOT contain the metadata:null="true" attribute.

For example, the collection typed property "PhoneNumbers" would be respresented as:

	<data:PhoneNumbers metadata:type="Collection(Person.PhoneNumber)"">  
	    <data:element metadata:type="Person.PhoneNumber">  
	        <data:Number>425-555-1212</data:Number>  
	    	<data:PhoneType>Home</data:PhoneType>  
	    </data:element>  
	    <data:element metadata:type="Person.CellPhoneNumber">  
	        <data:Number>425-555-0178</data:Number>  
	    	<data:PhoneType>Cell</data:PhoneType>  
	    	<data:CellCarrier>Sprint</data:CellCarrier>  
	    </data:element>  
	</data:PhoneNumbers> 

#### 6.1.14. Nulls represented using the metadata:null Attribute ####

Null valued properties are represented as empty elements with the metadata:null=true attribute. 

The metadata:null attribute distinguishes null values from other empty content (such as an empty string).  

For example, the following represents an empty apartment number:

	<data:Apartment metadata:null="true"/>

The absence of the metadata:null attribute is equivalent to specifying metadata:null="false".

### 6.1.15. Data Type represented using the metadata:type Attribute ###

Primitive-valued properties and Complex-valued properties that are not part of a hierarchy MAY contain a metadata:type to specify the primitive type of the property. 

Complex-valued properties that are part of a hierarchy MUST contain a metadata:type attribute. 

For Complex-valued properties, the value of the attribute is the namespace-qualified name of the complex type.

For example, the following specifies that the Age property is a 32bit integer with the value 25:

	<data:Age metadata:type="Edm.Int32">25</data:Age>

## 6.2.	Sequences of Entities
Sequences of entities are represented in Atom as an Atom Feed.

### 6.2.1 Sequence of Entities as an atom:feed Element ##

Sequences of entities are represented using an atom:feed Element, where each entity is represented as an [`atom:entry`](#EntityInstances).

### 6.2.1	The `atom:id` Element within an `atom:feed` ###

The `atom:id` element defines a durable, opaque, globally unique identifier for the feed. Its content must be an IRI as defined in http://www.ietf.org/rfc/rfc3987. The consumer of the feed must not assume this IRI can be de-referenced, nor assume any semantics from its structure.

### 6.2.2.	Count as a `metadata:count` Element ###

The `atom:feed` element may contain an `m:count` element to specify the total count of rows in the result. This may be greater than the number of rows in the feed if server side paging has been applied, in which case the feed will include a next results link, as described below.

### 6.2.3.	Self Links as `atom:link` Elements ###

Atom requires that feeds contain a "self link".  A self link is represented as an `atom:link` with a `rel` attribute of "self" and an `href` that can be used to retrieve the feed from which the current entries are taken.  

Note that the actual set of entries contained within the atom:feed may be a subset of those retrieved using the self link, for example, if filtering has been applied.

### 6.2.4.	Additional Results as an `atom:link` element ###

The `atom:feed` element may contain a "next link" to indicate the presence of additional entries that belong to the feed.  Such a link is represented as an `atom:link` with a rel attribute of "next" and an href attribute containing a URI that can be used to retrieve the next set of results.  

For example, the following atom:link element within an atom:feed element indicates that additional results can be returned by following the specified `href`:
<atom:link rel="next" href="http://myservice/customers/?$skiptoken=1237"/>
The contents of the href should be treated as an opaque URI that can be used to fetch the next set of results.

# 7. Actions #
Zero or more actions may be associated with a feed or entry.

The actions associated with a particular feed or entry MAY be described using `metadata:action` element(s) that are direct children of the feed or entry on which the action(s) exist.

For example, the following element describes an "Order" action:

	<metadata:action
	  metadata="#DemoService.OrderProduct"
	  target="http://services.odata.org/OData/OData.svc/Products(1)/OrderProduct"
	  title="Order"
	/>

## 7.1. Actions as a `metadata:action` Element ##
Actions are represented as `metadata:action` elements that appear as direct children of the `atom:feed` or `atom:entry` element representing the feed or entity on which the action(s) exist.

### 7.1.1. The `metadata:metadata` Attribute ###
A `metadata:action` element MUST have a `metadata:metadata` attribute which specifies the container qualified name of the function import describing the action, preceded by a "#". For example, "#MyEntityContainer.MyFunctionName". This function import name must be unique within the entity container. 

If the metadata cannot be retrieved by appending $metadata to the service root, then this name must additionally be prefixed by a URL that can be used to retrieve the metadata document containing the function import that describes the action.

### 7.1.2. The `metadata:target` Attribute ###
A `metadata:action` element MUST have a `metadata:target` attribute that specifies the URL to POST to in order to invoke the action. 

The first parameter of the action MUST be a binding parameter that is bound to the feed or entity on which the action is specified, and MUST NOT be provided as a separate parameter by the client when invoking the action.

### 7.1.3. The `metadata:title` Attribute ###
The `metadata:action` element MUST have a `metadata:title` attribute that contains a human-readable, possibly language-dependent, and not necessarily unique name for the action, commonly used by clients to describe the action to a user.

# 8. Functions #
Zero or more functions may be associated with a feed or entry.

The functions associated with a particular feed or entry MAY be described using `metadata:function` element(s) that are direct children of the feed or entry on which the action(s) exist.

For example, the following element describes a "GetTopProducts" function:

	<metadata:function
	  metadata="#DemoService.GetTopProducts"
	  target="http://services.odata.org/OData/OData.svc/Categories(0)/GetTopProducts()"
	  title="GetTopProducts"
	/>

## 8.1. Functions as a `metadata:function` Element ##
Functions are represented as `metadata:function` elements that appear as direct children of the `atom:feed` or `atom:entry` element representing the feed or entity on which the function(s) exist.

### 8.1.1. The `metadata:metadata` Attribute ###
A `metadata:function` element MUST have a `metadata:metadata` attribute which specifies the container qualified name of the function import describing the function, preceded by a "#". For example, "#MyEntityContainer.MyFunctionName".

The named function may have multiple overloads (multiple function imports) within the container. If the metadata:function cannot be used to invoke all overloads for the function, then it must further be distinguished by appending a comma separated ordered list of parameter type names, enclosed in parenthesis (). For example, "#MyEntityContainer.MyFunctionName(Edm.Integer, Edm.String)".

If the metadata cannot be retrieved by appending $metadata to the service root, then this name must additionally be prefixed by a URL that can be used to retrieve the metadata document containing the function import that describes the function.

### 8.1.2. The `metadata:target` Attribute ###
A `metadata:function` element MUST have a `metadata:target` element that specifies the URL to GET from in order to invoke the function. 

The first parameter of the function MUST be a binding parameter that is bound to the feed or entity on which the function is specified, and MUST NOT be provided as a separate parameter by the client when invoking the function.

### 8.1.3. The `metadata:title` Attribute ###
The `metadata:function` element MUST have a `metadata:title` attribute that contains a human-readable, possibly language-dependent, and not necessarily unique name for the function, commonly used by clients to describe the function to a user.

# 9. Annotations #

In OData V3, Annotations may be appear as a child to any of the following elements:
`<atom:feed>`, `<atom:entry>`, `<metadata:properties>`, `<metadata:function>`, `<metadata:action>`, or `<atom:link>` where `rel` indicates a navigation link or named stream. 

There are two types of annotation terms in OData; ValueTerms and TypeTerms.

A ValueTerm defines a named annotation for a single primitive value. A ValueAnnotation specifies the value for a ValueTerm.

A TypeTerm defines a named annotation for a complex or entity typed value. A TypeAnnotation specifies the values for each property defined by the TypeTerm.

Custom ValueTerms and Custom TypeTerms MUST be defined in a namespace other than the [Atom Namespace](#AtomNamespace), [AtomPub Namespace](#AtomPublishingProtocolNamespace), [OData Data Namespace](#ODataDataNamespace), or [OData Metadata Namespace](#ODataMetadataNamespace). Annotations corresponding to custom terms add additional information about the item being annotated and SHOULD be designed in such a way that they can be safely ignored by the client.

TypeAnnotations and ValueAnnotations specify a target, which represents the feed, entry, property, function, action, navigation link, or named stream being annotated. The target is specified relative to the parent of the ValueAnnotation or TypeAnnotation, and is either the parent itself (".") or the name of the sibling element being annotated. If more than one sibling exists with the same unqualifed name, then the namespace qualified element named MUST be used.

## 9.1. ValueAnnotations as custom Elements ##
A ValueAnnotation is specified by a single element containing the `metadata:target` attribute, whose element name is the namespace-qualified ValueTerm.

The content of the ValueAnnotation element is the value of the ValueTerm, formatted as per [Primitive Types In Atom](#PrimitiveTypesInAtom).

For example; the following specifies a value of "Home" for the "PhoneNumberType" ValueTerm applied to the "PhoneNumber" property of a customer:

      <metadata:properties  xmlns:contact="http://odata.org/vocabularies/contact/v1">
        <data:CustomerID>ALFKI</data:CustomerID>
        <data:ContactName> Alfreds Futterkiste </data:ContactName>
        <data:Phone>030-0074321</data:Phone>
		<contact:PhoneNumberType metadata:target="Phone">Home</contact:PhoneNumberType>
      </metadata:properties>

### 9.1.1. The `metadata:target` attribute.
The `metadata:target` attribute MUST be present on a ValueAnnotation and identifies the target of the annotation as described in [Annotations]().

### 9.1.2. The `metadata:type` attribute.
If the type of the annotation value being specified is `Edm.String`, then the ValueAnnotation element MAY contain the `metadata:type` attribute specifying "Edm.String", otherwise the ValueAnnotation element MUST contain the `metadata:type` attribute specifying the appropriate primitive type.

## 9.2. Type Annotations as Custom Elements##
A TypeAnnotation is specified by an element containing the `metadata:target` attribute, whose element name is the namespace-qualified TypeTerm.

The TypeAnnotation element contains a single child element for each property of the TypeTerm being specified. The name of each such child element is the namespace-qualified name of the property, and its content specifies the value of the corresponding property of the TypeTerm, formatted as per [Primitive Types In Atom](#PrimitiveTypesInAtom). If the type of the annotation property is `Edm.String`, then the child element MAY contain the `metadata:type` attribute specifying "Edm.String", otherwise  the child element MUST contain the `metadata:type` attribute specifying the appropriate primitive type. 

For example; the following specifies the "StreetAddress", "City", "Region", "Country" and "Postal Code" properties of an "Address" TypeTerm applied to a customer entry:

      <metadata:properties  xmlns:contact="http://odata.org/vocabularies/contact/v1">
        <data:CustomerID>ALFKI</data:CustomerID>
        <data:ContactName> Alfreds Futterkiste </d:ContactName>
        <data:Phone>030-0074321</data:Phone>
        <contact:Address metadata:target=".">  
          <contact:StreetAddress>Obere Str. 578</contact:StreetAddress>
          <contact:City>Toronto</contact:City>
          <contact:Region metadata:null="true" />
          <contact:PostalCode>12209</contact:PostalCode>
          <contact:Country>Germany</contact:Country>
        </contact:Address>
      </metadata:properties>

###8.2.1 The `metadata:target` attribute.
The `metadata:target` attribute MUST be present on a TypeAnnotation and identifies the target of the annotation as described in [Annotations]().

# 10. Custom Mapping to Atom Elements #

Individual property values may be mapped to predefined atom elements or custom content within the entry.  The mapping is described through attributes in the metadata.

The mapping may specify whether the property value appears within the metadata:properties element as well as being mapped, however in the case of a null value the property MUST always appear within the metadata:properties element as an empty element and the metadata:null=true attribute as described above. 

For more information on the format of the mapping specification, see <todo: insert reference>.

# 11.	Individual Primitive or Complex Scalar Values #

A valid OData payload may consist of a single primitive or complex property, as defined above.  

For example, a request for the first name of a given customer may return the following payload:

	   <Title xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">CEO<Title> 

Similarly, the following payload represents a full name:

	<FullName metadata:type="HumanResources.Address"
	      xmlns:metadata="http://schemas.microsoft.com/ado/2007/08/dataservices"
	      xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">
	   <FirstName>Julie</FirstName>
	   <LastName>Swansworth</LastName>
	</FullName>
	
# 12.	Collections of Primitive or Complex Scalar Values #

A valid OData payload may consist of a collection of primitive or complex properties. A collection is a single root element containing zero or more <metadata:element> elements whose content is an individual primitive or complex property as defined above.

For example, the following payload represents a collection of phone numbers.

	<PhoneNumbers xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">
	    <element>(203)555-1718</element>
	    <element>(203)555-1719</element>
	</PhoneNumbers>
	
Similarly, the following payload represents a collection of start times.

	<StartTimes 
	     	xmlns:metadata="http://schemas.microsoft.com/ado/2007/08/dataservices"
	        xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">
	   <element metadata:type="Edm.DateTime">2010-01-01T00:00:00</element>
	   <element metadata:type="Edm.DateTime">2010-01-01T00:00:15</element>
	   <element metadata:type="Edm.DateTime">2010-01-01T00:00:30</element>
	</StartTimes>
	
Similarly, the following payload represents a collection of full names.

	<Names xmlns:metadata="http://schemas.microsoft.com/ado/2007/08/dataservices"
	       xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">
	   <element metadata:type="HumanResources.FullName">
	       <FirstName>Julie</FirstName>
	       <LastName>Swansworth</LastName>
	   </element>
	   <element metadata:type="HumanResources.FullName">
	        <FirstName>Mark</FirstName>
	        <LastName>Swansworth</LastName>
	   </element>
	</Names>
	
# 13.	Entity Container as a Workspace within a Service Document #

Atom defines the concept of a Service Document to represent the set of available collections. OData uses Service Documents to describe the set of EntitySets available through the service.

## 13.2. The `app:service` element ##

The atom ServiceDocument is represented by the app:service element.  The app:service element contains one or more `app:workspaces`, which represents a set of collections.

### 13.2.1.	EntityContainer as an `app:workspace` element ###

OData represents EntityContainers as `app:workspace` elements.  An `app:workspace` element contains zero or more `app:collections`. 

#### 13.2.1.1.	EntitySets as an `app:collection` elements ####

OData describes available EntitySets as `app:collection` elements.
The app:collection element contains an href attribute which represents a URI that can be used to retrieve the members of the EntitySet.

##### 13.2.1.1.1	EntitySet Name as an `atom:title` element #####

The `atom:title` element within the app:collection contains the name of the EntitySet.

# 14. Links 
Links represent the relationships between an entity and related entity(s). The link(s) available from a particular entity for a particular relationship can be retrieved from the service as a colleciton of URIs within a [`data:link`](#Linkswithinadata:linkselement) element.

## 14.1 Collection of Links as a `data:links` Element ##
A `data:link` element represents the set of references from one entity to all related entities according to a particular relationship.

The reference for each related entity is represented as a `data:uri` element that appears as a direct child of the `data:link` element.

For example, a query for links to Products within the Category with ID=1:

	http://services.odata.org/OData/OData.svc/Categories(1)$links/Products

might return the following XML response:
	
	<links xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices"> 
		<uri>http://services.odata.org/OData/OData.svc/Products(1)</uri> 
		<uri>http://services.odata.org/OData/OData.svc/Products(2)</uri> 
		<uri>http://services.odata.org/OData/OData.svc/Products(3)</uri> 
		<uri>http://services.odata.org/OData/OData.svc/Products(4)</uri> 
		<uri>http://services.odata.org/OData/OData.svc/Products(5)</uri> 
		<uri>http://services.odata.org/OData/OData.svc/Products(6)</uri> 
	</links>
	
## 14.2 Link as `data:uri` Element ##
Each related entity is represented as a `data:uri` element, which appears as a direct child of a [`data:link`](#linkswithinadata:linkselement) element.

The content of the `data:uri` element is the URI of the related entity.

#15. Extensibility#
Implementations may add custom content anywhere allowed by [RFC4287](http://www.ietf.org/rfc/rfc4287), Section 6, "Extending Atom"; however, custom elements and attributes MUST NOT be defined in the [OData Data Namespace](#odatadatanamespace) nor the [OData Metadata Namespace](#odatametadatanamespace).
