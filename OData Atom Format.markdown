# OData Atom Format #

Table of Contents

1. [Overview](#overview)  
2. [Notational Conventions](#notationalconventions)  
    2.1. [Normative References](#normativereferences)  
3. [xml:base Attribute](@xml:baseattribute)  
4. [Primitive Types in Atom](#primitivetypesinatom)  
5. [Use of Atom](#useofatom)  
    5.1 .[Namespaces](#namespaces)   
        5.1.1. [Atom Namespace](#atomnamespace)  
        5.1.2. [Atom Publishing Protocol Namespace](@atompublishingprotocolnamespace)  
        5.1.3. [OData Data Namespace](#odatadatanamespace)  
        5.1.4. [OData Metadata Namespace](#odatametadatanamespace)  
6. [Atom Element Definition](#atomelementdefinition)  
    6.1. [Entity Instances](#entityinstances)  
        6.1.1. [The `atom:entry` Element](#theatom:entryelement)  
			6.1.1.1. [The `metadata:etag` Attribute](#themetadata:etagattribute)  
        6.1.2. [The `atom:id` Element](#theatom:idelement)  
        6.1.3. [Self and Edit Links as `atom:link` Elements](#selfandeditlinksasatom:linkelements)  
        6.1.4. [Stream Properties as `atom:link` Elements](#streampropertiesasatom:linkelements)  
            6.1.4.1. [The `rel` attribute of a Link Representing a Stream Property](#therelattributeofalinkrepresentingastreamproperty)  
            6.1.4.2. [The `href` attribute of a Link Representing a Stream Property](#thehrefattributeofalinkrepresentingastreamproperty)  
            6.1.4.3. [The `title` attribute of a Link Representing a Stream Property](#thetitleattributeofalinkrepresentingastreamproperty)  
        6.1.5. [Relationships as atom:link Elements](#relationshipsasatom:linkelements)  
            6.1.5.1. [The `rel` attribute of an `atom:link` Element Representing a Relationship](#therelattributeofanatom:linkelementrepresentingarelationship)  
            6.1.5.2. [The `href` attribute of an `atom:link` Element Representing a Relationship](#thehrefattributeofanatom:linkelementrepresentingarelationship)  
            6.1.5.3. [The `type` attribute of an `atom:link` Element Representing a Relationship](#thetypeattributeofanatom:linkelementrepresentingarelationship)  
            6.1.5.4. [The `title` attribute of an `atom:link` Element Representing a Relationship](#thetitleattributeofanatom:linkelementrepresentingarelationship)  
        6.1.6. [Inline Content within a `metadata:inline` Element](#inlinecontentwithinametadata:inlineelement)  
        6.1.7. [Relationship Links as `atom:link` Elements](#relationshiplinksasatom:linkelements)  
            6.1.7.1. [The `rel` attribute of an `atom:link` Element Representing Relationship Links](#therelattributeofanatom:linkelementrepresentingrelationshiplinks)  
            6.1.7.2. [The `href` attribute of an `atom:link` Element Representing Relationship Links](#thehrefattributeofanatom:linkelementrepresentingrelationshiplinks)  
            6.1.7.3. [The `type` attribute of an `atom:link` Element Representing Relationship Links](#thetypeattributeofanatom:linkelementrepresentingrelationshiplinks)  
            6.1.7.4. [The `title` attribute of an `atom:link` Element Representing Relationship Links](#thetitleattributeofanatom:linkelementrepresentingrelationshiplinks)  
        6.1.8. [Entity Type as an `atom:category` Element](#entitytypeasanatom:categoryelement)  
        6.1.9. [Entity Content within an `atom:content` Element](#entitycontentwithinanatom:contentelement)  
            6.1.9.1. [Media Entities As Media Link Entries using the `src` Attribute](#mediaentitiesasmedialinkentriesusingthesrcattribute)  
        6.1.10. [`atom:link` element for Updating Media Link Entries](#atom:linkelementforupdatingmedialinkentries)  
            6.1.10.1. [The `rel` attribute for writing to Media Link Entries](#therelattributeforwritingtomedialinkentries)  
            6.1.10.2. [The `href` attribute for writing to Media Link Entries](#thehrefattributeforwritingtomedialinkentries)  
        6.1.11. [Entity Properties within a `metadata:properties` Element](#entitypropertieswithinametadata:propertieselement)  
            6.1.11.1. [Entity Property as a `data:[propertyName]` Element](#entitypropertyasadata:[propertyname]element)  
                6.1.11.1.1. [Simple Typed Properties](#simpletypedproperties)  
                6.1.11.1.2. [Complex Typed Properties](#complextypedproperties)  
                6.1.11.1.3. [Collection of Simple Typed Properties](#collectionofsimpletypedproperties)  
                6.1.11.1.4. [Collection of Complex Typed Properties](#collectionofcomplextypedproperties)  
        6.1.12. [Nulls represented using the `metadata:null` Attribute](#nullsrepresentedusingthemetadata:nullattribute)  
        6.1.13. [Data Type represented using the `metadata:type` Attribute](#datatyperepresentedusingthemetadata:typeattribute)  
    6.2. [Collections of Entities](#collectionsofentities)  
        6.2.1. [Collection of Entities as an `atom:feed` Element](#collectionofentitiesasanatom:feedelement)  
        6.2.2. [The `atom:id` Element within an `atom:feed`](#theatom:idelementwithinanatom:feed)  
        6.2.3. [Count as a `metadata:count` Element](#countasametadata:countelement)  
        6.2.4. [Self Links as `atom:link` Elements](#selflinksasatom:linkelements)  
        6.2.5. [Additional Results as an `atom:link` element](#additionalresultsasanatom:linkelement)  
7. [Actions](#actions)  
    7.1. [Actions as a metadata:action Element](#actionsasametadata:actionelement)  
        7.1.1. [The `metadata:metadata` Attribute for an Action](#themetadata:metadataattributeforanaction)  
        7.1.2. [The `metadata:target` Attribute for an Action](#themetadata:targetattributeforanaction)  
        7.1.3. [The `metadata:title` Attribute for an Action](#themetadata:titleattributeforanaction)  
8. [Functions](#functions)  
    8.1. [Functions as a `metadata:function` Element](#functionsasametadata:functionelement)  
        8.1.1. [The `metadata:metadata` Attribute for a Function](#themetadata:metadataattributeforafunction)  
        8.1.2. [The `metadata:target` Attribute for a Function](#themetadata:targetattributeforafunction)  
        8.1.3. [The `metadata:title` Attribute for a Function](#themetadata:titleattributeforafunction)  
9. [Annotations](#annotations)  
    9.1. [ValueAnnotations as custom Elements](#valueannotationsascustomelements)  
        9.1.1. [The `metadata:target` attribute](#themetadata:targetattribute)  
        9.1.2. [The `metadata:type` attribute](#themetadata:typeattribute)  
    9.2. [Type Annotations as Custom Elements](#typeannotationsascustomelements)  
        9.2.1. [The `metadata:target` attribute](#themetadata:targetattribute)  
10. [Custom Mapping to Atom Elements](#custommappingtoatomelements)  
11. [Individual Primitive or Complex Scalar Values](#individualprimitiveorcomplexscalarvalues)  
12. [Collections of Primitive or Complex Scalar Values](#collectionsofprimitiveorcomplexscalarvalues)  
13. [Entity Container as a Workspace within a Service Document](#entitycontainerasaworkspacewithinaservicedocument)  
    13.1. [The `app:service` element](#theapp:serviceelement)  
        13.1.1. [Entity Container as an `app:workspace` element](#entitycontainerasanapp:workspaceelement)  
        13.1.2. [Entity Sets as an `app:collection` element](#entitysetsasanapp:collectionelement)  
        13.1.3. [Entity Set Name as an `atom:title` element](#entitysetnameasanatom:titleelement)  
14. [Links](#links)  
    14.1 [Collection of Links as a `data:links` Element](#collectionoflinksasadata:linkselement)  
    14.2 [Link as a `data:uri` Element](#linkasadata:urielement)  
15. [Errors as XML](#errorsasxml)  
	15.1. [The `metadata:error` Element](#themetadata:errorelement)  
	15.2. [The `metadata:code` Element](#themetadata:coreelement)  
	15.3. [The `metadata:message` Element](#themetadata:messageelement)  
        15.3.1. [The `xml:lang` Attribute](#thexml:langattribute)  
	15.4 [The `metadata:innererror` Element](#themetadata:innererrorelement) 
16. [Extensibility](#extensibility)  

# 1. Overview #

The OData protocol is comprised of a set of specifications for representing and interacting with structured content. This document describes the OData Atom Format returned from an OData Service when requesting the `application/atom+xml` mime type.

An OData payload may represent:

* a single primitive value  
* a sequence of primitive values  
* a single structured ("complex") value  
* a sequence of structured ("complex") values  
* an entity (a structured type with an identity)  
* a sequence of entities  
* a media resource  
* a single instance of a mime type  
* a single link to a related entity
* a collection of links to related entities
* a service document describing the collections (entity sets) exposed by the service  
* an xml document describing the entity model exposed by the service  
* an error  
* a batch of requests to be executed in a single request  
* a set of responses returned from a batch request  

For a description of the xml format for describing an entity model, see [OData:CSDL][].
For a description of batch requests and responses, see [OData:Batch][].

# 2. Notational Conventions #

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC2119], "Key words for use in RFCs to Indicate Requirement Levels")].

## 2.1. Normative References ##

This document references the following related documents:

- [OData:Core][]. Core OData semantics and concepts.
- [OData:CSDL][]. Detailed description of the OData Entity Data Model.
- [OData:URL][]. Conventions for constructing OData requests.
- [OData:ABNF][] Full ABNF rules for OData requests.
- [OData:JSON][] A JSON encoding for OData payloads. OData services SHOULD support a JSON encoding.
- [OData:Batch][] Support for grouping multiple OData requests in a single batch.
- [RFC2616][] HTTP 1.1 Specification
- [RFC5023][] The Atom Publishing Protocol
- [RFC2119][] Keywords for use in RFCs to Indicate Requirement Levels
- [RFC4287][] The Atom Syndication Format.
- [RFC3987][] Internationalized Resource Identifiers (IRIs)

[OData:Core]: /OData.html
[OData:CSDL]: /OData%20CSDL%20Definition.html
[OData:URL]: /OData%20URL%20Conventions.html
[OData:ABNF]: /OData%20ABNF.html
[OData:JSON]: /OData%20JSON%20Verbose%20Format.html
[OData:BATCH]: /OData%20Batch%20Processing%20Format.html
[RFC2616]: http://www.w3.org/Protocols/rfc2616/rfc2616.html
[RFC5023]: http://tools.ietf.org/html/rfc5023
[RFC2119]: http://tools.ietf.org/html/rfc2119
[RFC4287]: http://www.ietf.org/rfc/rfc4287
[RFC3987]: http://www.ietf.org/rfc/rfc3987

# 3. xml:base Attribute #

OData payloads may use the `xml:base` attribute to define a base URI for relative references defined within the scope of the element containing the `xml:base` attribute.

# 4. Primitive Types in Atom #

OData Atom and XML payloads serialize primitive types as shown in the table below.

For full syntax rules, see [OData:ABNF][]:  

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

The Atom Syndication Format [RFC4287][] defines an XML-based format for describing collections ("feeds") made up of individual "entries". The Atom Publishing Protocol [RFC5023][] defines an application-level protocol based on HTTP transfer of Atom-formatted representations.

OData builds on [RFC4287][] and [RFC5023][] by defining additional conventions and extensions for representing and querying entity data.

## 5.1. Namespaces 

OData defines meaning for elements and attributes defined in the following namespaces.

### 5.1.1. Atom Namespace 

Atom elements and attributes are defined within the Atom namespace: "http://www.w3.org/2005/Atom".

In this specification the namespace prefix "atom" is used to represent the Atom Namespace, however the prefix name is not prescriptive.

### 5.1.2. Atom Publishing Protocol Namespace 
Atom Publishing Protocol (AtomPub) elements and attributes are defined within the AtomPub namespace: "http://www.w3.org/2007/app".

In this specification the namespace prefix "app" is used to represent the AtomPub Namespace, however the prefix name is not prescriptive.

### 5.1.3. OData Data Namespace 

Elements that describe the actual data values for an entity are qualified with the OData Data Namespace: "http://schemas.microsoft.com/ado/2007/08/dataservices"

In this specification the namespace prefix "data" is used to represent the OData Data Namespace, however the prefix name is not prescriptive.

### 5.1.4. OData Metadata Namespace

Attributes and elements that represent metadata (such as type, null usage, and entry-level etags) are defined within the OData Metadata Namespace: "http://schemas.microsoft.com/ado/2007/08/dataservices/metadata". Custom elements or attributes MUST NOT use this namespace.

In this specification the namespace prefix "metadata" is used to represent the OData Metadata Namespace, however the prefix name is not prescriptive.

# 6. Atom Element Definition #

OData's Atom format defines extensions and conventions on top of [RFC4287][] and [RFC5023][] for representing structured data as follows:

## 6.1.	Entity Instances ##

Entity Instances, whether individual or within an ATOM feed, are represented as [`atom:entry`](#entitiesasatom:entryelements) elements. 

For example, the following `atom:entry` element describes a Product:
 
	<entry>
	  <id>http://services.odata.org/OData/OData.svc/Products(0)</id> 
	  <title /> 
	  <summary /> 
	  <updated>2012-03-30T07:11:05Z</updated> 
	  <author>
	    <name /> 
	  </author>
	  <link rel="edit" title="Product" href="Products(0)" /> 
	  <link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/Category" type="application/atom+xml;type=entry" title="Category" href="Products(0)/Category" /> 
	  <link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/Supplier" type="application/atom+xml;type=entry" title="Supplier" href="Products(0)/Supplier" /> 
	  <category term="ODataDemo.Product" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /> 
	  <content type="application/xml">
	    <metadata:properties>
	      <data:ID m:type="Edm.Int32">0</data:ID> 
          <data:Name>Bread</data:Name>
          <data:Description>Whole grain bread</data:Description>
	      <data:ReleaseDate metadata:type="Edm.DateTime">1992-01-01T00:00:00</data:ReleaseDate> 
	      <data:DiscontinuedDate metadata:type="Edm.DateTime" metadata:null="true" /> 
	      <data:Rating metadata:type="Edm.Int32">4</data:Rating> 
	      <data:Price metadata:type="Edm.Decimal">2.5</data:Price> 
	    </metadata:properties>
	  </content>
	</entry>

This section defines the elements and attributes within an `atom:entry` element that are assigned meaning in OData.

### 6.1.1.	Entities as `atom:entry` Elements ###

An `atom:entry` element is used to represent a single entity, which is an instance of a structured type with an identity.

#### 6.1.1.1. The `metadata:etag` Attribute ####

The `atom:entry` element MAY contain a `metadata:etag` attribute, representing an opaque string value that can be used in a subsequent request to determine if the value of the entity has changed.  For details on how ETags are used, see to [OData:Core][].

### 6.1.2.	The `atom:id` Element ###

The `atom:id` element defines a durable, opaque, globally unique identifier for the entry. Its content must be an IRI as defined in [RFC3987][]. The consumer of the feed must not assume this IRI can be de-referenced, nor assume any semantics from its structure.

### 6.1.3.	Self and Edit Links as `atom:link` Elements ###

Atom defines two types of links within an entry that represent retrieve or update/delete operations on the entry. 

`atom:link` elements with a rel attribute of `"self"` can be used to retrieve the entity (via the URL specified in the `href` attribute). 

`atom:link` elements with a rel attribute of `"edit"` can be used to retrieve, update, or delete the entity (via the URL specified in the `href` attribute).

An `atom:entry` element representing an OData entity SHOULD contain a self link, an edit link, or both for a particular entry, but MUST NOT contain more than one edit link for a given entry.  Absence of an edit link implies that the entry is read-only.

### 6.1.4. Stream Properties as `atom:link` Elements ###

An entity may have one or more stream properties (for example, a photo property of an employee entity). Properties that represent streams have a type of "Edm.Stream".

OData uses `atom:link` elements to represent named stream properties of an entity.

For example, a stream property named "Photo" could be represented through an `atom:link` element as a child of the [`atom:entry`](#theatom:entryelement) element as follows:

	<atom:link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/mediaresource/Photo" 
	type="img/jpg" title="Photo" href="Categories(0)/Photo"/>

A stream property named "Photo" could be edited through an `atom:link` element as a child of the [`atom:entry`](#theatom:entryelement) element as follows:

	<atom:link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/edit-media/Photo" 
	type="img/jpg" title="Photo" href="Categories(0)/Photo"/>

#### 6.1.4.1. The `rel` attribute of a Link Representing a Stream Property ####

The `rel` attribute for an [`atom:link`](#streampropertiesasatom:linkelements) element that can be used to retrieve a stream property is made up of the name of the [OData Data Namespace](#odatadatanamespace), followed by the string "/mediaresource/", followed by the name of the stream property on the entity.  

The `rel` attribute for an [`atom:link`](#streampropertiesasatom:linkelements) element that can be used to write a stream property is made up of the name of the [OData Data Namespace](#odatadatanamespace), followed by the string "/edit-media/", followed by the name of the stream property on the entity.

In both cases the full name must be used; the use of relative URLs in the rel attribute is not allowed.

#### 6.1.4.2. The `href` attribute of a Link Representing a Stream Property ####

The `href` attribute of an [`atom:link`](#streampropertiesasatom:linkelements) element describing an OData stream property contains the URL that can be used to read, or write, the stream, according to the [`rel`](#therelattributeofalinkrepresentingastreamproperty) attribute. This URL may be relative or absolute.

#### 6.1.4.3. The `title` attribute of a Link Representing a Stream Property ####

The `title` attribute on an [`atom:link`](#streampropertiesasatom:linkelements) element describing an OData relationship provides human-readable, possibly language-dependent, and not necessarily unique information about the link. It has no implied semantics in OData.

### 6.1.5.	Relationships as `atom:link` Elements ###

OData uses `atom:link` elements to represent relationships between entities.

For example, the set of related products for a particular catagory may be represented through an `atom:link` element as a child of a category `entry` element as follows:

	<atom:link 
		rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/Products" 
		href="Categories(0)/Products"
		type="application/atom+xml;type=feed" 
		title="Products" />

The related data for the relationship MAY be included in the Entity using a single child [`metadata:inline`](#inlinecontentwithinametadata:inlineelement) element.
	
#### 6.1.5.1. The `rel` attribute of an `atom:link` element Representing a Relationship ####

The `rel` attribute for an `atom:link` element that represents a relationship MUST be present and is made up of the name of the [OData Data Namespace](#odatadatanamespace), followed by the string "`/related/`" followed by the name of the navigation property on the entity.  

Note that the full name must be used; the use of relative URLs in the rel attribute is not allowed.

#### 6.1.5.2. The `href` attribute of an `atom:link` element Representing a Relationship ####

The `href` attribute of an `atom:link` element describing an OData relationship MUST be present and specifies the URL that can be used to retrieve the related entities. This URL may be relative or absolute.

#### 6.1.5.3. The `type` attribute of an `atom:link` element Representing a Relationship ####

The `type` attribute on an `atom:link` element describing an OData relationship MUST be present and determines whether the cardinality of the related end is:  

* a single entity, in which case the `type`="application/atom+xml;type=entry", or   
* a collection of entities, in which case the `type`="application/atom+xml;type=feed"  

#### 6.1.5.4. The `title` attribute of an `atom:link` element Representing a Relationship ####

The `title` attribute on an `atom:link` element describing an OData relationship SHOULD be present and equal to the name of the navigation property, and provides human-readable, possibly language-dependent, and not necessarily unique information about the link.

### 6.1.6.	Inline Content within a `metadata:inline` Element ###

An [`atom:link`](#relationshipsasatom:linkelements) element describing an OData relationship MAY contain a single `metadata:inline` element, in which case the element contains the feed (in the case of a collection) or entry (in the case of a single entity), where the feed or entry is a child of the `metadata:inline` element formatted as per this document.  

An empty `metadata:inline` element means that there is no content associated with the relationship (i.e., the navigation property is null). Note that this case is distinct from the absence of a `metadata:inline` element which simply means that the contents of the relationship is deferred (not included in the payload). 

It is valid to include the `metadata:inline` element in only a subset of the entries within a feed.

### 6.1.7.	Relationship Links as `atom:link` Elements ###

OData uses `atom:link` elements to represent the collection of relationship [link(s)](#links) between entities.

For example, the set of [links](#links) between a category and related products may be represented through an `atom:link` element as a child of a category entry element as follows:  

	<atom:link 
	  rel="http://schemas.microsoft.com/ado/2007/08/dataservices/relatedlinks/Products" 
	  href="Categories(0)/$links/Products"
	  type="application/xml"
	  title="Products" />
	
#### 6.1.7.1. The `rel` attribute of an `atom:link` element Representing Relationship Links ####

The `rel` attribute for an `atom:link` element that represents a collection of relationship links MUST be present and is made up of the name of the [OData Data Namespace](#odatadatanamespace), followed by the string `"/relatedlinks/"` followed by the name of the navigation property on the entity.  

Note that the full name must be used; the use of relative URLs in the rel attribute is not allowed.

#### 6.1.7.2 The `href` attribute of an `atom:link` element Representing Relationship Links####

The `href` attribute of an `atom:link` element describing a relationship link MUST be present and specifies the URL that represents the collection of relationship links.  This URL may be relative or absolute.  

#### 6.1.7.3. The `type` attribute of an `atom:link` element Representing Relationship Links ####

The `type` attribute on an `atom:link` element describing a relationship link MUST be present and equal to the content type "application/xml"

#### 6.1.7.4. The `title` attribute of an `atom:link` element Representing Relationship Links ####

The `title` attribute on an `atom:link` element describing a relationship link SHOULD be present and SHOULD be set to the name of the navigation property. The `title` attribute provides human-readable, possibly language-dependent, and not necessarily unique information about the link.

### 6.1.8.	Entity Type as an `atom:category` Element ###

An OData entry MAY contain a single `atom:category` element with a scheme attribute equal to `"http://schemas.microsoft.com/ado/2007/08/dataservices/scheme"` to identify the entity type of the entry. This element MUST be present if the entry represents an entity whose type is part of a type hierarchy.

An `atom:category` element describing an OData entity type MUST have a `term` attribute whose value is the namespace qualified name of the entity type of the entry.

The entry MAY contain additional `atom:category` elements with different scheme values; such `atom:category` elements have no semantic meaning in OData.

### 6.1.9.	Entity Content within an `atom:content` Element ###

The `atom:content` element defines the content of the entry.

#### 6.1.9.1. Media Entities As Media Link Entries using the `src` Attribute ####

The `atom:content` element MAY contain a `src` attribute, in which case the entry is a Media Link Entry, used to represent a Media Resource (for example, a photo). The value of the `src` attribute MUST be a URI that can be used to retrieve the content of the Media Resource.

For Media Entities, the `atom:content` element MUST be empty. In this case, properties of the Media Resource (other than the stream) are represented by the [`metadata:properties`](#entitypropertieswithinametadata:propertieselement) element  as a sibling to, rather than a child of, the `atom:content` element. 

### 6.1.10. `atom:link` element for Updating Media Link Entries ###

A [Media Link Entry](#mediaentitiesasmedialinkentriesusingthesrcattribute) MAY contain an `atom:link` element with a `rel` attribute of `"edit-media"` to specify a URL that can be used to write to the BLOB associated with the entity.

#### 6.1.10.1. The `rel` attribute for writing to Media Link Entries ####

Within an `atom:entry` representing a Media Link Entry, an `atom:link` element with a `rel` attribute of "edit-media" is used to identify a link that can be used to write to the BLOB associated with the entry.

#### 6.1.10.2. The `href` attribute for writing to Media Link Entries ####

An atom:link element representing the link used to write to the BLOB associated with the entity MUST include an `href` attribute to specify the URI that can be used to write the stream. This URI may be relative or absolute. 

### 6.1.11.	Entity Properties within a `metadata:properties` Element ###

The `metadata:properties` element represents a subset of the property values for an entity that are not exclusively mapped to defined or custom elements, as described in [Custom Mapping to Atom Elements](#custommappingtoatomelements). 

The `metadata:properties` element MUST be a direct child of the `atom:content` element EXCEPT for the case where the entry represents a [media entity](#mediaentitiesasmedialinkentriesusingthesrcattribute), in which case the `metadata:properties` element MUST be a sibling of the `atom:content` element.  In the case that all properties of the entity are exclusively mapped to defined or custom elements, an empty `metadata:properties` element MAY be present.

#### 6.1.11.1. Entity Property as a `data:[propertyName]` Element ####

Within the `metadata:properties` element, individual data values of the entity are represented as elements where the name of the element is the name of the entity property within the [OData Data Namespace](#odatadatanamespace).

The `data:[PropertyName]` element MAY include a [`metadata:type`](#datatyperepresentedusingthemetadata:typeattribute) attribute to specify the type of the simple- or complex-typed instance.

For example, the following element within an metadata:properties element represents the "Rating" field with an integer value of 4:  

	<data:Rating m:type="Edm.Int32">4</data:Rating> 

##### 6.1.11.1.1. Simple Typed Properties #####

For simple typed properties, the content of the `data:[propertyName]` element represents the value of the property.  For example, the following would represent the value "CEO" for the Title property of an entity:  

	<data:Title>CEO</data:Title>

##### 6.1.11.1.2. Complex Typed Properties ######

For complex typed properties, the content of the `data:[propertyName]` element consists of nested `data:[propertyName]` elements describing the properties of the complex type. It MAY include a `metadata:type` attribute to specify the type.   

For example, the complex typed property "Name", with properties "FirstName" and "LastName" would be respresented as:

	<data:Name metadata:type="MyModel.FullName">  
	    <data:FirstName>Julie</data:FirstName>  
	    <data:LastName>Swansworth</data:LastName>  
	</data:Name>
	
##### 6.1.11.1.3. Collection of Simple Typed Properties #####

For properties that represent a collection of simple types, the `data:[propertyName]` element may include a `metadata:type` attribute with a value of `"Collection([SimpleTypeName])"`. The content of the element consists of nested child elements named "`element`", in the [OData Data Namespace](#odatadatanamespace), for each value in the collection. 

The value of each simple-typed data:element in the collection follows the syntax for the simple typed property as defined for [simple-typed properties](#simpletypedproperties.

`<data:element>` elements MUST NOT contain the `metadata:null="true"` attribute value.

For example, the collection typed property "Emails" would be respresented as:

	<data:Emails metadata:type="Collection(Edm.String)">  
	    <data:element>Julie@Swansworth.com</data:element>  
	    <data:element>Julie.Swansworth@work.com</data:element>  
	</data:Emails>
	
##### 6.1.11.1.4.	Collection of Complex Typed Properties #####

For properties that represent a collection of complex types, the `data:[propertyName]` element may include a `metdata:type` attribute with a value of `"Collection([ComplexTypeName])`" attribute. The content of the element consists of nested child elements named "`element`", in the [OData Data Namespace](#odatadatanamespace) namespace, for each complex typed value in the collection. 

The `<data:element>` element representing the instance may include a `metadata:type` attribute to specify the type of the individual element. The value of each complex-typed `<data:element>` follows the syntax for [complex-typed properties](#complextypedproperties).

`<data:element>` elements MUST NOT be empty and MUST NOT contain the `metadata:null="true"` attribute.

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

### 6.1.12. Nulls represented using the metadata:null Attribute ###

Null valued properties are represented as empty elements with the `metadata:null="true"` attribute. 

The `metadata:null` attribute distinguishes null values from other empty content (such as an empty string).  

For example, the following represents an empty apartment number:

	<data:Apartment metadata:null="true"/>

The absence of the metadata:null attribute is equivalent to specifying `metadata:null="false"`.

### 6.1.13. Data Type represented using the metadata:type Attribute ###

Primitive-valued properties and Complex-valued properties that are not part of a hierarchy MAY contain a metadata:type to specify the primitive type of the property. 

Complex-valued properties that are part of a hierarchy MUST contain a metadata:type attribute. 

For Complex-valued properties, the value of the attribute is the namespace-qualified name of the complex type.

For example, the following specifies that the Age property is a 32bit integer with the value 25:

	<data:Age metadata:type="Edm.Int32">25</data:Age>

## 6.2.	Collections of Entities

Collections of entities are represented in Atom as an Atom Feed.

### 6.2.1 Collection of Entities as an atom:feed Element ##

Collections of entities are represented using an `atom:feed` Element, where each entity is represented as an [`atom:entry`](#EntityInstances).

### 6.2.2.	The `atom:id` Element within an `atom:feed` ###

The `atom:id` element defines a durable, opaque, globally unique identifier for the feed. Its content must be an IRI as defined in [RFC3987][]. The consumer of the feed must not assume this IRI can be de-referenced, nor assume any semantics from its structure.

### 6.2.3.	Count as a `metadata:count` Element ###

The `atom:feed` element may contain an `m:count` element to specify the total count of rows in the result. This may be greater than the number of rows in the feed if server side paging has been applied, in which case the feed will include a [next results](#additionalresultsasanatom:linkelement) link.

### 6.2.4.	Self Links as `atom:link` Elements ###

Atom requires that feeds contain a "self link".  A self link is represented as an `atom:link` with a `rel` attribute of "self" and an `href` that can be used to retrieve the feed from which the current entries are taken.  

Note that the actual set of entries contained within the atom:feed may be a subset of those retrieved using the self link, for example, if filtering has been applied.

### 6.2.5.	Additional Results as an `atom:link` element ###

The `atom:feed` element may contain a "next link" to indicate the presence of additional entries that belong to the feed.  Such a link is represented as an `atom:link` with a `rel` attribute of `"next"` and an `href` attribute containing a URL that can be used to retrieve the next set of results.  

For example, the following `atom:link` element within an `atom:feed` element indicates that additional results can be returned by following the specified `href`:  

	<atom:link rel="next" href="http://myservice/customers/?$skiptoken=1237"/>

The contents of the `href` should be treated as an opaque URL that can be used to fetch the next set of results.

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

### 7.1.1. The `metadata:metadata` Attribute for an Action ###

A [`metadata:action`](actionsasametadata:actionelement) element MUST have a `metadata:metadata` attribute which specifies the container qualified name of the function import describing the action, preceded by a "#". For example, "#MyEntityContainer.MyFunctionName". 

This function import name must be unique within the entity container. 

If the metadata cannot be retrieved by appending `"$metadata"` to the service root, then this name MUST additionally be prefixed by a URL that can be used to retrieve the metadata document containing the function import that describes the action.

### 7.1.2. The `metadata:target` Attribute for an Action ###

A `metadata:action` element MUST have a `metadata:target` attribute that specifies the URL to POST to in order to invoke the action. 

The first parameter of the action MUST be a binding parameter that is bound to the feed or entity on which the action is specified, and MUST NOT be provided as a separate parameter by the client when invoking the action.

### 7.1.3. The `metadata:title` Attribute for an Action ###

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

Functions are represented as `metadata:function` elements that appear as direct children of the `atom:feed` or `atom:entry` element representing the collection or entity on which the function(s) exist.

### 8.1.1. The `metadata:metadata` Attribute for a Function ###

A `metadata:function` element MUST have a `metadata:metadata` attribute which specifies the container qualified name of the function import describing the function, preceded by a "#". For example, "#MyEntityContainer.MyFunctionName".

The named function may have multiple overloads (multiple function imports) within the container. If the `metadata:function` cannot be used to invoke all overloads for the function, then it must further be distinguished by appending a comma separated ordered list of parameter type names, enclosed in parenthesis (). For example, "#MyEntityContainer.MyFunctionName(Edm.Integer, Edm.String)".

If the metadata cannot be retrieved by appending `"$metadata"` to the service root, then this name MUST additionally be prefixed by a URL that can be used to retrieve the metadata document containing the function import that describes the function.

### 8.1.2. The `metadata:target` Attribute for a Function ###

A `metadata:function` element MUST have a `metadata:target` element that specifies the URL to GET from in order to invoke the function. 

The first parameter of the function MUST be a binding parameter that is bound to the feed or entity on which the function is specified, and MUST NOT be provided as a separate parameter by the client when invoking the function.

### 8.1.3. The `metadata:title` Attribute for a Function ###

The `metadata:function` element MUST have a `metadata:title` attribute that contains a human-readable, possibly language-dependent, and not necessarily unique name for the function, commonly used by clients to describe the function to a user.

# 9. Annotations #

In OData version 3.0, annotations may be appear as a child to any of the following elements:
`<atom:feed>`, `<atom:entry>`, `<metadata:properties>`, `<metadata:function>`, `<metadata:action>`, `<metadata:error>`, or `<atom:link>` where `rel` indicates a navigation link or named stream. 

There are two types of annotation terms in OData; ValueTerms and TypeTerms.

A ValueTerm defines a named annotation for a single primitive value. A ValueAnnotation specifies the value for a ValueTerm.

A TypeTerm defines a named annotation for a complex or entity typed value. A TypeAnnotation specifies the values for each property defined by the TypeTerm.

Custom ValueTerms and Custom TypeTerms MUST be defined in a namespace other than the [Atom Namespace](#atomnamespace), [AtomPub Namespace](#atompublishingprotocolnamespace), [OData Data Namespace](#odatadatanamespace), or [OData Metadata Namespace](#odatametadatanamespace). Annotations corresponding to custom terms add additional information about the item being annotated and SHOULD be designed in such a way that they can be safely ignored by the client.

TypeAnnotations and ValueAnnotations specify a target, which represents the collection, entry, property, function, action, navigation link, error, or named stream being annotated. The target is specified relative to the parent of the ValueAnnotation or TypeAnnotation, and is either the parent itself (".") or the name of the sibling element being annotated. 

If more than one sibling exists with the same unqualifed name, then the namespace qualified element named MUST be used.

## 9.1. ValueAnnotations as custom Elements ##

A ValueAnnotation is specified by a single element containing the `metadata:target` attribute, whose element name is the namespace-qualified ValueTerm.

The content of the ValueAnnotation element is the value of the ValueTerm, formatted as per [Primitive Types In Atom](#primitivetypesinatom).

For example; the following specifies a value of "Home" for the "PhoneNumberType" ValueTerm applied to the "PhoneNumber" property of a customer:

      <metadata:properties  xmlns:contact="http://odata.org/vocabularies/contact/v1">
        <data:CustomerID>ALFKI</data:CustomerID>
        <data:ContactName> Alfreds Futterkiste </data:ContactName>
        <data:Phone>030-0074321</data:Phone>
		<contact:PhoneNumberType metadata:target="Phone">Home</contact:PhoneNumberType>
      </metadata:properties>

### 9.1.1. The `metadata:target` attribute

The `metadata:target` attribute MUST be present on a ValueAnnotation and identifies the target of the annotation as described in [Annotations](#annotations).

### 9.1.2. The `metadata:type` attribute

If the type of the annotation value being specified is `Edm.String`, then the ValueAnnotation element MAY contain the `metadata:type` attribute specifying "Edm.String", otherwise the ValueAnnotation element MUST contain the `metadata:type` attribute specifying the appropriate primitive type.

## 9.2. Type Annotations as Custom Elements##

A TypeAnnotation is specified by an element containing the `metadata:target` attribute, whose element name is the namespace-qualified TypeTerm.

The TypeAnnotation element contains a single child element for each property of the TypeTerm being specified. The name of each such child element is the namespace-qualified name of the property, and its content specifies the value of the corresponding property of the TypeTerm, formatted as per [Primitive Types In Atom](#primitivetypesinatom). If the type of the annotation property is `Edm.String`, then the child element MAY contain the `metadata:type` attribute specifying "Edm.String", otherwise  the child element MUST contain the `metadata:type` attribute specifying the appropriate primitive type. 

For example; the following specifies the "StreetAddress", "City", "Region", "Country" and "Postal Code" properties of an "Address" TypeTerm applied to a customer entity:

      <metadata:properties xmlns:contact="http://odata.org/vocabularies/contact/v1">
        <data:CustomerID>ALFKI</data:CustomerID>
        <data:ContactName> Alfreds Futterkiste </data:ContactName>
        <data:Phone>030-0074321</data:Phone>
        <contact:Address metadata:target=".">  
          <contact:StreetAddress>Obere Str. 578</contact:StreetAddress>
          <contact:City>Toronto</contact:City>
          <contact:Region metadata:null="true" />
          <contact:PostalCode>12209</contact:PostalCode>
          <contact:Country>Germany</contact:Country>
        </contact:Address>
      </metadata:properties>

### 9.2.1. The `metadata:target` attribute

The `metadata:target` attribute MUST be present on a TypeAnnotation and identifies the target of the annotation as described in [Annotations](#annotations).

# 10. Custom Mapping to Atom Elements #

Individual property values MAY be mapped to predefined atom elements or custom content within the entry.  The mapping is described through attributes in the metadata.

The mapping may specify whether the property value appears within the `metadata:properties` element as well as being mapped, however in the case of a null value the property MUST always appear within the `metadata:properties` element as an empty element with the [`metadata:null="true"` attribute](#nullsrepresentedusingthemetadata:nullattribute). 

For more information on the format of the mapping specification, see [OData:CSDL][].

# 11. Individual Primitive or Complex Scalar Values #

A valid OData payload may consist of a single [primitive](#simpletypedproperties) or [complex property](#complextypedproperties).  

For example, a request for the first name of a given customer may return the following payload:

	   <Title xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">CEO<Title> 

Similarly, the following payload represents a full name:

	<FullName metadata:type="HumanResources.Address"
	      xmlns:metadata="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata"
	      xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">
	   <FirstName>Julie</FirstName>
	   <LastName>Swansworth</LastName>
	</FullName>
	
# 12. Collections of Primitive or Complex Scalar Values #

A valid OData payload MAY consist of a collection of primitive or complex properties. A collection is a single root element containing zero or more <metadata:element> elements whose content is an individual [primitive](#simpletypedproperties) or [complex](#complextypedproperties) property as defined above.

For example, the following payload represents a collection of phone numbers.

	<PhoneNumbers xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices">	 
		<element>(203)555-1718<element>
	    <element>(203)555-1719<element>
	</PhoneNumbers>
		
Similarly, the following payload represents a collection of full names.

	<Names xmlns:metadata="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata"
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

Atom defines the concept of a Service Document to represent the set of available collections. OData uses Service Documents to describe the set of entity sets available through the service.

## 13.1. The `app:service` element ##

The atom ServiceDocument is represented by the `app:service` element.  The `app:service` element contains one or more [`app:workspaces`](#entitycontainerasanapp:workspaceelement), which represents a set of collections.

### 13.1.1.	Entity Container as an `app:workspace` element ###

OData represents entity containers as `app:workspace` elements.  An `app:workspace` element contains zero or more [`app:collections`](#entitysetsasanapp:collectionelement). 

### 13.1.2.	Entity Sets as an `app:collection` element ###

OData describes available collections of entities as `app:collection` elements.

The `app:collection` element MUST contain an `href` attribute which represents a URL that can be used to retrieve the members of the entity set.

### 13.1.3.	Entity Set Name as an `atom:title` element ###

The `atom:title` element within the [`app:collection`](#entitysetsasanapp:collectionelement) SHOULD contain the name of the entity set.

# 14. Links 

Links represent the relationships between an entity and related entity(s). 

The link(s) available from a particular entity for a particular relationship can be retrieved from the service as a colleciton of URIs within a [`data:links`](#collectionoflinksasadata:linkselement) element.

## 14.1. Collection of Links as a `data:links` Element ##

A `data:link` element represents the set of references from one entity to all related entities according to a particular relationship.

The reference for each related entity is represented as a `data:uri` element that appears as a direct child of the `data:links` element.

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
	
## 14.2. Link as a `data:uri` Element ##

Each related entity is represented as a `data:uri` element, which appears as a direct child of a [`data:link`](#collectionoflinksasadata:linkselement) element.

The content of the `data:uri` element is the [Canonical URL](/OData.html#canonicalurl) for the related entity. 

# 15. Errors as XML #

In the case of an error being generated in response to a request specifying an `Accept` header of `application/xml` or `application/atom+xml`, or that does not specify an `Accept` header, the service MUST respond with with an error formatted as XML.

When formatting error responses as XML, servers SHOULD include a `Content-Type` response header with the value `"application/xml"`.

## 15.1 The `metadata:error` Element

Errors formatted as XML have a root `metadata:error` element. The `metadata:error` element MUST have two child elements: [`metadata:code`](#themetadata:codeelement) and [`metadata:message`](#themetadata:messageelement).

In addition, errors may be annotated using custom [annotations](#Annotations)

For example: 

	<error xmlns="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata">
	  <code>BDRQST</code>
	  <message xml:lang="en-US">Bad Request - Error in query syntax.</message>
	</error>
	
##15.2 The `metadata:code` Element

The `metadata:error` element MUST contain a `metadata:code` element specifying a service-defined string. This value MAY be used to provide a more specific substatus to the returned HTTP response code.

##15.3 The `metadata:message` Element

The `metadata:error` element MUST contain a `metadata:message` element specifying a human readable message describing the error.

### 15.3.1. The xml:lang Attribute

The `metadata:message` element MAY contain an `xml:lang` attribute to specify the language of the error message.

##15.4 The `metadata:innererror` Element

The `metadata:error` element MAY contain a `metadata:innererror` element containing service specific debugging information that might assist a service implementer in determining the cause of an error.

The `metadata:innererror` element SHOULD only be used in development environments in order to guard against potential security concerns around information disclosure.

#16. Extensibility #

Implementations MAY add custom content anywhere allowed by [RFC4287][], Section 6, "Extending Atom". However, custom elements and attributes MUST NOT be defined in the [OData Data Namespace](#odatadatanamespace) nor the [OData Metadata Namespace](#odatametadatanamespace), and SHOULD not be required to be understood by the receiving party in order to correctly interpret the rest of the payload.
