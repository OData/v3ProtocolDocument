Title: Common Schema Definition Language (CSDL)
Author: Mark Stafford
Date: 29 March 2012
Keywords: odata, csdl

<!-- TODO: Verify that all links to csdl18 (abnf) are as tight as possible. -->
<!-- TODO: Verify that all primitive types are declared with Edm. prefix. -->
<!-- TODO: Verify that MSFT fwlinks should be replaced. -->
<!-- TODO: Verify all links point to the right place. -->

# Appendix A: Formal Description of Common Schema Definition Language (CSDL)[top]

### Table of Contents[toc]

[Introduction][]  
[1	Common Schema Definition Language (CSDL) Namespaces][csdl1]  
[1.1	Entity Data Model for Data Services Packaging (EDMX) Namespace][csdl1.1]  
[1.2	Entity Data Model (EDM) Namespace][csdl1.2]  
[1.3	Data Service Metadata Namespace][csdl1.3]  
[2	Common Characteristics of Entity Model Elements][csdl2]  
[2.1	Nominal Elements][csdl2.1]  
[2.2	Structured Elements][csdl2.2]  
[2.3	The edm:Documentation Element][csdl2.3]  
[2.4	Vocabulary Annotations][csdl2.4]  
[2.5	Custom Annotations][csdl2.5]  
[2.6	Primitive Types][csdl2.6]  
[3	Entity Model Wrapper Constructs][csdl3]  
[3.1	The edmx:Edmx Element][csdl3.1]  
[3.1.1	The Version Attribute][csdl3.1.1]  
[3.2	The edmx:DataServices Element][csdl3.2]  
[3.2.1	The metadata:DataServiceVersion Attribute][csdl3.2.1]  
[3.3	The edmx:Reference Element][csdl3.3]  
[3.3.1	The edmx:Url Attribute][csdl3.3.1]  
[3.4	The edmx:AnnotationsReference Element][csdl3.4]  
[3.4.1	The edmx:Url Attribute][csdl3.4.1]  
[3.5	The edmx:Include Element][csdl3.5]  
[3.5.1	The edmx:TermNamespace Attribute][csdl3.5.1]  
[3.5.2	The edmx:Qualifier Attribute][csdl3.5.2]  
[4	Schema Constructs][csdl4]  
[4.1	The edm:Schema Element][csdl4.1]  
[4.1.1	The edm:Namespace Attribute][csdl4.1.1]  
[4.1.2	The edm:Alias Attribute][csdl4.1.2]  
[4.2	The edm:Using Element][csdl4.2]  
[4.2.1	The edm:Namespace Attribute][csdl4.2.1]  
[4.2.2	The edm:Alias Attribute][csdl4.2.2]  
[5	Properties][csdl5]  
[5.1	The edm:Property Element][csdl5.1]  
[5.1.1	The edm:Name Attribute][csdl5.1.1]  
[5.2	The edm:Type Attribute][csdl5.2]  
[5.3	Property Facets][csdl5.3]  
[5.3.1	The edm:Nullable Facet][csdl5.3.1]  
[5.3.2	The edm:MaxLength Facet][csdl5.3.2]  
[5.3.3	The edm:FixedLength Facet][csdl5.3.3]  
[5.3.4	The edm:Precision Attribute][csdl5.3.4]  
[5.3.5	The edm:Scale Attribute][csdl5.3.5]  
[5.3.6	The edm:Unicode Attribute][csdl5.3.6]  
[5.3.7	The edm:Collation Attribute][csdl5.3.7]  
[5.3.8	The edm:SRID Attribute][csdl5.3.8]  
[5.3.9	The edm:DefaultValue Facet][csdl5.3.9]  
[5.3.10	The edm:ConcurrencyMode Attribute][csdl5.3.10]  
[6	Entity Type Constructs][csdl6]  
[6.1	The edm:EntityType Element][csdl6.1]  
[6.1.1	The edm:Name Attribute][csdl6.1.1]  
[6.1.2	The edm:BaseType Attribute][csdl6.1.2]  
[6.1.3	The edm:Abstract Attribute][csdl6.1.3]  
[6.1.4	The edm:OpenType Attribute][csdl6.1.4]  
[6.2	The edm:Key Element][csdl6.2]  
[6.3	The edm:PropertyRef Element][csdl6.3]  
[6.4	The edm:NavigationProperty Element][csdl6.4]  
[6.4.1	The edm:Name Attribute][csdl6.4.1]  
[6.4.2	The edm:Relationship Attribute][csdl6.4.2]  
[6.4.3	The edm:ToRole Attribute][csdl6.4.3]  
[6.4.4	The edm:FromRole Attribute][csdl6.4.4]  
[6.4.5	The edm:ContainsTarget Attribute][csdl6.4.5]  
[7	Complex Type Constructs][csdl7]  
[7.1	The edm:ComplexType Element][csdl7.1]  
[8	Enumeration Type Constructs][csdl8]  
[8.1	The edm:EnumType Element][csdl8.1]  
[8.1.1	The edm:UnderlyingType Attribute][csdl8.1.1]  
[8.1.2	The edm:IsFlags Attribute][csdl8.1.2]  
[8.2	The edm:Member Element][csdl8.2]  
[8.2.1	The edm:Name Attribute][csdl8.2.1]  
[8.2.2	The edm:Value Attribute][csdl8.2.2]  
[9	Other Type Constructs][csdl9]  
[9.1	Collection Types][csdl9.1]  
[9.1.1	The edm:CollectionType Element][csdl9.1.1]  
[9.2	The edm:TypeRef Element][csdl9.2]  
[9.3	Reference Types][csdl9.3]  
[9.3.1	The edm:ReferenceType Element][csdl9.3.1]  
[9.4	Row Types][csdl9.4]  
[9.4.1	The edm:RowType Element][csdl9.4.1]  
[10	Association Constructs][csdl10]  
[10.1	The edm:Association Element][csdl10.1]  
[10.2	The edm:End Element][csdl10.2]  
[10.2.1	The edm:Type Attribute][csdl10.2.1]  
[10.2.2	The edm:Role Attribute][csdl10.2.2]  
[10.2.3	The edm:Multiplicity Attribute][csdl10.2.3]  
[10.3	The edm:OnDelete Element][csdl10.3]  
[10.4	The edm:ReferentialConstraint Element][csdl10.4]  
[10.5	The edm:Principal Element][csdl10.5]  
[10.6	The edm:Dependent Element][csdl10.6]  
[10.7	The edm:PropertyRef Element][csdl10.7]  
[11	Model Functions][csdl11]  
[11.1	The edm:Function Element][csdl11.1]  
[11.1.1	The edm:ReturnType Attribute][csdl11.1.1]  
[11.2	The edm:Parameter Element][csdl11.2]  
[11.3	The edm:ReturnType Element][csdl11.3]  
[12	Entity Container Constructs][csdl12]  
[12.1	The edm:EntityContainer Element][csdl12.1]  
[12.2	The edm:EntitySet Element][csdl12.2]  
[12.3	The edm:AssociationSet Element][csdl12.3]  
[12.3.1	The edm:End Element][csdl12.3.1]  
[12.4	The edm:FunctionImport Element][csdl12.4]  
[12.4.1	The edm:ReturnType Attribute][csdl12.4.1]  
[12.4.2	The edm:EntitySet Attribute][csdl12.4.2]  
[12.4.3	The edm:EntitySetPath Attribute][csdl12.4.3]  
[12.4.4	The edm:IsSideEffecting Attribute][csdl12.4.4]  
[12.4.5	The edm:IsBindable Attribute][csdl12.4.5]  
[12.4.6	The edm:IsComposable Attribute][csdl12.4.6]  
[12.5	The edm:ReturnType Element][csdl12.5]  
[12.6	The edm:Parameter Element][csdl12.6]  
[12.6.1	The edm:Type Attribute][csdl12.6.1]  
[12.6.2	The edm:Mode Attribute][csdl12.6.2]  
[12.6.3	Parameter Facets][csdl12.6.3]  
[13	Vocabulary Concepts][csdl13]  
[14	Vocabulary Terms][csdl14]  
[14.1	edm:EntityType and edm:ComplexType Terms][csdl14.1]  
[14.2	The edm:ValueTerm Element][csdl14.2]  
[15	Vocabulary Annotations][csdl15]  
[15.1	The edm:Annotations Element][csdl15.1]  
[15.2	The edm:TypeAnnotation Element][csdl15.2]  
[15.3	The edm:PropertyValue Element][csdl15.3]  
[15.4	The edm:ValueAnnotation Element][csdl15.4]  
[15.5	The edm:Qualifier Attribute][csdl15.5]  
[16	Vocabulary Expressions][csdl16]  
[16.1	Constant Expressions][csdl16.1]  
[16.1.1	The edm:Binary Constant Expression][csdl16.1.1]  
[16.1.2	The edm:Bool Constant Expression][csdl16.1.2]  
[16.1.3	The edm:DateTime Constant Expression][csdl16.1.3]  
[16.1.4	The edm:DateTimeOffset Constant Expression][csdl16.1.4]  
[16.1.5	The edm:Decimal Constant Expression][csdl16.1.5]  
[16.1.6	The edm:Float Constant Expression][csdl16.1.6]  
[16.1.7	The edm:Guid Constant Expression][csdl16.1.7]  
[16.1.8	The edm:Int Constant Expression][csdl16.1.8]  
[16.1.9	The edm:String Constant Expression][csdl16.1.9]  
[16.1.10	The edm:Time Constant Expression][csdl16.1.10]  
[16.2	Dynamic Expressions][csdl16.2]  
[16.2.1	The edm:Apply Expression][csdl16.2.1]  
[16.2.2	The edm:AssertType Expression][csdl16.2.2]  
[16.2.3	The edm:Collection Expression][csdl16.2.3]  
[16.2.4	The edm:EntitySetReference Expression][csdl16.2.4]  
[16.2.5	The edm:EnumMemberReference Expression][csdl16.2.5]  
[16.2.6	The edm:FunctionReference Expression][csdl16.2.6]  
[16.2.7	The edm:If Expression][csdl16.2.7]  
[16.2.8	The edm:IsType Expression][csdl16.2.8]  
[16.2.9	The edm:LabeledElement Expression][csdl16.2.9]  
[16.2.10	The edm:LabeledElementReference Expression][csdl16.2.10]  
[16.2.11	The edm:Null Expression][csdl16.2.11]  
[16.2.12	The edm:ParameterReference Expression][csdl16.2.12]  
[16.2.13	The edm:Path Expression][csdl16.2.13]  
[16.2.14	The edm:PropertyReference Expression][csdl16.2.14]  
[16.2.15	The edm:Record Expression][csdl16.2.15]  
[16.2.16	The edm:ValueTermReference Expression][csdl16.2.16]  
[17	CSDL Examples][csdl17]  
[17.1	Title for example][csdl17.1]  
[17.2	Title for example][csdl17.2]  
[18	Informative XSD for CSDL][csdl18]  
[19	ABNF for CSDL][csdl19]

# Introduction

<!-- TODO: Get the reference links for XML 1.0 and XMLSCHEMA. -->
OData services are described by an Entity Data Model (EDM). Common Schema Definition Language (CSDL) defines an XML-based representation of the entity model exposed by an OData service. CSDL is based on standards defined in <ref>XML 1.0</ref> and <ref>XMLSCHEMA</ref>.

An OData service SHOULD provide a CSDL description of its entity model when a client requests a description of the entity model by sending a `GET` request to `<serviceRoot>/$metadata`. `$metadata` MUST wrap the CSDL document in an EDMX wrapper.

# 1	Common Schema Definition Language (CSDL) Namespaces[csdl1]

In addition to the default XML namespace, the elements and attributes used to describe the entity model of an OData service are defined in one of the following namespaces.

## 1.1	Entity Data Model for Data Services Packaging (EDMX) Namespace[csdl1.1]

Elements and attributes associated with the top-level wrapper that contains the CSDL used to define the entity model for an OData Service are qualified with the Entity Data Model for Data Services Packaging namespace: `http://schemas.microsoft.com/ado/2007/06/edmx`.

In this specification the namespace prefix `edmx` is used to represent the Entity Data Model for Data Services Packaging namespace, however the prefix name is not prescriptive.

## 1.2	Entity Data Model (EDM) Namespace[csdl1.2]

Elements and attributes that define the entity model exposed by the OData Service are qualified with the Entity Data Model namespace: `http://schemas.microsoft.com/ado/2009/11/edm`.

Prior versions of CSDL used the following namespaces for EDM:

- http://schemas.microsoft.com/ado/2006/04/edm
- http://schemas.microsoft.com/ado/2007/05/edm
- http://schemas.microsoft.com/ado/2008/01/edm
- http://schemas.microsoft.com/ado/2008/09/edm
- http://schemas.microsoft.com/ado/2009/11/edm

In this specification the namespace prefix `edm` is used to represent the Entity Data Model namespace, however the prefix name is not prescriptive.


## 1.3	Data Service Metadata Namespace[csdl1.3]

Elements and attributes specific to how the entity model is exposed as an OData Service are qualified with the Data Service Metadata namespace: `http://schemas.microsoft.com/ado/2007/08/DataServices/Metadata`.

In this specification the namespace prefix `metadata` is used to represent the Data Service Metadata namespace, however the prefix name is not prescriptive.

# 2	Common Characteristics of Entity Model Elements[csdl2]

A typical entity model for an OData service contains one or more model elements. Some of these elements share a few common characteristics.

## 2.1	Nominal Elements[csdl2.1]

Model elements can be nominal in nature. A nominal element has a name of the type [`<simpleIdentifier>`][csdl18] that in combination with a [`<namespace>`][csdl18] produces a fully qualified name of the form [`<namespaceQualifiedIdentifier>`][csdl18]. The [`<namespaceQualifiedIdentifier>`][csdl18] MUST be unique as it facilitates references to the element from other parts of the model.

When referring to nominal elements, the reference can use either of the following:

- Fully qualified name
- Alias qualified name

If the nominal element is unambiguous, the reference can simply use the name of the element.

Consider the following example:

	<Schema
	 xmlns=http://schemas.microsoft.com/ado/2006/04/edm
	 xmlns:m=http://schemas.microsoft.com/ado/2007/08/dataservices/metadata
	 xmlns:d=http://schemas.microsoft.com/ado/2007/08/dataservices
	 Namespace="org.odata" Alias="odata">
	 <ComplexType Name="Address">...</ComplexType>
	</Schema>

The various ways of referring to the nominal element are:

- References in any namespace can use the fully qualified name, for example, `org.odata.Address`
- References in any namespace can specify an alias and use an alias qualified name, for example, `odata.Address`
- References in org.odata can simply use the name, for example, `Address`

## 2.2	Structured Elements[csdl2.2]

Structured elements are composed of other model elements. Structured elements are common in entity models as they are the typical means of representing entities in the OData service. [Entity types][csdl6] and [complex types][csdl7] are both structured elements. [Row types][csdl9.4] are less common but are also structured elements.

A [structural property][csdl5] is a property that has one of the following types:

- [Primitive][csdl2.6]
- [Complex type][csdl7]
- [Enumeration type][csdl8]
- A [collection][csdl9.1] of one of the above

## 2.3	The `edm:Documentation` Element[csdl2.3]

The `edm:Documentation` element allows service authors to provide documentation for most model elements.

A model element MUST NOT contain more than one documentation element.

Refer to the [XML schema][csdl19] for details on which model elements support documentation.

A documentation element MUST contain zero or one `edm:Summary` and zero or one `edm:LongDescription` elements. The summary and long description elements MAY contain text that serves as the summary or long description. If both a summary and long description are provided, the summary MUST precede the long description.

For example:

	<EntityType Name="Product"> 
	 <Documentation>
	  <Summary>Product names, suppliers, prices, and units in stock.</Summary>
	  <LongDescription>...</LongDescription>
	 </Documentation>
	 ...
	</EntityType>

## 2.4	Vocabulary Annotations[csdl2.4]

Many model elements can be annotated with additional information with the [`edm:TypeAnnotation`][csdl15.2] and [`edm:ValueAnnotation`][csdl15.4] elements.

A model element MUST NOT specify more than one type annotation or value annotation for a given type term or value term.

Vocabulary annotations may be specified as a child of the model element or as a child of an [`edm:Annotations`][csdl15.1] element that targets the model element.

Refer to the [XML schema][csdl19] for details on which model elements support vocabulary annotations.

## 2.5	Custom Annotations[csdl2.5]

CSDL allows custom annotations to be attached to many model elements. This allows CSDL to be extended with markup to help various runtimes.

For instance, the following custom annotation attributes indicate that the entity container supports lazy loading:

	<EntityContainer Name="ModelContainer" annotation:LazyLoadingEnabled="true">
	 ...
	</EntityContainer> 

In the following example, the entity type has two access control entries specified with custom annotation elements:

	<EntityType Name="Content">
	 ...
	 <RS:Security>
	  <RS:ACE Principal="S-0-123-1321" Rights="+R+W"/>
	  <RS:ACE Principal="S-0-123-2321" Rights="-R-W"/>
	 </RS:Security>
	</EntityType>

Custom annotations can appear in attribute form or element form. Custom annotations MUST NOT use a namespace that is on the list of reserved namespaces for CSDL. This includes the following namespaces:

- http://schemas.microsoft.com/ado/2007/06/edmx
- http://schemas.microsoft.com/ado/2007/08/dataservices/metadata
- http://schemas.microsoft.com/ado/2009/11/edm
- http://schemas.microsoft.com/ado/2008/09/edm
- http://schemas.microsoft.com/ado/2008/01/edm
- http://schemas.microsoft.com/ado/2007/05/edm
- http://schemas.microsoft.com/ado/2006/04/edm

Refer to the [XML schema][csdl19] for details on which elements support custom annotations.

## 2.6	Primitive Types[csdl2.6]

Model elements are composed of other model elements and primitive types. CSDL defines the following fully qualified primitive types:

- `Edm.Binary`
- `Edm.Boolean`
- `Edm.Byte`
- `Edm.DateTime`
- `Edm.Decimal`
- `Edm.Double`
- `Edm.Single`
- `Edm.Guid`
- `Edm.Int16`
- `Edm.Int32`
- `Edm.Int64`
- `Edm.SByte`
- `Edm.String`
- `Edm.Time`
- `Edm.DateTimeOffset`
- `Edm.Geography`
- `Edm.GeographyPoint`
- `Edm.GeographyLineString`
- `Edm.GeographyPolygon`
- `Edm.GeographyMultiPoint`
- `Edm.GeographyMultiLineString`
- `Edm.GeographyMultiPolygon`
- `Edm.GeographyCollection`
- `Edm.Geometry`
- `Edm.GeometryPoint`
- `Edm.GeometryLineString`
- `Edm.GeometryPolygon`
- `Edm.GeometryMultiPoint`
- `Edm.GeometryMultiLineString`
- `Edm.GeometryMultiPolygon`
- `Edm.GeometryCollection`
- `Edm.Stream`

# 3	Entity Model Wrapper Constructs[csdl3]

An Entity Model Wrapper serves as the aggregation root for the schemas that describe the entity model exposed by the OData Service.

## 3.1	The `edmx:Edmx` Element[csdl3.1]

An OData service exposes a single entity model. A CSDL description of the entity model can be requested from `$metadata`.

The document returned by `$metadata` MUST contain a single root edmx:Edmx element. This element MUST contain a single direct child [`edmx:DataServices`][csdl3.2] element. The data services element contains a description of the entity model(s) exposed by the OData service.

In addition to the data services element, `Edmx` may have zero or more [`edmx:Reference`][csdl3.3] elements and zero or more [`edmx:AnnotationsReference`][csdl3.4] elements. Reference elements specify the location of schemas referenced by the OData service. Annotations reference elements specify the location of [annotations][csdl15] to be applied to the OData service.

The following example demonstrates the basic structure of the `Edmx` element and the [`edmx:DataServices`][csdl3.2] element:

	<edmx:Edmx xmlns:edmx="http://schemas.microsoft.com/ado/2007/06/edmx" Version="1.0">
	 <edmx:DataServices xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" m:DataServiceVersion="2.0">
	  <Schema ... />
	 </edmx:DataServices>
	</edmx:Edmx>

### 3.1.1	The `Version` Attribute[csdl3.1.1]

<!-- TODO: Find link to Version attribute in XMLSCHEMA -->
The `Version` attribute MUST be present on the [`edmx:Edmx`][csdl3.1] element. See <xmlschema> for details.

The `Version` attribute is a string value that specifies the version of the EDMX wrapper, and must be of the form `<majorversion>.<minorversion>`. This version of the specification defines version `1.0` of the EDMX Wrapper.

## 3.2	The `edmx:DataServices` Element[csdl3.2]

The `edmx:DataServices` element contains zero or more [`edm:Schema`][csdl4.1] elements which define the schema(s) exposed by the OData service.

### 3.2.1	The `metadata:DataServiceVersion` Attribute[csdl3.2.1]

The `metadata:DataServiceVersion` attribute describes the version of OData protocol required to consume the service. This version of the specification defines the following valid data service version values: “1.0”, “2.0”, and “3.0”, corresponding to OData protocol versions 1.0, 2.0 and 3.0 respectively.

## 3.3	The `edmx:Reference` Element[csdl3.3]

The `edmx:Reference` element specifies external entity models referenced by this EDMX. Referenced models are available in their entirety to referencing models. All entity types, complex types and other named elements in a referenced model can be accessed from a referencing model.

The following example demonstrates usage of the reference element to reference entity models that contain entity types and complex types that are used as vocabulary terms:

	<?xml version="1.0" encoding="UTF-8" standalone="true"?>
	<edmx:Edmx xmlns:edmx="http://schemas.microsoft.com/ado/2007/06/edmx" Version="1.0">
	 <edmx:Reference Url="http://vocabs.odata.org/capabilities/v1.0" />
	 <edmx:Reference Url="http://vocabs.odata.org/display/v1.0" />
	 <edmx:DataServices ...>
	</edmx:Edmx>

### 3.3.1	The `edmx:Url` Attribute[csdl3.3.1]

The [`edmx:Reference`][csdl3.3] element MUST specify an `edmx:Url` attribute. The URL attribute uniquely identifies a model. The URL may be backed by a CSDL document describing the referenced model. Alternatively, the URL may be used to load a well-known model from a different location.

## 3.4	The `edmx:AnnotationsReference` Element[csdl3.4]

The `edmx:AnnotationsReference` element specifies the location of an external document that contains annotations for this entity model. Only [`edm:Annotations`][csdl15.1], [`edm:TypeAnnotation`][csdl15.2] and [`edm:ValueAnnotation`][csdl15.4] elements will be read from the referenced model.

The annotations reference element MUST contain one or more [`edmx:Include`][csdl3.5] elements that specify the annotations to include from the target document.

The following example demonstrates usage of the annotations reference element to reference documents that contain annotations:

	<?xml version="1.0" encoding="UTF-8" standalone="true"?>
	<edmx:Edmx xmlns:edmx="http://schemas.microsoft.com/ado/2007/06/edmx" Version="1.0">
	 <edmx:AnnotationsReference Url="http://odata.org/ann/a">
	  <edmx:Include />
	 </edmx:AnnotationsReference>
	 <edmx:AnnotationsReference Url="http://odata.org/ann/b">
	  <edmx:Include TermNamespace="org.odata.validation" />
	  <edmx:Include TermNamespace="org.odata.display" Qualifier="Slate" />
	 </edmx:AnnotationsReference>
	 <edmx:DataServices ...>
	</edmx:Edmx>

All annotations from `http://odata.org/ann/a` are included. For `http://odata.org/ann/b`, only the following annotations are included:

- Annotations that use a term from the `org.odata.validation` namespace
- Annotations that use a term from the `org.odata.display` namespace and specify a `Slate` qualifier


### 3.4.1	The `edmx:Url` Attribute[csdl3.4.1]

The [`edmx:AnnotationsReference`][csdl3.4] element MUST specify an `edmx:Url` attribute. The value of the URL attribute uniquely identifies a model. The URL may be backed by a CSDL document describing the referenced model. Alternatively, the URL may be used to load a well-known model from a different location.

## 3.5	The `edmx:Include` Element[csdl3.5]

The `edmx:Include` element specifies which annotations to include from an [annotations reference][csdl3.4]. An include element that does not have an [`edmx:TermNamespace`][csdl3.5.1] attribute or an [`edmx:Qualifier`][csdl3.5.2] attribute includes all annotations within the document. If both [`edmx:TermNamespace`][csdl3.5.1] and [`edmx:Qualifier`][csdl3.5.2] have values, only annotations that meet both restrictions will be included. 

### 3.5.1	The `edmx:TermNamespace` Attribute[csdl3.5.1]

An [`edmx:Include`][csdl3.5] element MAY provide a [`<namespace>`][csdl19] value for the `edmx:TermNamespace` attribute. A term namespace is a string that disambiguates terms with the same name.

For instance, assume both `org.schema` and `org.microformats` define a term named `Address`. Although the terms have the same name, they are uniquely identifiable since each term is in a model with a unique namespace.

If a value is supplied, the include element will import the set of annotations that apply terms from the namespace in the value. The term namespace attribute also provides consumers insight about what namespaces are used in the annotations document. If there are no include elements that have a term namespace of interest to the consumer, the consumer can opt to not download the document.

### 3.5.2	The `edmx:Qualifier` Attribute[csdl3.5.2]

An [`edmx:Include`][csdl3.5] element MAY have a value for the `edmx:Qualifier` attribute. A qualifier is used to apply an annotation to a subset of consumers. For instance, a service author may want to supply a different set of annotations for various device form factors.

If a value is supplied, the include element will import the set of annotations that apply the qualifier in the value. The qualifier attribute also provides consumers insight about which qualifiers are used in the annotations document. If there are no include elements that have a qualifier of interest to the consumer, the consumer can opt to not download the document.

# 4	Schema Constructs[csdl4]

Each entity model exposed by the OData service is described one or more schemas. The schema acts as a container for all of the entity types, complex types and other model elements that make up an entity model.

## 4.1	The edm:Schema Element[csdl4.1]

The Schema is the root of an entity model exposed by an OData service. Although an edmx:DataServices element contains zero or more Schema elements, many OData services will contain exactly one schema.

A Schema element contains zero or more of the following elements:

- [`edm:Annotations`][csdl15.1]
- [`edm:Association`][csdl10.1]
- [`edm:ComplexType`][csdl7.1]
- [`edm:EntityContainer`][csdl12.1]
- [`edm:EntityType`][csdl6.1]
- [`edm:EnumType`][csdl8.1]
- [`edm:Function`][csdl11.1]
- [`edm:Using`][csdl4.2]
- [`edm:ValueTerm`][csdl14.2]

### 4.1.1	The edm:Namespace Attribute[csdl4.1.1]

A schema is identified by the value of the `edm:Namespace` attribute. The schema’s namespace is combined with the name of elements in the entity model to create unique names.

Identifiers that are used to name types MUST be unique within a namespace to prevent ambiguity. See [Nominal Elements][csdl2.1] for more detail.

A schema that contains model elements other than vocabulary annotations MUST specify a [`<namespace>`][csdl19] value for the namespace attribute. A schema that contains only vocabulary annotations MAY specify a [`<namespace>`][csdl19] value for the namespace attribute.
The `edm:Namespace` attribute MUST NOT use the reserved values `System`, `Transient` or `Edm`.

### 4.1.2	The edm:Alias Attribute[csdl4.1.2]

A schema MAY provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Alias` attribute. An alias allows a CSDL document to qualify nominal elements with a short string rather than a long namespace. For instance, `org.odata.vocabularies.display` may simply have an alias of `Self`. An alias qualified name is resolved to a fully qualified name by examining aliases on [`edm:Using`][csdl4.2] and [`edm:Schema`][csdl4.1] elements.

An alias is scoped to the container in which it is declared. For example, a model referencing an annotations document cannot use any aliases defined in that annotations document. A referencing model defines its own aliases with the [`edm:Using`][csdl4.2] element.

## 4.2	The edm:Using Element[csdl4.2]

The `edm:Using` element imports the contents of a specified namespace. A using element binds an alias to the namespace of any entity model.

Importing the contents of another model with a using element may alter the importing model. For instance, a model may import an entity model containing an entity type derived from an entity type in the importing model. In that case an [`edm:EntitySet`][csdl12.2] in the importing model may return either entity type.

### 4.2.1	The edm:Namespace Attribute[csdl4.2.1]

A using element MUST provide a [`<namespace>`][csdl19] value to the `edm:Namespace` attribute. The value provided to the namespace attribute SHOULD match the namespace of an entity model that is in scope.

### 4.2.2	The edm:Alias Attribute[csdl4.2.2]

A using element MUST define a [`<simpleIdentifier>`][csdl19] value for the `edm:Alias` attribute. An alias allows a CSDL model to substitute a short string for a long namespace. For instance, `org.odata.vocabularies.display` may be bound to an alias of `display`. An alias qualified name is resolved to a fully qualified name by examining aliases on [`edm:Using`][csdl4.2] and [`edm:Schema`][csdl4.1] elements.

# 5	Properties[csdl5]

As mentioned in [Structured Elements][csdl2.2], structured elements are composed of other model elements. Structured elements expose a collection of zero or more [`edm:Property`][csdl5.1] elements.

For example, the following complex type has two properties:

	<ComplexType Name="Measurement">
	 <Property Name="Dimension" Type="Edm.String" Nullable="false" MaxLength="50" DefaultValue="Unspecified"/>
	 <Property Name="Length" Type="Edm.Decimal" Nullable="false" Precision="18" Scale="2" />
	</ComplexType>

[Open entity types][csdl6.1.4] allow properties to be added dynamically. When requesting the value of a missing property from an open entity type, the instance MUST return null.

## 5.1	The edm:Property Element[csdl5.1]

An `edm:Property` element allows the construction of structured elements from a scalar value or a collection of scalar values.

For instance, the following property could be used to hold zero or more strings representing the names of measurement units:

	<Property Name="Units" Type="Collection(Edm.String)" Nullable="false"/>

A property MUST specify a unique name as well as a type and zero or more facets. [Facets][csdl5.3] are attributes that modify or constrain the acceptable values for a property value.

### 5.1.1	The `edm:Name` Attribute[csdl5.1.1]

A property MUST specify a [`<simpleIdentifier>`][csdl19] value for the `edm:Name` attribute. The name attribute allows a name to be assigned to the property. This name is used when serializing or deserializing OData payloads and can be used for other purposes, such as code generation.

The value of the name attribute MUST be unique within the set of properties and navigation properties for the type and any of its base types.

## 5.2	The `edm:Type` Attribute[csdl5.2]

A property MUST specify a value for the `edm:Type` attribute. The value of this attribute determines the type for the value of the property on instances of the containing type.

The value of the type attribute MUST be of the form [`<anyKeylessTypeReference>`][csdl19]. The value of the type attribute MUST resolve to a [complex type][csdl7], [enumeration type][csdl8] or [primitive type][csdl2.6], or a collection of complex, enumeration or primitive types.

## 5.3	Property Facets[csdl5.3]

<!-- TODO: This needs more of an introductory paragraph. -->

Facets apply to the type referenced in the element where the facet is declared. If the type is a collection type declared with attribute notation, the facets apply to the types in the collection. In the following example, the Nullable facet applies to the DateTime type.

	<Property Name="SuggestedTimes" Type="Collection(Edm.DateTime)" Nullable="true" />

In the following example the Nullable facet MUST be placed on the child element that references the `DateTime` type. Facets MUST NOT be applied to Collection type references.

	<ReturnType>
	 <Collection>
	  <TypeRef Type="Edm.DateTime" Nullable="true" />
	 </Collection>
	</ReturnType>

### 5.3.1	The `edm:Nullable` Facet[csdl5.3.1]

Any `edm:Property` MAY define a [`<boolean>`][csdl19] value for the `edm:Nullable` facet. The value of this facet determines whether a value is required for the property on instances of the containing type.

If no value is specified, the nullable facet defaults to `true`.

### 5.3.2	The `edm:MaxLength` Facet[csdl5.3.2]

A binary, stream or string `edm:Property` MAY define a [`<nonNegativeIntegral>`][csdl19] value for the `edm:MaxLength` facet. The value of this facet specifies the maximum length of the value of the property on a type instance.

### 5.3.3	The `edm:FixedLength` Facet[csdl5.3.3]

A binary, stream or string `edm:Property` MAY define a [`<nonNegativeIntegral>`][csdl19] value for the `edm:FixedLength` facet. The value of this facet specifies the size of the array used to store the value of the property on a type instance.

### 5.3.4	The `edm:Precision` Attribute[csdl5.3.4]

A temporal or decimal `edm:Property` MAY define a [`<nonNegativeIntegral>`][csdl19] value for the `edm:Precision` attribute.

For a decimal property the value of this attribute specifies the maximum number of digits allowed in the property’s value. For a temporal property the value of this attribute specifies the number of decimal places allowed in the seconds portion of the property’s value.

### 5.3.5	The `edm:Scale` Attribute[csdl5.3.5]

A decimal `edm:Property` MAY define a [`<nonNegativeIntegral>`][csdl19] value for the `edm:Scale` attribute. The value of this attribute specifies the maximum number of digits allowed to the right of the decimal point in the value of the property on a type instance.

The value of the `edm:Scale` attribute MUST be less than or equal to the value of the [`edm:Precision`][csdl5.3.4] attribute.

### 5.3.6	The `edm:Unicode` Attribute[csdl5.3.6]

A string property MAY define a [`<boolean>`][csdl19] value for the `edm:Unicode` attribute.

A `true` value assigned to this attribute indicates that the value of the property is encoded with Unicode. A `false` value assigned to this attribute indicates that the value of the property is encoded with ASCII.

If no value is defined for this attribute, the value defaults to `true`.

### 5.3.7	The `edm:Collation` Attribute[csdl5.3.7]

A string property MAY define a value for the `edm:Collation` attribute. The value of this attribute specifies a collation sequence that can be used for comparison and ordering operations.

The value of the collation attribute MUST be one of the following:

- `Binary`
- `Boolean`
- `Byte`
- `DateTime`
- `DateTimeOffset`
- `Time`
- `Decimal`
- `Double`
- `Single`
- `Guid`
- `Int16`
- `Int32`
- `Int64`
- `String`
- `SByte`

### 5.3.8	The `edm:SRID` Attribute[csdl5.3.8]

A spatial property MAY define a value for the `edm:SRID` attribute. The value of this attribute identifies which spatial reference system is applied to values of the property on type instances.

The value of the SRID attribute MUST be a [`<nonNegativeInt32>`][csdl19] or the special value variable. If no value is specified, the attribute defaults to `0` for Geometry types or `4326` for Geography types.

The valid values of the SRID attribute and their meanings are as defined by the [European Petroleum Survey Group (EPSG)][http://go.microsoft.com/fwlink/?linkid=148018].

### 5.3.9	The `edm:DefaultValue` Facet[csdl5.3.9]

A string property MAY define a value for the `edm:DefaultValue` attribute. The value of this attribute determines the value of the property on new type instances.

### 5.3.10	The `edm:ConcurrencyMode` Attribute[csdl5.3.10]

An `edm:Property` MAY define a value for the `edm:ConcurrencyMode` attribute. The value of this attribute indicates how concurrency should be handled for the property.

The value of the concurrency mode attribute MUST be `None` or `Fixed`. If no value is specified, the value defaults to `None`.

When used on a property of an entity type, the concurrency mode attribute specifies that the value of that property SHOULD be used for optimistic concurrency checks.

The concurrency mode attribute MUST NOT be applied to any properties of a [complex type][csdl7].

The concurrency mode attribute MUST NOT be applied to properties whose type is a complex type.

# 6	Entity Type Constructs[csdl6]

Entity types are nominal structured model elements with a key that consists of one or more references to structural properties. An entity type by definition has an independent existence and can be created, updated or deleted independently of any other types. An entity type is the template for an entity: any uniquely identifiable record such as a customer or order.

A key MUST be supplied if and only if the entity type does not specify a base type. The key consists of one or more references to structural properties of the entity type.

An entity type can define two types of properties. A [structural property][csdl5] is a named reference to a primitive or complex type, or a collection of primitive or complex types. A [navigation property][csdl6.4] is a named reference to another entity type or collection of entity types. All properties MUST have a unique name. Properties MUST NOT have the same name as the declaring entity type.

An [open entity type][csdl6.1.4] allows properties to be added to an instance of the type dynamically. Any request for the value of a missing property on an open entity type MUST return `null`.

A simple example of an entity type is as follows:

	<EntityType Name="Product">
	 <Key>
	  <PropertyRef Name="ID"/>
	 </Key>
	 <Property Name="ID" Type="Edm.Int32" Nullable="false"/>
	 <Property Name="Name" Type="Edm.String" Nullable="true" />
	 <Property Name="Description" Type="Edm.String" Nullable="true" />
	 <NavigationProperty Name="Category" Relationship="ODataDemo.Product_Category_Category_Products" FromRole="Product_Category" ToRole="Category_Products"/>
	 <NavigationProperty Name="Supplier" Relationship="ODataDemo.Product_Supplier_Supplier_Products" FromRole="Product_Supplier" ToRole="Supplier_Products"/>
	</EntityType>

The following example shows an entity type based on the previous example:

	<EntityType Name="DiscontinuedProduct" BaseType="Product">
	 <Property Name="DiscontinuedDate" Type="Edm.DateTime" Nullable="true"/>
	</EntityType>

## 6.1	The `edm:EntityType` Element[csdl6.1]

The `edm:EntityType` element represents an entity type in the entity model.

An entity type MUST contain exactly one [`edm:Key`][csdl6.2] element or specify a value for the [`edm:BaseType`][csdl6.1.2] attribute, but not both.

If no base type is specified, the `edm:EntityType` element MUST contain one or more [`edm:Property`][csdl5.1] elements describing the properties of the entity type. The entity type element also can contain zero or more [`edm:NavigationProperty`][csdl6.4] elements.

### 6.1.1	The `edm:Name` Attribute[csdl6.1.1]

A value of the form [`<simpleIdentifier>`][csdl19] MUST be provided for the `edm:Name` attribute because an entity type is a [nominal element][csdl2.1]. The value identifies the entity type and MUST be unique within the entity type’s namespace.

### 6.1.2	The `edm:BaseType` Attribute[csdl6.1.2]

An entity type can inherit from another entity type by specifying a [`<singleEntityTypeReference>`][csdl19] value for the `edm:BaseType` attribute.

An entity type that provides a value for the base type attribute MUST NOT declare a key with the [`edm:Key`][csdl6.2] element.

An entity type inherits the key as well as structural and navigation properties declared on the entity type’s base type.

An entity type MUST NOT introduce an inheritance cycle via the base type attribute.

### 6.1.3	The `edm:Abstract` Attribute[csdl6.1.3]

An entity type MAY indicate that it cannot be instantiated by providing a [`<boolean>`][csdl19] value of `true` to the `edm:Abstract` attribute. If not specified, the abstract attribute defaults to `false`.

### 6.1.4	The `edm:OpenType` Attribute[csdl6.1.4]

An entity type MAY indicate that it can be freely extended by providing a [`<boolean>`][csdl19] value of `true` to the `edm:OpenType` attribute. An open entity type allows entity instances to add properties dynamically simply by adding uniquely named values to the payload.

If no value is provided for the open type attribute, the value of the open type attribute is set to `false`.

An entity type derived from an open entity type MUST NOT provide a value of false for the open type attribute.

## 6.2	The `edm:Key` Element[csdl6.2]

An entity type MUST be uniquely identifiable. If an entity type does not specify a base type, the entity type MUST contain exactly one `edm:Key` element. An entity type’s key refers to the set of properties that uniquely identify an instance of the entity type.

If specified, the key MUST contain one or more `edm:PropertyRef` elements. An `edm:PropertyRef` element references an [`edm:Property`][csdl5.1]. The properties that compose the key MUST be non-nullable [primitives][csdl2.1] or [enumeration types][csdl8].

The following entity type has a simple key:

	<EntityType Name="Category">
	 <Key>
	  <PropertyRef Name="ID"/>
	 </Key>
	 <Property Name="ID" Type="Edm.Int32" Nullable="false"/>
	 <Property Name="Name" Type="Edm.String" Nullable="true" />
	</EntityType>

The following entity type has a composite key:

	<EntityType Name="OrderLine">
	 <Key>
	  <PropertyRef Name="OrderID"/>
	  <PropertyRef Name="LineNumber"/>
	 </Key>
	 <Property Name="OrderID" Type="Edm.Int32" Nullable="false"/>
	 <Property Name="LineNumber" Type="Edm.Int32" Nullable="false"/>
	</EntityType>

## 6.3	The `edm:PropertyRef` Element[csdl6.3]

The `edm:PropertyRef` element provides an `edm:Key` with a reference to a single property of an entity type. A [`<simpleIdentifier>`][csdl19] value MUST be supplied to the `edm:Name` attribute. This value MUST resolve to one of the properties of the entity type.

## 6.4	The `edm:NavigationProperty` Element[csdl6.4]

A navigation property allows navigation from an entity to related entities.

In the following example, the Product entity type has a navigation property to a Category, which has a navigation link back to one or more products:

	<EntityType Name="Product">
	 ...
	 <NavigationProperty Name="Category" ToRole="Category" FromRole="Product" Relationship="ODataDemo.ProductCategory"/>
	 <NavigationProperty Name="Supplier" ToRole="Supplier" FromRole="Product" Relationship="ODataDemo.ProductSupplier"/>
	</EntityType>
	<EntityType Name="Category">
	 ...
	 <NavigationProperty Name="Products" ToRole="Product" FromRole="Category" Relationship="ODataDemo.ProductCategory"/>
	</EntityType>

### 6.4.1	The `edm:Name` Attribute[csdl6.4.1]

The navigation property MUST provide a [`<simpleIdentifier>`][csdl19] value to the `edm:Name` attribute. The name attribute is a meaningful string that characterizes the relationship when navigating from the entity that declared the navigation property to the related entity.

The name of the navigation property MUST be unique within the set of structural and navigation properties of the containing entity type and any base types of the entity type.

### 6.4.2	The `edm:Relationship` Attribute[csdl6.4.2]

The `edm:Relationship` attribute MUST be given a [`<simpleIdentifier>`][csdl19] or [`<qualifiedIdentifier>`][csdl19] value. The value of the attribute MUST resolve to an [association][csdl10.1] in the entity model.

### 6.4.3	The `edm:ToRole` Attribute[csdl6.4.3]

The navigation property MUST provide a [`<simpleIdentifier>`][csdl19] value to the `edm:ToRole` attribute. The `edm:ToRole` attribute is a name used to refer to the destination of the navigation property.

The value provided to the `edm:ToRole` attribute MUST be the same as one of the [`edm:Role`][csdl10.2.2] names on the corresponding `edm:Association`.

### 6.4.4	The `edm:FromRole` Attribute[csdl6.4.4]

The navigation property MUST provide a [`<simpleIdentifier>`][csdl19] value to the `edm:FromRole` attribute. The `edm:FromRole` attribute is a name used to refer to the destination of the navigation property.

The value provided to the `edm:FromRole` attribute MUST be the same as one of the [`edm:Role`][csdl10.2.2] names on the corresponding `edm:Association`.

### 6.4.5	The `edm:ContainsTarget` Attribute[csdl6.4.5]

A [`<boolean>`][csdl19] value MAY be assigned to the `edm:ContainsTarget` attribute. If no value is assigned to the contains target attribute, the attribute defaults to `false`. If the value assigned to the `edm:ContainsTarget` attribute is `true`, the entity type to which the navigation property belongs is said to contain the destination of the navigation property.

<!-- TODO: Reword this content from the MC-CSDL. -->
“The EntityType that declares the NavigationProperty is the container EntityType.
The AssociationType that is specified in the containment NavigationProperty is the containment AssociationType.
The EntityType that is specified on the End element of the containment AssociationType, with the Name that is specified by the containment NavigationProperty element's ToRole attribute, is the contained EntityType.
When the instances of both the contained entity and the container entity reside in the same EntitySet, it is called recursive containment.
It MUST NOT be possible for an EntityType to contain itself by following more than one containment NavigationProperty.
The contained EntityType can have a NavigationProperty that navigates to the container EntityType via the containment AssociationType.
The End of the containment AssociationType that is specified by the ToRole attribute of the containment NavigationProperty can have any multiplicity.
For nonrecursive containment, the End of the containment AssociationType that is specified by the FromRole attribute of the containment NavigationProperty MUST have a multiplicity of '1'.
For recursive containment, the End of the containment AssociationType that is specified by the FromRole attribute of the containment NavigationProperty MUST have a multiplicity of '0..1'. The End that is specified by the ToRole MUST not have a multiplicity of '1' because this would lead to endless recursion.
An AssociationSetMUST have the same EntitySet on both ends if it is for a containment AssociationType that has either the same EntityType on both ends or an EntityType on one end that derives from the EntityType on the other end.
An EntitySet MUST NOT be bound by AssociationSet to more than one AssociationType via a containment NavigationProperty that indicates that the EntityType (or derived EntityTypes) of that EntitySet is contained.
Note  Because the EntityType of an EntitySet on an AssociationSet End MUST be the same as or derived from the EntityTypes on the corresponding AssociationType End, the EntitySet MUST be either completely contained or completely noncontained. 

# 7	Complex Type Constructs[csdl7]

Complex types are keyless nominal structured types. The lack of a key means that complex types cannot be created, updated or deleted independently of an entity type. Complex types allow entity models to group properties into common structures if the group of properties does not need to be managed independently.

All properties MUST have a unique name. Properties MUST NOT have the same name as the declaring complex type.

The following example demonstrates a complex type that is used by two entity types:

	<ComplexType Name="Dimensions">
	 <Property Name="Height" Nullable="false" Type="Edm.Decimal"/>
	 <Property Name="Weight" Nullable="false" Type="Edm.Decimal"/>
	 <Property Name="Length" Nullable="false" Type="Edm.Decimal"/>
	</ComplexType>
	<EntityType Name="Product">
	 ... 
	 <Property Name="ProductDimensions" Type="Dimensions" />
	 <Property Name="ShippingDimensions" Type="Dimensions" />
	</EntityType>
	<EntityType Name="ShipmentBox">
	 ...
	 <Property Name="Dimensions" Type="Dimensions" />
	</EntityType>

## 7.1	The `edm:ComplexType` Element[csdl7.1]

The `edm:ComplexType` element represents a complex type in an entity model.

The complex type MUST declare a [`<simpleIdentifier>`][csdl18] value for the `edm:Name` attribute as well as one or more [`edm:Property`][csdl5.1] elements. Complex types MUST NOT have any [navigation properties][csdl6.4].

# 8	Enumeration Type Constructs[csdl8]

Enumeration types are nominal scalar types that represent a series of related values. Enumeration types expose these related values as members of the enumeration.

Enumeration types typically allow the selection of a single member. The [`edm:IsFlags`][csdl8.1.2] attribute allows entity model authors to indicate that more than one value can be selected.

The following example shows a simple flags-enabled enum:

	<EnumType Name="FileAccess" UnderlyingType="Edm.Int32" IsFlags="true">
	 <Member Name="Read" Value="1" />
	 <Member Name="Write" Value="2" />
	 <Member Name="Create" Value="4" />
	 <Member Name="Delete" Value="8" />
	</EnumType>

## 8.1	The `edm:EnumType` Element[csdl8.1]

The `edm:EnumType` element represents an enumeration type in an entity model.

The enumeration type MUST provide a [`<simpleIdentifier>`][csdl19] as the value of the `edm:Name` attribute.

The enumeration type element contains zero or more child [`edm:Member`][csdl8.2] elements enumerating the members of the enum.

### 8.1.1	The `edm:UnderlyingType` Attribute[csdl8.1.1]

An enumeration type has an underlying type which specifies the allowable values for member mapping. 

The enumeration type MUST assign an <integralPrimitive> value to the `edm:UnderlyingType` attribute. If the underlying type is not specified, a 32-bit integer MUST be used as the underlying type.

### 8.1.2	The `edm:IsFlags` Attribute[csdl8.1.2]

An enumeration type MAY specify a [`<boolean>`][csdl19] value for the `edm:IsFlags` attribute. A value of `true` indicates that the enumeration type allows multiple members to be selected simultaneously.

## 8.2	The `edm:Member` Element[csdl8.2]

An enumeration type typically has two or more members. Members represent discrete options for the enumeration type.

Enumeration members are declared with the `edm:Member` element.

For example, the following enumeration type has three discrete members:

	<EnumType Name=" ShippingMethod">
	 <Member Name="FirstClass" />
	 <Member Name="TwoDay" />
	 <Member Name="Overnight" />
	</EnumType>

### 8.2.1	The `edm:Name` Attribute[csdl8.2.1]

Each enumeration member MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Name` attribute. The enumeration type MUST NOT declare two members with the same name.

### 8.2.2	The `edm:Value` Attribute[csdl8.2.2]

The value of an enum member allows entity instances to be sorted by a property that has an enum member for its value. If the value is not explicitly set, the value MUST be assigned to 0 for the first member or one plus the previous member value for any subsequent members.

The value MUST be a valid value for the [`edm:UnderlyingType`][csdl8.1.1] of the enumeration type.

In the example that follows, `FirstClass` MUST be assigned a value of `0`, `TwoDay` a value of `4`, and `Overnight` a value of `5`.

	<EnumType Name="ShippingMethod">
	 <Member Name="FirstClass" />
	 <Member Name="TwoDay" Value="4" />
	 <Member Name="Overnight" />
	</EnumType>

# 9	Other Type Constructs[csdl9]

## 9.1	Collection Types[csdl9.1]

A collection type provides a means of representing a collection of scalar, complex or entity types.

A collection type can be represented with attribute notation or element notation, as shown in these two equivalent examples:

	<ReturnType Type="Collection(Edm.String) " />

	<ReturnType>
	 <CollectionType>
	  <TypeRef Type="Edm.String" />
	 </CollectionType>
	</ReturnType>

	
<!-- TODO: Watch for problems like this, where enum types are not mentioned but should be. Maybe use "nominal type" instead and replace the ABNF with a <nominalTypeIdentifier> -->
If specified with attribute notation, the collection type MUST be a collection of entity types, complex types or scalar types. If specified with element notation, the collection type can also be a collection of other collection types, reference types or row types.

### 9.1.1	The `edm:CollectionType` Element[csdl9.1.1]

The `edm:CollectionType` element represents a collection of other types in an entity model.

The collection type element can identify the types contained in the collection by specifying a [`<simpleIdentifier>`][csdl19] or [`<qualifiedIdentifier>`][csdl19] value for the `edm:ElementType` attribute.

Alternatively the collection type can identify the types contained in the collection by specifying one of the following child elements:

- `edm:CollectionType`
- [`edm:ReferenceType`][csdl9.3.1]
- [`edm:RowType`][csdl9.4.1]
- [`edm:TypeRef`][csdl9.2]

The collection type MUST identify the types contained in the collection with exactly one of the methods indicated above.

The collection type can define relevant facets for scalar types.

## 9.2	The `edm:TypeRef` Element[csdl9.2]

The `edm:TypeRef` element is used to reference a nominal type.

The `edm:TypeRef` element MUST provide a [`<simpleIdentifier>`][csdl19] or [`<qualifiedIdentifier>`][csdl19] value for the `edm:Type` attribute.

The type ref can define relevant facets for scalar types.

## 9.3	Reference Types[csdl9.3]

A reference type specifies a reference to an entity instance. A reference to an entity instance is a special structure consisting primarily of the entity instance key. A reference to an entity instance is useful when a large number of entities would otherwise be returned.

A reference type can be specified with attribute notation or element notation, as shown in the following two examples:

	<ReturnType Type="Ref(Self.Customer) " />

	<ReturnType>
	 <CollectionType>
	  <ReferenceType Type="Self.Customer" />
	 </CollectionType>
	</ReturnType>

### 9.3.1	The `edm:ReferenceType` Element[csdl9.3.1]

The `edm:ReferenceType` element represents a reference type in an entity model.

A reference type MUST specify a [`<singleEntityTypeReference>`][csdl19] value for the `edm:Type` attribute. The value of this attribute names the type for which the reference type contains key information.

## 9.4	Row Types[csdl9.4]

A row type is the only structural type that is not nominal in nature. Because it does not have a name, the row type MUST be used inline. Row types are frequently used as the structure of a function import’s return type.

### 9.4.1	The `edm:RowType` Element[csdl9.4.1]

The `edm:RowType` element represents a structural type without a name. The row type MUST declare one or more [`edm:Property`][csdl5.1] elements that define its structure.

# 10	Association Constructs[csdl10]

Associations provide the fundamental definition for a relationship between two entity types. An association MUST have a name and two ends, each with their own cardinality. In some cases, an association also has a referential constraint. A referential constraint asserts that the entity type playing the principal role in an association MUST exist for the entity type playing the dependent role to exist.

A simple association might look like this:

	<Association Name="ProductCategory"> 
	 <End Type="ODataDemo.Product" Multiplicity="*" Role="Product"/>
	 <End Type="ODataDemo.Category" Multiplicity="0..1" Role="Category"/>
	</Association>

## 10.1	The `edm:Association` Element[csdl10.1]

The `edm:Association` element represents an association in an entity model. The association MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Name` attribute.

An association MUST contain exactly two `edm:End` elements that represent the respective ends of the association. The association MAY also specify zero or one [`edm:ReferentialConstraint`][csdl10.4] elements.

## 10.2	The `edm:End` Element[csdl10.2]

An association has exactly two ends, each of which plays a role, has its own multiplicity and refers to the entity type at that end of the association. The `edm:End` element describes one of the ends of an association.

Each end MAY also contain zero or one [`edm:OnDelete`][csdl10.3] elements to specify operational behavior.

### 10.2.1	The `edm:Type` Attribute[csdl10.2.1]

Each end of the association MUST specify the entity type attached to that end. The value of the `edm:Type` attribute must be a [`<singleEntityTypeReference>`][csdl19]. The value of the type attribute MUST resolve to an entity type in the entity model.

### 10.2.2	The `edm:Role` Attribute[csdl10.2.2]

The `edm:Role` attribute allows the association end to be bound to a [navigation property][csdl6.4]. The association end MAY assign a [`<simpleIdentifier>`][csdl19] value to the `edm:Role` attribute.

### 10.2.3	The `edm:Multiplicity` Attribute[csdl10.2.3]

The `edm:Multiplicity` attribute defines the cardinality of the association end. The value of the attribute MUST be one of the following:
- `0..1` – zero or one
- `1` – exactly one
- `*` – zero or more

## 10.3	The `edm:OnDelete` Element[csdl10.3]

The `edm:OnDelete` element prescribes the action that should be taken when the entity on the opposing end of the association is deleted.

If present, the `edm:OnDelete` element MUST define a value for the `edm:Action` attribute. The value assigned to the action attribute MUST be `Cascade` or `None`.

## 10.4	The `edm:ReferentialConstraint` Element[csdl10.4]

A referential constraint asserts that the entity on the principal end of the referential constraint must exist in order for the entity on the dependent end to exist. This assertion is established by the `edm:ReferentialConstraint` element.

A referential constraint MUST contain exactly one `edm:Principal` element and exactly one `edm:Dependent` element.

In the example that follows, the category must exist for a product in that category to exist:

	<Association Name="ProductCategory"> 
	 <End Type="ODataDemo.Product" Multiplicity="*" Role="Product"/>
	 <End Type="ODataDemo.Category" Multiplicity="0..1" Role="Category"/>
	 <ReferentialConstraint>
	  <Principal Role="Category">
	   <PropertyRef Name="CategoryID" />
	  </Principal>
	  <Dependent Role="Product">
	   <PropertyRef Name="CategoryID" />
	  </Dependent>
	 </ReferentialConstraint>
	</Association>

## 10.5	The `edm:Principal` Element[csdl10.5]

The `edm:Principal` element represents the dominant end of the association. The entity on this end of the association may exist independently of the entity on the dependent end of the association.

The principal element MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Role` attribute. This value MUST have the same value as the `edm:Role` attribute of one of the association ends. The multiplicity of that association end MUST be `1` or `0..1`.

The principal end of the referential constraint MUST contain one or more `edm:PropertyRef` elements that name the key properties of the principal entity type.

## 10.6	The `edm:Dependent` Element[csdl10.6]

The `edm:Dependent` element represents the subordinate end of the association. The entity on this end of the association may only exist if an entity on the opposite end of the association exists.

The dependent element MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Role` attribute. This value MUST have the same value as the `edm:Role` attribute of one of the association ends.

## 10.7	The `edm:PropertyRef` Element[csdl10.7]

The `edm:PropertyRef` elements indicate the fields that take part in the referential constraint on each entity.

The `edm:Principal` element and the `edm:Dependent` element MUST each contain the same number of `edm:PropertyRef` elements. The property references MUST each be assigned [`<simpleIdentifier>`][csdl19] values and be ordered consistently in the principal and dependent elements. The property references MUST have the same data types in the principal and dependent elements.

The property references for the principal entity MUST be the same property references specified in the [`edm:Key`][csdl6.2] of the principal entity type, however they need not share the same order.

The following example is NOT valid because the order of the `edm:PropertyRef` elements is inconsistent on the principal and dependent ends of the referential constraint:

	<Association Name="OrderLineDetails"> 
	 <End Type="ODataDemo.OrderLineDetail" Multiplicity="*" Role="Detail"/>
	 <End Type="ODataDemo.OrderLine" Multiplicity="0..1" Role="OrderLine"/>
	 <ReferentialConstraint>
	  <Principal Role="OrderLine">
	   <PropertyRef Name="OrderID" />
	   <PropertyRef Name="LineNumber" />
	  </Principal>
	  <Dependent Role="Detail">
	   <PropertyRef Name="LineNumber" />
	   <PropertyRef Name="OrderID" />
	  </ Dependent>
	 </ReferentialConstraint>
	</Association>

# 11	Model Functions[csdl11]

Model functions are similar to [function imports][csdl12.4] in that they represent a function that can interact with model elements. Model functions allow the definition of a function body directly in the model. This specification does not place any requirements on the content of the function body.

For example, the following function represents a means of calculating an age:

	<Function Name="GetAge" ReturnType="Edm.Int32">
	 <Parameter Name="Person" Type="Model.Person" />
	 <DefiningExpression>
	  Edm.DiffYears(Edm.CurrentDateTime(), Person.Birthday)
	 </DefiningExpression>
	</Function>

<!-- TODO: Find ref for ESQL. -->
In the preceding example the function defines a function body using Entity SQL. This example is informative only; it is up to a given runtime to determine the validity of the defining expression.

## 11.1	The `edm:Function` Element[csdl11.1]

The `edm:Function` element is a nominal element that represents a user function in an entity model. The function may return a single or collection of primitive types, row types or nominal structured types.

A function MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Name` attribute.

The function MUST specify exactly one return type. The return type can be specified using the `edm:ReturnType` attribute or the `edm:ReturnType` element.

The function MAY also contain zero or more `edm:Parameter` elements to be used during the execution of the function.

All parameters and the return type MUST be one of the following:

- A scalar type or a collection of scalar types
- An entity type or a collection of entity types
- A complex type or a collection of complex types
- A row type or a collection of row types
- A reference type or a collection of reference types

The function MAY contain zero or one `edm:DefiningExpression` elements that state the definition for the function body. The conceptual schema definition language (CSDL) file format does not specify rules and restrictions regarding what language is to be used for expressing function bodies.

### 11.1.1	The `edm:ReturnType` Attribute[csdl11.1.1]

If the return type is written with attribute notation, an [`<anyTypeIdentifier>`][csdl19] value MUST be provided for the `edm:ReturnType` attribute.

If a value is provided for the return type attribute, the `edm:Function` element MUST NOT contain an `edm:ReturnType` element.

## 11.2	The `edm:Parameter` Element[csdl11.2]

The `edm:Parameter` element represents a parameter to the function. A [`<simpleIdentifier>`][csdl19] value MUST be provided for the `edm:Name` attribute.

The parameter element MUST specify exactly one type. The type may be specified by providing an [`<anyTypeIdentifier>`][csdl19] value to the `edm:Type` attribute. Alternatively the type may be specified by providing at most one [`edm:CollectionType`][csdl9.1.1], [`edm:ReferenceType`][csdl9.3.1], or [`edm:RowType`][csdl9.4.1] element as a child of the parameter element.

The parameter element MUST NOT set a value for the `edm:Mode` attribute. The mode for function parameters is always `In`.

## 11.3	The `edm:ReturnType` Element[csdl11.3]

If the return type is written with element notation, the `edm:Function` MUST contain exactly one `edm:ReturnType` element.

The return type element MUST specify exactly one type. The type may be specified by providing a [`<anyTypeIdentifier>`][csdl19] value to the `edm:Type` attribute. Alternatively the type may be specified by providing at most one [`edm:CollectionType`][csdl9.1.1], [`edm:ReferenceType`][csdl9.3.1], or [`edm:RowType`][csdl9.4.1] element as a child of the return type element.

If a value is provided for the return type element, the `edm:Function` element MUST NOT specify a value for the `edm:ReturnType` attribute.

# 12	Entity Container Constructs[csdl12]

An entity model can also describe how entities are logically grouped and even model the store or stores from which the entities can be retrieved. This is achieved through the declaration of entity containers, entity sets and association sets.

An entity set is a nominal element that allows access to entity instances. Simple entity models frequently have one entity set per entity type, for example:

	<EntitySet Name="Products" EntityType="ODataDemo.Product"/>
	<EntitySet Name="Categories" EntityType="ODataDemo.Category"/>

Other entity models may expose multiple entity sets per type. For instance, an entity model may have the following entity sets:

	<EntitySet Name="Products" EntityType="ODataDemo.Product"/>
	<EntitySet Name="DiscontinuedProducts" EntityType="ODataDemo.Product"/>

In this case the `Products` entity set could expose products that have not been discontinued and the `DiscontinuedProducts` entity set could expose products that have been discontinued.

An entity set can expose instances of the specified entity type as well as any entity type inherited from the specified entity type.

An association set is a nominal element that disambiguates the entity set used by an association end. In the preceding example an `ODataDemo.Product` could be exposed through the `Products` entity set or the `DiscontinuedProducts` entity set. An association set is required to clarify which entity set is used for any association end that refers to `ODataDemo.Product`.

A function import is used to expose functions that are defined in a data store. For example, the following function import exposes a stored procedure that returns the top ten revenue generating products for a given fiscal year:

	<FunctionImport Name="TopTenProductsByRevenue" EntitySet="Products" ReturnType="Collection(ODataDemo.Product)">
	 <Parameter Name="fiscalYear" Mode="In" Type="String" />
	</FunctionImport>

An entity container is the entity model equivalent of a single data store. An entity container aggregates entity sets, association sets and function imports.

A full example of an entity container is as follows:

	<EntityContainer Name="DemoService">
	 <EntitySet Name="Products" EntityType="ODataDemo.Product"/>
	 <EntitySet Name="Categories" EntityType="ODataDemo.Category"/>
	 <EntitySet Name="Suppliers" EntityType="ODataDemo.Supplier"/>
	 <AssociationSet Name="ProductCategorySet" Association="ODataDemo.ProductCategory">
	  <End Role="Product" EntitySet="Products"/>
	  <End Role="Category" EntitySet="Categories"/>
	 </AssociationSet>
	 <AssociationSet Name="ProductSupplierSet" Association="ODataDemo.ProductSupplier">
	  <End Role="Product" EntitySet="Products"/>
	  <End Role="Supplier" EntitySet="Suppliers"/>
	 </AssociationSet>
	 <FunctionImport Name="GetProductsByRating" EntitySet="Products" ReturnType="Collection(ODataDemo.Product)">
	  <Parameter Name="rating" Type="Edm.Int32" Mode="In"/>
	 </FunctionImport>
	</EntityContainer>

## 12.1	The `edm:EntityContainer` Element[csdl12.1]

The `edm:EntityContainer` element represents an entity container in an entity model. It corresponds to a logical data store and contains zero or more `edm:EntitySet`, `edm:AssociationSet` or `edm:FunctionImport` elements.

The entity container MUST provide a unique [`<simpleIdentifier>`][csdl19] value for the `edm:Name` attribute.

An entity container MAY provide a [`<qualifiedIdentifier`][csdl19] value for the `edm:Extends` attribute. The value provided to the extends attribute MUST resolve to an entity container in the entity model. All of the children in the extending entity container are added to the children of the extended entity container.

## 12.2	The `edm:EntitySet` Element[csdl12.2]

The `edm:EntitySet` element is a nominal element that represents an entity set in an entity model.

An entity set MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Name` attribute. An entity set also has an `edm:EntityType` attribute that MUST be provided with a [`<singleEntityTypeReference>`][csdl19] that resolves to an entity type in the model. Each entity type in the model may have zero or more entity sets that reference the entity type.

An entity set MUST contain only the entity type specified by the `edm:EntityType` attribute or its subtypes. The entity type named by the entity type attribute MAY be abstract.

## 12.3	The `edm:AssociationSet` Element[csdl12.3]

The `edm:AssociationSet` element is a nominal element that represents an association set in an entity model.

An association set MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Name` attribute. An association set also has an `edm:Association` attribute that MUST be provided with a [`<qualifiedIdentifier>`][csdl19] that resolves to an association in the entity model.

An association set can contain zero, one or two `edm:End` elements.

### 12.3.1	The `edm:End` Element[csdl12.3.1]

An `edm:End` element MUST be specified if the corresponding end of the association refers to an entity type that is exposed in more than one entity set.

An association set end MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Role` attribute that is the same as the value of one of the association ends’ `edm:Role` attribute.

The `edm:End` element MUST also provide a [`<simpleIdentifier>`][csdl19] or [`<qualifiedIdentifier>`][csdl19] value for the `edm:EntitySet` attribute. The entity set that is named MUST expose the entity type bound by the corresponding end of the association.

## 12.4	The `edm:FunctionImport` Element[csdl12.4]

The `edm:FunctionImport` element is a nominal element that represents a store function in an entity model. The function may return a single or collection of primitive types or nominal structured types.

A function import MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Name` attribute.

The function import MUST specify zero or more return types. If the function import has only one return type, the return type can be specified using the `edm:ReturnType` attribute. If the function import has more than one return type, the return type MUST be specified using multiple [`edm:ReturnType`][csdl12.5] elements. All return types must be scalar, entity or complex types or a collection of scalar, entity or complex types.

The function import may also define zero or more [`edm:Parameter`][csdl12.6] elements to be used during the execution of the function.

### 12.4.1	The `edm:ReturnType` Attribute[csdl12.4.1]

If the return type is written with attribute notation, an [`<anyTypeIdentifier>`][csdl19] value MUST be provided for the `edm:ReturnType` attribute.

If a value is provided for the return type attribute, the `edm:FunctionImport` element MUST NOT contain a `edm:ReturnType` element.

### 12.4.2	The `edm:EntitySet` Attribute[csdl12.4.2]

If the return type is an entity or a collection of entities, a [`<simpleIdentifier>`][csdl19] value MAY be defined for the `edm:EntitySet` attribute that names the entity set to which the returned entities belong.

If the return type is not an entity or a collection of entities, a value MUST NOT be defined for the `edm:EntitySet` attribute.

If the `edm:EntitySet` attribute is assigned a value, the `edm:EntitySetPath` MUST NOT be assigned a value.

### 12.4.3	The `edm:EntitySetPath` Attribute[csdl12.4.3]

The function import MAY specify a value for the `edm:EntitySetPath` attribute if determination of the entity set for the return type is contingent on a parameter.

The value for the `edm:EntitySetPath` attribute consists of a series of segments joined together with forward slashes.

The first segment of the entity set path MUST have the same name as one of the function import’s parameters. The remaining segments of the entity set path MUST represent navigation or type casts.

A navigation segment simply names the [`<simpleIdentifier>`][csdl19] of the [navigation property][csdl6.4] to be traversed. A type cast segment names the [`<qualifiedIdentifier>`][csdl19] of the entity type that should be returned from the type cast.

### 12.4.4	The `edm:IsSideEffecting` Attribute[csdl12.4.4]

A function import can specify a [`<boolean>`][csdl19] value for the `edm:IsSideEffecting` attribute. If no value is specified for the is side effecting attribute, the value defaults to `true`.

If the value of the `edm:IsSideEffecting` attribute is `true`, the value of the [`edm:IsComposable`][csdl12.4.6] attribute must be `false`.

### 12.4.5	The `edm:IsBindable` Attribute[csdl12.4.5]

A function import can specify a [`<boolean>`][csdl19] value for the `edm:IsBindable` attribute. If no value is specified for the `edm:IsBindable` attribute, the value defaults to `false`.

If the is bindable attribute is set to `true`, the function import MUST contain at least one [`edm:Parameter`][csdl12.6] element.

### 12.4.6	The `edm:IsComposable` Attribute[csdl12.4.6]

A function import can specify a [`<boolean>`][csdl19] value for the `edm:IsComposable` attribute. If no value is specified for the is composable attribute, the value defaults to `false`.

If the value of the `edm:IsComposable` attribute is `true`, the value of the [`edm:IsSideEffecting`][csdl12.4.4] attribute must be `false`.

## 12.5	The `edm:ReturnType` Element[csdl12.5]

If the return type is written with element notation, the function import MUST contain one or more `edm:ReturnType` elements. The presence of multiple return type elements may occur when the store returns more than one result set for a given function.

If element notation is used, a similar set of attributes can be used to specify the return type of the function. The `edm:Type` attribute corresponds to the [`edm:ReturnType`][csdl12.4.1] attribute on `edm:FunctionImport`, and the names and functionality of the [`edm:EntitySet`][csdl12.4.2] and [`edm:EntitySetPath`][csdl12.4.3] attributes remain the same.

## 12.6	The `edm:Parameter` Element[csdl12.6]

The `edm:Parameter` element allows one or more parameters to be passed to the function. This enables the function to return a dynamic set of instances – for example, the top-selling products by year. In this case the year must be specified as a parameter to the function with the `edm:Parameter` element.

The `edm:Name` attribute MUST be used to assign a unique [`<simpleIdentifier>`][csdl19] value to the parameter.

### 12.6.1	The `edm:Type` Attribute[csdl12.6.1]

The parameter MUST indicate which set of types can be passed to the parameter by providing a [`<anyTypeReference>`][csdl19] value for the `edm:Type` attribute.

### 12.6.2	The `edm:Mode` Attribute[csdl12.6.2]

A value of `In`, `Out`, or `InOut` MAY be provided to the `edm:Mode` attribute. These values correspond to the modality of parameters passed to stored procedures in relational databases.

### 12.6.3	Parameter Facets[csdl12.6.3]

A parameter may specify values for the [`edm:Nullable`][csdl5.3.1], [`edm:MaxLength`][csdl5.3.2], [`edm:Precision`][csdl5.3.4], [`edm:Scale`][csdl5.3.5], or [`edm:SRID`][csdl5.3.8] attributes. The descriptions of these facets and their implications are covered elsewhere in this specification.

# 13	Vocabulary Concepts[csdl13]

Vocabulary terms and annotations provide a means of semantically enriching an entity model and the type instances accessible through that entity model. Annotations can be used for two fundamental purposes:

- To extend type instances with additional information
- To enable new types to be instantiated from existing type instances

Type instances can be extended with additional information through the application of value annotations. A value annotation attaches a value term to a type instance and provides a means of calculating a value for the value term.

For example, the following entity type includes a value annotation that allows a display name to be calculated from an entity instance:

	<EntityType Name="Category">
	 ...
	 <Property Name="Name" Nullable="true" Type="Edm.String"/>
	 <ValueAnnotation Term="display.DisplayName" Path="Name" />
	</EntityType>

Type annotations allow a different type to be instantiated from an instance of an entity type. The type annotation attaches a type term to a type instance and provides a means of instantiating the type named in the term.

For instance, the following entity type includes a type annotation that allows a `SearchResult` to be instantiated from a `Product`:

	<EntityType Name="Product">
	 <Key>
	  <PropertyRef Name="ID"/>
	 </Key>
	 <Property Name="ID" Nullable="false" Type="Edm.Int32"/>
	 <Property Name="Name" Nullable="true" Type="Edm.String" />
	 <Property Name="Description" Nullable="true" Type="Edm.String" />
	 <Property Name="ReleaseDate" Nullable="false" Type="Edm.DateTime"/>
	 <Property Name="Rating" Nullable="false" Type="Edm.Int32"/>
	 <Property Name="Price" Nullable="false" Type="Edm.Decimal"/>
	 ...
	 <TypeAnnotation Term="SearchVocabulary.SearchResult">
	  <PropertyValue Property="Title" Path="Name" />
	  <PropertyValue Property="Url">
	   <Apply Function="CommonFunctionsVocabulary.Concat">
	    <String>Products(</String>
	    <Path>ID</Path>
	    <String>)</String>
	   </Apply>
	  </PropertyValue>
	  <PropertyValue Property="Abstract">
	   <Path>Description</Path>
	  </PropertyValue>
	 </TypeAnnotation>
	</EntityType>

Type and value annotations can be defined at a universal or instance level. Universal annotations are applied directly in the entity model as described in CSDL. Instance annotations are applied to entity instances in the response payload.

Type and value annotations can be used to apply type and value terms respectively. These terms may be part of a well-known vocabulary or part of a company-specific or product-specific vocabulary.

# 14	Vocabulary Terms[csdl14]

There are two types of vocabulary terms that can be applied: type terms and value terms.

A type term implies that a type can be instantiated from the annotated element. Either an `edm:EntityType` or an `edm:ComplexType` can be used as a type term. There are no special requirements for an `edm:EntityType` or an `edm:ComplexType` to be used as a type term.

A value term extends an existing instance with additional data. A value term is limited to a single field, however that field may be an entity type or a complex type.

## 14.1	`edm:EntityType` and `edm:ComplexType` Terms[csdl14.1]

There are no special requirements for an [`edm:EntityType`][csdl6.1] or an [`edm:ComplexType`][csdl7.1] to be used as a type term. Type terms need not be in the same model as the type annotations or the annotated types.

## 14.2	The `edm:ValueTerm` Element[csdl14.2]

The `edm:ValueTerm` element represents a value term in an entity model.

The value term MUST provide a [`<simpleIdentifier>`][csdl19] value for the `edm:Name` attribute and a [`<simpleIdentifier>`][csdl19] or [`<qualifiedIdentifier>`][csdl19] value for the `edm:Type` attribute. The name attribute allows the term to be applied with a value annotation. The type attribute indicates what type of value must be returned by the expression contained in the value annotation.

# 15	Vocabulary Annotations[csdl15]

Vocabulary terms are used to annotate other model elements. The following model elements may be annotated with a vocabulary term:

- [`edm:Annotations`][csdl15.1]
- [`edm:ComplexType`][csdl7.1]
- [`edm:EntitySet`][csdl12.2]
- [`edm:EntityType`][csdl6.1]
- [`edm:EnumType`][csdl8.1]
- [`edm:Function`][csdl11.1]
- [`edm:FunctionImport`][csdl12.4]
- [`edm:NavigationProperty`][csdl6.4]
- [`edm:Parameter`][csdl12.6]
- [`edm:Property`][csdl5.1]
- [`edm:ValueTerm`][csdl14.2]

The most common usage of a type term is to annotate an entity type or complex type. In this situation, an instance of the type term may be created for each instance of the entity type or complex type the term is applied to.

Type terms can also be used to annotate a variety of other model elements including an entity set, a function import, or a navigation property.

In contrast to type annotations, which allow the instantiation of new types, a value annotation extends an existing type instance with additional information.

## 15.1	The `edm:Annotations` Element[csdl15.1]

The `edm:Annotations` element is used to apply a group of type or value annotations to a single model element.

An annotations element MUST assign a [`<simpleIdentifier>`][csdl19] or [`<qualifiedIdentifier>`][csdl19] value to the `edm:Target` attribute. The value of the target attribute SHOULD resolve to a model element in the entity model.

An annotations element MAY contain zero or more `edm:TypeAnnotation` and `edm:ValueAnnotation` elements.

## 15.2	The `edm:TypeAnnotation` Element[csdl15.2]

The `edm:TypeAnnotation` element represents a type annotation. A type annotation binds a type term to a model element.

A type annotation MUST be used as a child of the model element it annotates or a child of an `edm:Annotations` element that targets the appropriate model element.

A type annotation MUST provide a [`<simpleIdentifier>`][csdl19] or [`<qualifiedIdentifier>`][csdl19] value for the `edm:Term` attribute. The value of the term attribute SHOULD resolve to an entity type or complex type.

A type annotation MAY contain zero or more `edm:PropertyValue` elements.

## 15.3	The `edm:PropertyValue` Element[csdl15.3]

The `edm:PropertyValue` element supplies a value to a property on the type instantiated by a type annotation. The value is obtained by evaluating an expression.

The property value element MUST assign a [`<simpleIdentifier>`][csdl19] value to the `edm:Property` attribute. The value of the property attribute SHOULD resolve to a property on the term referenced by the type annotation. 

A property value MUST contain exactly one expression. The expression MAY be provided using element notation or attribute notation.

## 15.4	The `edm:ValueAnnotation` Element[csdl15.4]

The `edm:ValueAnnotation` element represents a value annotation. A value annotation attaches a named value to a model element.

A value annotation MUST be used as a child of the model element it annotates or a child of an [`edm:Annotations`][csdl15.1] element that targets the appropriate model element.

A value annotation MUST provide a [`<simpleIdentifier>`][csdl19] or [`<qualifiedIdentifier>`][csdl19] value for the `edm:Term` attribute. The value of the term attribute SHOULD resolve to a value term.

A value annotation MUST contain at most one expression. The expression MAY be provided using element notation or attribute notation.

## 15.5	The `edm:Qualifier` Attribute[csdl15.5]

The qualifier attribute allows service authors a means of conditionally applying a type annotation. For instance, the following value annotation hints that it should only be applied to slate devices:

	<ValueAnnotation Term="org.odata.display.DisplayName" Path="FirstName" Qualifier="org.odata.formfactor.Slate">

The value of the `edm:Qualifier` attribute is an arbitrary string.

An [`edm:Annotations`][csdl15.1] element MUST provide at most one value for the qualifier attribute.

Type or value annotations MUST provide at most one value for the qualifier attribute. Type or value annotations that are children of an annotations element MUST NOT provide a value for the qualifier attribute.

# 16	Vocabulary Expressions[csdl16]

Values for a value term or properties of a type term are obtained by calculating expressions. There are a variety of expressions that allow service authors to supply constant or dynamic values.

All vocabulary expressions may be specified as an element, for example:

	<ValueAnnotation Term="org.odata.display.DisplayName">
	 <String>Customers</String>
	</ValueAnnotation>

The constant expressions and the [`edm:Path`][csdl16.2.13] expression also support attribute notation:

	<ValueAnnotation Term="org.odata.display.DisplayName" String="Customers" />

## 16.1	Constant Expressions[csdl16.1]

Constant expressions allow the service author to supply an unchanging value to a value term or property of a type term.

The following examples show two value annotations intended as user interface hints:

	<EntitySet Name="Products" EntityType="ODataDemo.Product">
	 <ValueAnnotation Term="org.odata.display.DisplayName" String="Product Catalog" />
	</EntitySet>

	<EntitySet Name="Suppliers" EntityType="ODataDemo.Supplier">
	 <ValueAnnotation Term="org.odata.display.DisplayName" String="Supplier Directory" />
	</EntitySet>

### 16.1.1	The `edm:Binary` Constant Expression[csdl16.1.1]

The `edm:Binary` constant expression evaluates to a primitive binary value. A binary expression MUST be assigned a value of the type [`<xsHexBinary>`][csdl19]. 

A binary expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.Thumbnail" Binary="3f3c6d78206c" />

	<ValueAnnotation Term="org.odata.display.Thumbnail">
	 <Binary>3f3c6d78206c</Binary>
	</ValueAnnotation>

### 16.1.2	The `edm:Bool` Constant Expression[csdl16.1.2]

The `edm:Bool` constant expression evaluates to a primitive boolean value. A boolean expression MUST be assigned a value of the type [`<xsBoolean>`][csdl19].
 
A boolean expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.ReadOnly" Bool="true" />

	<ValueAnnotation Term="org.odata.display.ReadOnly">
	 <Bool>true</Bool>
	</ValueAnnotation>

### 16.1.3	The `edm:DateTime` Constant Expression[csdl16.1.3]

The `edm:DateTime` constant expression evaluates to a primitive date/time value. A date/time expression MUST be assigned a value of the type [`<xsDateTime>`][csdl19]. The UTC offset portion of this value MUST be discarded.

A date/time expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.LastUpdated" DateTime="2000-01-01T16:00:00.000" />

	<ValueAnnotation Term="org.odata.display.LastUpdated">
	 <DateTime>2000-01-01T16:00:00.000</DateTime>
	</ValueAnnotation>

### 16.1.4	The `edm:DateTimeOffset` Constant Expression[csdl16.1.4]

The `edm:DateTimeOffset` constant expression evaluates to a primitive date/time value with a UTC offset. An `edm:DateTimeOffset` expression MUST be assigned a value of the type [`<xsDateTime>`][csdl19]. 

An `edm:DateTimeOffset` expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.LastUpdated" DateTimeOffset="2000-01-01T16:00:00.000Z-09:00" />

	<ValueAnnotation Term="org.odata.display.LastUpdated">
	 <DateTime>2000-01-01T16:00:00.000Z-09:00</DateTime>
	</ValueAnnotation>

### 16.1.5	The `edm:Decimal` Constant Expression[csdl16.1.5]

The `edm:Decimal` constant expression evaluates to a primitive decimal value. A decimal expression MUST be assigned a value of the type [`<xsDecimal>`][csdl19]. 

A decimal expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.Width" Decimal="3.14" />

	<ValueAnnotation Term="org.odata.display.Width">
	 <Decimal>3.14</Decimal>
	</ValueAnnotation>

### 16.1.6	The `edm:Float` Constant Expression[csdl16.1.6]

The `edm:Float` constant expression evaluates to a primitive floating point (or double) value. A floating point expression MUST be assigned a value of the type [`<xsDouble>`][csdl19]. 

A floating point expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.Width" Float="3.14" />

	<ValueAnnotation Term="org.odata.display.Width">
	 <Float>3.14</Float>
	</ValueAnnotation>

### 16.1.7	The `edm:Guid` Constant Expression[csdl16.1.7]

The `edm:Guid` constant expression evaluates to a primitive 32-character string value. A guid expression MUST be assigned a value of the type [`<xsGuid>`][csdl19]. 

A guid expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.Id" Guid="21EC2020-3AEA-1069-A2DD-08002B30309D" />

	<ValueAnnotation Term="org.odata.display.Id">
	 <Guid>21EC2020-3AEA-1069-A2DD-08002B30309D</Guid>
	</ValueAnnotation>

### 16.1.8	The `edm:Int` Constant Expression[csdl16.1.8]

The `edm:Int` constant expression evaluates to a primitive integral value. An integral expression MUST be assigned a value of the type [`<xsInteger>`][csdl19]. 

An integral expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.Width" Int="42" />

	<ValueAnnotation Term="org.odata.display.Width">
	 <Int>42</Int>
	</ValueAnnotation>

### 16.1.9	The `edm:String` Constant Expression[csdl16.1.9]

The `edm:String` constant expression evaluates to a primitive string value. A string expression MUST be assigned a value of the type [`<xsString>`][csdl19]. 

A string expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.DisplayName" String="Product Catalog" />

	<ValueAnnotation Term="org.odata.display.DisplayName">
	 <String>Product Catalog</String>
	</ValueAnnotation>

### 16.1.10	The `edm:Time` Constant Expression[csdl16.1.10]

The `edm:Time` constant expression evaluates to a primitive time value. On platforms that do not support a primitive time value, the Time constant expression evaluates to a primitive date/time value. A time expression MUST be assigned a value of the type [`<xsTime>`][csdl19]. 

A time expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.EndTime" Time="21:00:00-08:00" />

	<ValueAnnotation Term="org.odata.display.EndTime">
	 <Time>21:00:00-08:00</Time>
	</ValueAnnotation>

## 16.2	Dynamic Expressions[csdl16.2]
### 16.2.1	The `edm:Apply` Expression[csdl16.2.1]

The `edm:Apply` expression enables a value to be obtained by applying a client-side function. An apply expression MUST assign a string value to the `edm:Function` attribute. The value of the function attribute SHOULD be a [`<qualifiedIdentifier>`][csdl19]. The value of the function attribute is used to locate the client-side function that should be applied.

The `edm:Apply` expression MUST contain zero or more expressions. The expressions contained within the apply expression are used as parameters to the function.

The apply expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.display.DisplayName">
	 <Apply Function="org.odata.commonfunctions.StringConcat">
	 <String>Product</String>
	 <String> </String>
	 <String>Catalog</String>
	 </Apply>
	</ValueAnnotation>

### 16.2.2	The `edm:AssertType` Expression[csdl16.2.2]

The `edm:AssertType` expression asserts that a value obtained from a child expression is of a specified type. The value calculated by the assert type expression is the value obtained from the child expression casted to the specified type.

The assert type expression MUST assign a value of the type [`<anySingleTypeIdentifier>`][csdl19] to the `edm:Type` attribute.

The `edm:AssertType` expression MUST contain exactly one expression. The expression contained within the assert type expression is used as a parameter to the type assertion.

The `edm:AssertType` expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.display.DisplayName">
	 <AssertType Type="Edm.String">
	 <String>Product Catalog</String>
	 </AssertType>
	</ValueAnnotation>

### 16.2.3	The `edm:Collection` Expression[csdl16.2.3]

The `edm:Collection` expression enables a value to be obtained from zero or more child expressions. The value calculated by the collection expression is the collection of the values calculated by each of the child expressions.

A collection expression MUST contain zero or more child expressions. The values of the child expressions MUST all be type compatible. Each child expression MUST be a constant expression or a [`edm:Record`][csdl16.2.15] expression.

A collection expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.seo.SeoTerms">
	 <Collection>
	 <String>Product</String>
	 <String>Supplier</String>
	 <String>Customer</String>
	 </Collection>
	</ValueAnnotation>

### 16.2.4	The `edm:EntitySetReference` Expression[csdl16.2.4]

The value of an `edm:EntitySetReference` is a reference to an entity set. A reference to an entity set is a collection of entities.

The `edm:EntitySetReference` expression MUST contain a value of the type [`<qualifiedIdentifier>`][csdl19]. The value of the entity set reference expression MUST resolve to an entity set.

The `edm:EntitySetReference` expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.seo.SaleProducts">
	 <EntitySetReference>Self.SaleProducts</EntitySetReference>
	</ValueAnnotation>

### 16.2.5	The `edm:EnumMemberReference` Expression[csdl16.2.5]

The value of an `edm:EnumMemberReference` is a reference to a member of an enumeration type.

The `edm:EnumMemberReference` expression MUST contain a value of the type [`<qualifiedIdentifier>`][csdl19]. The value of the enum member reference expression MUST resolve to a member of an enumeration type.

The `edm:EnumMemberReference` expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.address.Type">
	 <EnumMemberReference>org.odata.address.Type.Mailing</EnumMemberReference>
	</ValueAnnotation>

### 16.2.6	The `edm:FunctionReference` Expression[csdl16.2.6]

The value of a `edm:FunctionReference is a reference to the return type of a function.

The `edm:FunctionReference` expression MUST contain a value of the type [`<qualifiedName>`][csdl19]. The value of the function reference expression MUST resolve to a valid signature of a function.

The `edm:FunctionReference` expression MUST contain zero or more expressions. The expressions contained within the function reference expression are used to determine which overload of the function is being referenced.

The `edm:FunctionReference` expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.person.Age">
	 <FunctionReference Function="org.odata.person.GetAge">
	 <Path>BirthDate</Path>
	 </FunctionReference>
	</ValueAnnotation>

### 16.2.7	The `edm:If` Expression[csdl16.2.7]

The `edm:If` expression enables a value to be obtained by evaluating a conditional expression.

An if expression MUST contain exactly three child expressions. The first child expression is the conditional expression and MUST evaluate to a boolean result.

The second and third child expressions are the expressions which are evaluated conditionally. If the conditional expression evaluates to true, the second child expression MUST be evaluated and its value MUST be returned as the result of the `edm:If` expression. If the conditional expression evaluates to false, the third child expression MUST be evaluated and its value MUST be returned as the result of the `edm:If` expression.

The second child expression MUST return a value that is type compatible with the value returned from the third child expression.

The `edm:If` expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.person.Gender">
	 <If>
	 <Path>IsFemale</Path>
	 <String>Female</String>
	 <String>Male</String>
	 </If>
	</ValueAnnotation>

### 16.2.8	The `edm:IsType` Expression[csdl16.2.8]

The `edm:IsType` expression evaluates a child expression and returns a boolean value indicating whether the child expression returns the specified type. The is type expression MUST assign a value of the type [`<anySingleTypeIdentifier>`][csdl19] to the `edm:Type` attribute.

An `edm:IsType` expression MUST contain exactly one child expression. The is type expression MUST return true if the child expression returns a type that is compatible with the type named in the Type attribute. The is type expression MUST return false if the child expression returns a type that is not compatible with the type named in the `edm:Type` attribute.

The `edm:IsType` expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="Self.IsPreferredCustomer">
	 <IsType Type="Self.PreferredCustomer">
	  <Path>Customer</Path>
	 </IsType>
	</ValueAnnotation>

### 16.2.9	The `edm:LabeledElement` Expression[csdl16.2.9]

The `edm:LabeledElement` expression assigns a name to a child expression. The value of the child expression can then be reused elsewhere with an `edm:LabeledElementReference` expression. The labeled element expression MUST assign a value of the type [`<simpleIdentifier>`][csdl19] to the `edm:Name` attribute.

A labeled element expression MUST contain exactly one child expression written either in attribute notation or element notation. The value of the child expression is passed through the labeled element expression. The value of the child expression can also be accessed elsewhere by a labeled element reference expression.

A labeled element expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.display.DisplayName">
	 <LabeledElement Name="CustomerFirstName">
	  <Path>FirstName</Path>
	 </LabeledElement>
	</ValueAnnotation>

### 16.2.10	The `edm:LabeledElementReference` Expression[csdl16.2.10]

The `edm:LabeledElementReference` expression returns the value of a labeled element expression.

The labeled element reference expression MUST contain a value of the type [`<simpleIdentifier>`][csdl19]. The value of the [`<simpleIdentifier>`][csdl19] MUST resolve to a labeled element expression.

The `edm:LabeledElementReference` expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.display.DisplayName">
	 <LabeledElementReference>DisplayName</LabeledElement>
	</ValueAnnotation>

### 16.2.11	The `edm:Null` Expression[csdl16.2.11]

The `edm:Null` expression returns an untyped null value. The `edm:Null` expression MUST NOT contain any other elements or expressions.

The `edm:Null` expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.display.DisplayName">
	 <Null />
	</ValueAnnotation>

### 16.2.12	The `edm:ParameterReference` Expression[csdl16.2.12]

<!-- TODO -->

### 16.2.13	The `edm:Path` Expression[csdl16.2.13]

The `edm:Path` expression enables a value to be obtained by traversing an object graph. The `edm:Path` expression must be assigned a value of the type [`<pathString>`][csdl19].

The value assigned to the path expression MUST be composed of zero or more segments joined together by forward slashes. Each segment MUST represent a type cast, a property or a navigation property.

If the path segment represents a type cast, the segment MUST be of the type [`<qualifiedIdentifier>`][csdl19]. If the path segment represents a property or a navigation property, the segment MUST be of the type [`<simpleIdentifier>`][csdl19] and MUST resolve to a property or a navigation property of the same name.

If a path segment traverses a navigation property that has a cardinality of many, the path MUST NOT have any subsequent segments.

If the `edm:Path` expression is an empty string or an empty element, the path MUST refer to the containing object.

The `edm:Path` expression may be written with either element notation or attribute notation, as shown in the following examples:

	<ValueAnnotation Term="org.odata.display.DisplayName" Path="FirstName" />

	<ValueAnnotation Term="org.odata.display.DisplayName">
	 <Path>FirstName</Path>
	</ValueAnnotation>

### 16.2.14	The `edm:PropertyReference` Expression[csdl16.2.14]

The value of a `edm:PropertyReference` is a reference to a structural property.

The `edm:PropertyReference` expression MUST contain a value of the type [`<qualifiedName>`][csdl19]. The value of the function reference expression MUST resolve to a valid signature of a function.

The `edm:FunctionReference` expression MUST contain zero or more expressions. The expressions contained within the function reference expression are used to determine which overload of the function is being referenced.

The `edm:FunctionReference` expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.person.Age">
	 <FunctionReference Function="org.odata.person.GetAge">
	 <Path>BirthDate</Path>
	 </FunctionReference>
	</ValueAnnotation>

### 16.2.15	The `edm:Record` Expression[csdl16.2.15]

The `edm:Record` expression enables a new entity type or complex type to be constructed.

A record expression can specify a [`<simpleIdentifier>`][csdl19] or [`<qualifiedIdentifier>`][csdl19] value for the `edm:Type` attribute. If no value is specified for the type attribute, the type is derived from the expression’s context. If a value is specified, the value MUST resolve to an entity type or complex type in the entity model.

A record expression MUST contain zero or more [`edm:PropertyValue`][csdl15.3] elements.

A record expression MUST be written with element notation, as shown in the following example:

	<ValueAnnotation Term="org.odata.person.Employee">
	 <Record>
	  <PropertyValue Property="GivenName" Path="FirstName" />
	  <PropertyValue Property="Surname" Path="LastName" />
	 </Record>
	</ValueAnnotation>

### 16.2.16	The `edm:ValueTermReference` Expression[csdl16.2.16]

<!-- TODO -->

# 17	CSDL Examples[csdl17]

<!-- TODO: Say something about these two examples. -->

## 17.1	Title for example[csdl17.1]

	<edmx:Edmx xmlns:edmx="http://schemas.microsoft.com/ado/2007/06/edmx" Version="1.0">
	  <edmx:DataServices xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata"m:DataServiceVersion="2.0">
		<Schema xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata"xmlns="http://schemas.microsoft.com/ado/2007/05/edm" Namespace="ODataDemo">
		  <EntityType Name="Product">
			<Key>
			  <PropertyRef Name="ID"/>
			</Key>
			<Property Name="ID" Type="Edm.Int32" Nullable="false"/>
			<Property Name="Name" Type="Edm.String" Nullable="true" m:FC_TargetPath="SyndicationTitle"m:FC_ContentKind="text" m:FC_KeepInContent="false"/>
			<Property Name="Description" Type="Edm.String" Nullable="true" m:FC_TargetPath="SyndicationSummary"m:FC_ContentKind="text" m:FC_KeepInContent="false"/>
			<Property Name="ReleaseDate" Type="Edm.DateTime" Nullable="false"/>
			<Property Name="DiscontinuedDate" Type="Edm.DateTime" Nullable="true"/>
			<Property Name="Rating" Type="Edm.Int32" Nullable="false"/>
			<Property Name="Price" Type="Edm.Decimal" Nullable="false"/>
			<NavigationProperty Name="Category" Relationship="ODataDemo.Product_Category_Category_Products"FromRole="Product_Category" ToRole="Category_Products"/>
			<NavigationProperty Name="Supplier" Relationship="ODataDemo.Product_Supplier_Supplier_Products"FromRole="Product_Supplier" ToRole="Supplier_Products"/>
		  </EntityType>
		  <EntityType Name="Category">
			<Key>
			  <PropertyRef Name="ID"/>
			</Key>
			<Property Name="ID" Type="Edm.Int32" Nullable="false"/>
			<Property Name="Name" Type="Edm.String" Nullable="true" m:FC_TargetPath="SyndicationTitle"m:FC_ContentKind="text" m:FC_KeepInContent="true"/>
			<NavigationProperty Name="Products" Relationship="ODataDemo.Product_Category_Category_Products"FromRole="Category_Products" ToRole="Product_Category"/>
		  </EntityType>
		  <EntityType Name="Supplier">
			<Key>
			  <PropertyRef Name="ID"/>
			</Key>
			<Property Name="ID" Type="Edm.Int32" Nullable="false"/>
			<Property Name="Name" Type="Edm.String" Nullable="true" m:FC_TargetPath="SyndicationTitle"m:FC_ContentKind="text" m:FC_KeepInContent="true"/>
			<Property Name="Address" Type="ODataDemo.Address" Nullable="false"/>
			<Property Name="Concurrency" Type="Edm.Int32" Nullable="false" ConcurrencyMode="Fixed"/>
			<NavigationProperty Name="Products" Relationship="ODataDemo.Product_Supplier_Supplier_Products"FromRole="Supplier_Products" ToRole="Product_Supplier"/>
		  </EntityType>
		  <ComplexType Name="Address">
			<Property Name="Street" Type="Edm.String" Nullable="true"/>
			<Property Name="City" Type="Edm.String" Nullable="true"/>
			<Property Name="State" Type="Edm.String" Nullable="true"/>
			<Property Name="ZipCode" Type="Edm.String" Nullable="true"/>
			<Property Name="Country" Type="Edm.String" Nullable="true"/>
		  </ComplexType>
		  <Association Name="Product_Category_Category_Products">
			<End Role="Product_Category" Type="ODataDemo.Product" Multiplicity="*"/>
			<End Role="Category_Products" Type="ODataDemo.Category" Multiplicity="0..1"/>
		  </Association>
		  <Association Name="Product_Supplier_Supplier_Products">
			<End Role="Product_Supplier" Type="ODataDemo.Product" Multiplicity="*"/>
			<End Role="Supplier_Products" Type="ODataDemo.Supplier" Multiplicity="0..1"/>
		  </Association>
		  <EntityContainer Name="DemoService" m:IsDefaultEntityContainer="true">
			<EntitySet Name="Products" EntityType="ODataDemo.Product"/>
			<EntitySet Name="Categories" EntityType="ODataDemo.Category"/>
			<EntitySet Name="Suppliers" EntityType="ODataDemo.Supplier"/>
			<AssociationSet Name="Products_Category_Categories"Association="ODataDemo.Product_Category_Category_Products">
			  <End Role="Product_Category" EntitySet="Products"/>
			  <End Role="Category_Products" EntitySet="Categories"/>
			</AssociationSet>
			<AssociationSet Name="Products_Supplier_Suppliers"Association="ODataDemo.Product_Supplier_Supplier_Products">
			  <End Role="Product_Supplier" EntitySet="Products"/>
			  <End Role="Supplier_Products" EntitySet="Suppliers"/>
			</AssociationSet>
			<FunctionImport Name="GetProductsByRating" EntitySet="Products"ReturnType="Collection(ODataDemo.Product)" m:HttpMethod="GET">
			  <Parameter Name="rating" Type="Edm.Int32" Mode="In"/>
			</FunctionImport>
		  </EntityContainer>
		</Schema>
	  </edmx:DataServices>
	</edmx:Edmx>

## 17.2 Title for example[csdl17.2]

	<Schema xmlns=" http://schemas.microsoft.com/ado/2009/11/edm " Namespace="Model1" Alias="Self">
	  <Using Alias="Vocabulary1" Namespace="Vocabulary1" />
	  <EntityContainer Name="Model1Container" >
		<EntitySet Name="CustomerSet" EntityType="Model1.Customer" />
		<EntitySet Name="OrderSet" EntityType="Model1.Order" />
		<AssociationSet Name="CustomerOrder" Association="Model1.CustomerOrder">
		  <End Role="Customer" EntitySet="CustomerSet" />
		  <End Role="Order" EntitySet="OrderSet" />
		</AssociationSet>
	  </EntityContainer>
	  <Annotations Target="Self.Customer">
		<ValueAnnotation Term="Vocabulary1.EMail">
		  <Null />
		</ValueAnnotation>
		<ValueAnnotation Term="AccountID" Path="AccountNumber" />
		<ValueAnnotation Term="Title" String="Customer Info"/>
	  </Annotations>
	  <EntityType Name="Customer">
		<Key>
		  <PropertyRef Name="CustomerId" />
		</Key>
		<Property Name="CustomerId" Type="Int32" Nullable="false" />
		<Property Name="FirstName" Type="String" Nullable="true" />
		<Property Name="LastName" Type="String" Nullable="true" />
		<Property Name="AccountNumber" Type="Int32" Nullable="true" />
		<Property Name="Address" Type="Self.Address" Nullable="false" />
		<NavigationProperty Name="Orders" Relationship="Model1.CustomerOrder" FromRole="Customer" ToRole="Order" />
		<TypeAnnotation Term="Vocabulary1.Person">
		  <ValueAnnotation Term="DisplayName">
			<Apply Function="String.Concat">
			  <Path>FirstName</Path>
			  <Path>LastName</Path>
			</Apply>
		  </ValueAnnotation>
		</TypeAnnotation>
	  </EntityType>
	  <EntityType Name="Order">
		<Key>
		  <PropertyRef Name="OrderId" />
		</Key>
		<Property Name="OrderId" Type="Int32" Nullable="false" />
		<Property Name="OrderDate" Type="Int32" Nullable="true" />
		<Property Name="Description" Type=" String" Nullable="true" />
		<NavigationProperty Name="Customer" Relationship="Model1.CustomerOrder" FromRole="Order" ToRole="Customer" />
	  </EntityType>
	  <EntityType Name="SalesOrder" BaseType="Self.Order">
		<Property Name="Paid" Type="Boolean" Nullable="false" />
	  </EntityType>
	  <EntityType OpenType="true" Name="Product">
		<Key>
		  <PropertyRef Name="ProductId" />
		</Key>
		<Property Name="ProductId" Type="Int32" Nullable="false" />
		<Property Name="Name" Type="String" Nullable="false" />
		<Property Name="Description" Type="String" Nullable="true" />
	  </EntityType>
	  <Association Name="CustomerOrder">
		<End Type="Model1.Customer" Role="Customer" Multiplicity="1" />
		<End Type="Model1.Order" Role="Order" Multiplicity="*" />
	  </Association>
	  <ComplexType Name="Address">
		<Property Name="Street" Type="String" Nullable="false" />
		<Property Name="City" Type="String" Nullable="false" />
		<Property Name="State" Type="String" Nullable="false" />
		<Property Name="Zip" Type="String" Nullable="false" />
		<Property Name="Position" Type="GeographyPoint" Nullable="false" SRID="4326" />
	  </ComplexType>
	</Schema>

# 18	Informative XSD for CSDL[csdl18]

	<?xml version="1.0" encoding="utf-8"?>
	<xs:schema elementFormDefault="qualified" attributeFormDefault="unqualified" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:annotation="http://schemas.microsoft.com/ado/2009/02/edm/annotation" xmlns:cg="http://schemas.microsoft.com/ado/2006/04/codegeneration" xmlns:edm="http://schemas.microsoft.com/ado/2009/11/edm" targetNamespace="http://schemas.microsoft.com/ado/2009/11/edm">
	  <xs:annotation>
		<xs:documentation xml:lang="en">
		  Common Data Model Schema Definition Language.
		  Copyright (c) Microsoft Corp. All rights reserved.
		</xs:documentation>
	  </xs:annotation>
	  <xs:import namespace="http://schemas.microsoft.com/ado/2006/04/codegeneration" schemaLocation="System.Data.Resources.CodeGenerationSchema.xsd" />
	  <xs:import namespace="http://schemas.microsoft.com/ado/2009/02/edm/annotation" schemaLocation="System.Data.Resources.AnnotationSchema.xsd" />
	  <xs:element name="Schema" type="edm:TSchema" />
	  <xs:complexType name="TSchema">
		<xs:sequence>
		  <xs:group ref="edm:GSchemaBodyElements" minOccurs="0" maxOccurs="unbounded" />
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Namespace" type="edm:TNamespaceName" use="optional" />
		<xs:attribute name="Alias" type="edm:TSimpleIdentifier" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:group name="GSchemaBodyElements">
		<xs:choice>
		  <xs:element name="Using" type="edm:TUsing" minOccurs="0" maxOccurs="unbounded" />
		  <xs:element name="Association" type="edm:TAssociation" minOccurs="0" maxOccurs="unbounded" />
		  <xs:element name="ComplexType" type="edm:TComplexType" minOccurs="0" maxOccurs="unbounded" />
		  <xs:element name="EntityType" type="edm:TEntityType" minOccurs="0" maxOccurs="unbounded" />
		  <xs:element name="EnumType" type="edm:TEnumType" minOccurs="0" maxOccurs="unbounded" />
		  <xs:element name="ValueTerm" type="edm:TValueTerm" minOccurs="0" maxOccurs="unbounded" />
		  <xs:element name="Function" type="edm:TFunction" minOccurs="0" maxOccurs="unbounded" />
		  <xs:element name="Annotations" type="edm:TAnnotations" minOccurs="0" maxOccurs="unbounded" />
		  <xs:element ref="edm:EntityContainer" minOccurs="1" maxOccurs="1" />
		</xs:choice>
	  </xs:group>
	  <!-- EDM SimpleType instances for use by EDM Instance documents-->
	  <xs:simpleType name="EDMSimpleType">
		<xs:restriction base="xs:string">
		  <xs:enumeration value="Binary" />
		  <xs:enumeration value="Boolean" />
		  <xs:enumeration value="Byte" />
		  <xs:enumeration value="DateTime" />
		  <xs:enumeration value="DateTimeOffset" />
		  <xs:enumeration value="Time" />
		  <xs:enumeration value="Decimal" />
		  <xs:enumeration value="Double" />
		  <xs:enumeration value="Single" />
		  <xs:enumeration value="Geography" />
		  <xs:enumeration value="GeographyPoint" />
		  <xs:enumeration value="GeographyLineString" />
		  <xs:enumeration value="GeographyPolygon" />
		  <xs:enumeration value="GeographyMultiPoint" />
		  <xs:enumeration value="GeographyMultiLineString" />
		  <xs:enumeration value="GeographyMultiPolygon" />
		  <xs:enumeration value="GeographyCollection" />
		  <xs:enumeration value="Geometry" />
		  <xs:enumeration value="GeometryPoint" />
		  <xs:enumeration value="GeometryLineString" />
		  <xs:enumeration value="GeometryPolygon" />
		  <xs:enumeration value="GeometryMultiPoint" />
		  <xs:enumeration value="GeometryMultiLineString" />
		  <xs:enumeration value="GeometryMultiPolygon" />
		  <xs:enumeration value="GeometryCollection" />
		  <xs:enumeration value="Guid" />
		  <xs:enumeration value="Int16" />
		  <xs:enumeration value="Int32" />
		  <xs:enumeration value="Int64" />
		  <xs:enumeration value="String" />
		  <xs:enumeration value="SByte" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TMax">
		<xs:restriction base="xs:string">
		  <xs:enumeration value="Max" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TVariable">
		<xs:restriction base="xs:string">
		  <xs:enumeration value="Variable" />
		</xs:restriction>
	  </xs:simpleType>
	  <!-- Facets for Primitive types -->
	  <xs:simpleType name="TMaxLengthFacet">
		<xs:union memberTypes="edm:TMax xs:nonNegativeInteger  " />
	  </xs:simpleType>
	  <xs:simpleType name="TIsFixedLengthFacet">
		<xs:restriction base="xs:boolean" />
	  </xs:simpleType>
	  <xs:simpleType name="TPrecisionFacet">
		<xs:restriction base="xs:nonNegativeInteger" />
	  </xs:simpleType>
	  <xs:simpleType name="TScaleFacet">
		<xs:restriction base="xs:nonNegativeInteger" />
	  </xs:simpleType>
	  <xs:simpleType name="TIsUnicodeFacet">
		<xs:restriction base="xs:boolean" />
	  </xs:simpleType>
	  <xs:simpleType name="TCollationFacet">
		<xs:restriction base="xs:string" />
	  </xs:simpleType>
	  <xs:simpleType name="TSridFacet">
		<xs:union memberTypes="edm:TVariable xs:nonNegativeInteger  " />
	  </xs:simpleType>
	  <!--
			types at all levels
		-->
	  <xs:complexType name="TDocumentation">
		<xs:annotation>
		  <xs:documentation>The Documentation element is used to provide documentation of comments on the contents of the XML file.  It is valid under Schema, Type, Index and Relationship elements.</xs:documentation>
		</xs:annotation>
		<xs:sequence>
		  <xs:element name="Summary" type="edm:TText" minOccurs="0" maxOccurs="1" />
		  <xs:element name="LongDescription" type="edm:TText" minOccurs="0" maxOccurs="1" />
		</xs:sequence>
		<xs:anyAttribute processContents="lax" namespace="##other" />
	  </xs:complexType>
	  <xs:complexType name="TText" mixed="true">
		<xs:sequence>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:anyAttribute processContents="lax" namespace="##other" />
	  </xs:complexType>
	  <xs:complexType name="TXmlOrText" mixed="true">
		<xs:annotation>
		  <xs:documentation>This type allows pretty much any content</xs:documentation>
		</xs:annotation>
		<xs:sequence>
		  <xs:any namespace="##any" processContents="skip" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:anyAttribute processContents="skip" namespace="##any" />
	  </xs:complexType>
	  <!-- 
			types of the top level elements 
		-->
	  <xs:complexType name="TUsing">
		<xs:sequence>
		  <xs:group ref="edm:GEmptyElementExtensibility" minOccurs="0" maxOccurs="1" />
		</xs:sequence>
		<xs:attribute name="Namespace" type="edm:TNamespaceName" use="required" />
		<xs:attribute name="Alias" type="edm:TSimpleIdentifier" use="required" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TAssociation">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:element name="End" type="edm:TAssociationEnd"  minOccurs="2" maxOccurs="2" />
		  <xs:element name="ReferentialConstraint" type="edm:TConstraint" minOccurs="0" maxOccurs="1" />
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TComplexType">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="Property" type="edm:TComplexTypeProperty" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attributeGroup ref="edm:TTypeAttributes" />
		<xs:attribute ref="cg:TypeAccess" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TConstraint">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:element name="Principal" type="edm:TReferentialConstraintRoleElement" minOccurs="1" maxOccurs="1" />
		  <xs:element name="Dependent" type="edm:TReferentialConstraintRoleElement" minOccurs="1" maxOccurs="1" />
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TReferentialConstraintRoleElement">
		<xs:sequence>
		  <xs:element name="PropertyRef" type="edm:TPropertyRef" minOccurs="1" maxOccurs="unbounded" />
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Role" type="edm:TSimpleIdentifier" use="required" />
	  </xs:complexType>
	  <xs:complexType name="TNavigationProperty">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="Relationship" type="edm:TQualifiedName" use="required" />
		<xs:attribute name="ToRole" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="FromRole" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="ContainsTarget" type="xs:boolean" use="optional" />
		<xs:attribute ref="cg:GetterAccess" use="optional" />
		<xs:attribute ref="cg:SetterAccess" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TEntityType">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:element name="Key" type="edm:TEntityKeyElement" minOccurs="0" maxOccurs="1" />
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="Property" type="edm:TEntityProperty" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="NavigationProperty" type="edm:TNavigationProperty" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attributeGroup ref="edm:TDerivableTypeAttributes" />
		<xs:attribute name="OpenType" type="xs:boolean" use="optional" default="false" />
		<xs:attribute ref="cg:TypeAccess" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TEnumTypeMember">
		<xs:sequence>
		  <xs:group ref="edm:GEmptyElementExtensibility" minOccurs="0" maxOccurs="1" />
		</xs:sequence>
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="Value" type="xs:long" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TEnumType">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="Member" type="edm:TEnumTypeMember" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attributeGroup ref="edm:TTypeAttributes" />
		<xs:attribute name="IsFlags" type="xs:boolean" use="optional" />
		<xs:attribute name="UnderlyingType" type="edm:TPropertyType" use="optional" />
		<xs:attribute ref="cg:TypeAccess" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TFunction">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="Parameter" type="edm:TFunctionParameter" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="DefiningExpression" type="edm:TCommandText" minOccurs="0" maxOccurs="1" />
			<xs:element name="ReturnType" type="edm:TFunctionReturnType" minOccurs="0" maxOccurs="1" />
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="ReturnType" type="edm:TWrappedFunctionType" use="optional" />
		<xs:attributeGroup ref="edm:TFacetAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TFunctionParameter">
		<xs:sequence>
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:choice minOccurs="0" maxOccurs="1">
			  <xs:element name="CollectionType" type="edm:TCollectionType" minOccurs="0" maxOccurs="1" />
			  <xs:element name="ReferenceType" type="edm:TReferenceType" minOccurs="0" maxOccurs="1" />
			  <xs:element name="RowType" type="edm:TRowType" minOccurs="0" maxOccurs="1" />
			</xs:choice>
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="Type" type="edm:TWrappedFunctionType" use="optional" />
		<xs:attributeGroup ref="edm:TFacetAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TCollectionType">
		<xs:sequence minOccurs ="1" maxOccurs="1">
		  <xs:choice minOccurs="0" maxOccurs="1">
			<xs:element name="CollectionType" type="edm:TCollectionType" minOccurs="0" maxOccurs="1" />
			<xs:element name="ReferenceType" type="edm:TReferenceType" minOccurs="0" maxOccurs="1" />
			<xs:element name="RowType" type="edm:TRowType" minOccurs="0" maxOccurs="1" />
			<xs:element name="TypeRef" type="edm:TTypeRef" minOccurs="0" maxOccurs="1" />
		  </xs:choice>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="ElementType" type="edm:TUnwrappedFunctionType" use="optional" />
		<xs:attributeGroup ref="edm:TFacetAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TTypeRef">
		<xs:sequence>
		  <xs:group ref="edm:GEmptyElementExtensibility" minOccurs="0" maxOccurs="1" />
		</xs:sequence>
		<xs:attribute name="Type" type="edm:TUnwrappedFunctionType" use="required" />
		<xs:attributeGroup ref="edm:TFacetAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TReferenceType">
		<xs:sequence>
		  <xs:group ref="edm:GEmptyElementExtensibility" minOccurs="0" maxOccurs="1" />
		</xs:sequence>
		<xs:attribute name="Type" type="edm:TUnwrappedFunctionType" use="required" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TRowType">
		<xs:choice minOccurs="1" maxOccurs="unbounded">
		  <xs:element name="Property" type="edm:TRowProperty" minOccurs="0" maxOccurs="1" />
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:choice>
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TRowProperty">
		<xs:sequence>
		  <xs:choice minOccurs="0" maxOccurs="1">
			<xs:element name="CollectionType" type="edm:TCollectionType" minOccurs="0" maxOccurs="1" />
			<xs:element name="ReferenceType" type="edm:TReferenceType" minOccurs="0" maxOccurs="1" />
			<xs:element name="RowType" type="edm:TRowType" minOccurs="0" maxOccurs="1" />
		  </xs:choice>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="Type" type="edm:TWrappedFunctionType" use="optional" />
		<xs:attributeGroup ref="edm:TFacetAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TFunctionReturnType">
		<xs:sequence>
		  <xs:choice minOccurs="0" maxOccurs="1">
			<xs:element name="CollectionType" type="edm:TCollectionType" minOccurs="0" maxOccurs="1" />
			<xs:element name="ReferenceType" type="edm:TReferenceType" minOccurs="0" maxOccurs="1" />
			<xs:element name="RowType" type="edm:TRowType" minOccurs="0" maxOccurs="1" />
		  </xs:choice>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Type" type="edm:TFunctionImportParameterAndReturnType" use="optional" />
		<xs:attributeGroup ref="edm:TFacetAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TFunctionImportReturnType">
		<xs:sequence>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Type" type="edm:TFunctionImportParameterAndReturnType" use="optional" />
		<!-- EntitySet and EntitySetPath are mutually exclusive. -->
		<xs:attribute name="EntitySet" type="edm:TSimpleIdentifier" use="optional" />
		<xs:attribute name="EntitySetPath" type="edm:TPath" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TEntityKeyElement">
		<xs:sequence>
		  <xs:element name="PropertyRef" type="edm:TPropertyRef" minOccurs="1" maxOccurs="unbounded" />
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
	  </xs:complexType>
	  <xs:complexType name="TPropertyRef">
		<xs:sequence>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
	  </xs:complexType>
	  <xs:group name="GEmptyElementExtensibility">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
	  </xs:group>

	  <!--
			Vocabulary annotations.
	  -->
	  <xs:complexType name="TAnnotations">
		<xs:sequence>
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attribute name="Target" type="edm:TPath" use="required" />
		<xs:attribute name="Qualifier" type="xs:string" use="optional" />
	  </xs:complexType>
	  <xs:complexType name="TValueAnnotation">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:group ref="edm:GExpression" minOccurs="1" maxOccurs="1" />
		</xs:sequence>
		<xs:attribute name="Term" type="edm:TQualifiedName" use="required" />
		<xs:attribute name="Qualifier" type="xs:string" use="optional" />
		<xs:attributeGroup ref="edm:GInlineExpressions" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TTypeAnnotation">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="PropertyValue" type="edm:TPropertyValue" minOccurs="0" maxOccurs="unbounded" />
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attribute name="Term" type="edm:TQualifiedName" use="required" />
		<xs:attribute name="Qualifier" type="xs:string" use="optional" />
		<xs:attributeGroup ref="edm:GInlineExpressions" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:group name="GExpression">
		<xs:sequence>
		  <!-- Logically this group means one of the expressions plus an arbitrary number of CSDL annotations,
			   syntactically we have to make the inner sequence unbounded to allow elements in any order. -->
		  <xs:sequence maxOccurs="unbounded">
			<xs:choice>
			  <xs:element name="String" type="edm:TStringConstantExpression" minOccurs="0" />
			  <xs:element name="Binary" type="edm:TBinaryConstantExpression" minOccurs="0" />
			  <xs:element name="Int" type="edm:TIntConstantExpression" minOccurs="0" />
			  <xs:element name="Float" type="edm:TFloatConstantExpression" minOccurs="0" />
			  <xs:element name="Guid" type="edm:TGuidConstantExpression" minOccurs="0" />
			  <xs:element name="Decimal" type="edm:TDecimalConstantExpression" minOccurs="0" />
			  <xs:element name="Bool" type="edm:TBoolConstantExpression" minOccurs="0" />
			  <xs:element name="Time" type="edm:TTimeConstantExpression" minOccurs="0" />
			  <xs:element name="DateTime" type="edm:TDateTimeConstantExpression" minOccurs="0" />
			  <xs:element name="DateTimeOffset" type="edm:TDateTimeOffsetConstantExpression" minOccurs="0" />
			  <xs:element name="EnumMemberReference" type="edm:TEnumMemberReferenceExpression" minOccurs="0" />
			  <xs:element name="Null" type="edm:TNullExpression" minOccurs="0" />
			  <xs:element name="Path" type="edm:TPathExpression" minOccurs="0" />
			  <xs:element name="If" type="edm:TIfExpression" minOccurs="0" />
			  <xs:element name="Record" type="edm:TRecordExpression" minOccurs="0" />
			  <xs:element name="Collection" type="edm:TCollectionExpression" minOccurs="0" />
			  <xs:element name="AssertType" type="edm:TAssertTypeExpression" minOccurs="0" />
			  <xs:element name="IsType" type="edm:TIsTypeExpression" minOccurs="0" />
			  <xs:element name="FunctionReference" type="edm:TFunctionReferenceExpression" minOccurs="0" />
			  <xs:element name="EntitySetReference" type="edm:TEntitySetReferenceExpression" minOccurs="0" />
			  <xs:element name="ParameterReference" type="edm:TParameterReferenceExpression" minOccurs="0" />
			  <xs:element name="Apply" type="edm:TApplyExpression" minOccurs="0" />
			  <xs:element name="PropertyReference" type="edm:TPropertyReferenceExpression" minOccurs="0" />
			  <xs:element name="ValueTermReference" type="edm:TValueTermReferenceExpression" minOccurs="0" />
			  <xs:element name="LabeledElement" type="edm:TLabeledElement" minOccurs="0" />
			  <xs:element name="LabeledElementReference" type="edm:TLabeledElementReferenceExpression" minOccurs="0" />
			</xs:choice>
			<xs:any namespace="##other" processContents="lax" minOccurs="0" />
		  </xs:sequence>
		</xs:sequence>
	  </xs:group>
	  <xs:attributeGroup name="GInlineExpressions">
		<xs:attribute name="String" type="xs:string" use="optional" />
		<xs:attribute name="Binary" type="xs:hexBinary" use="optional" />
		<xs:attribute name="Int" type="xs:integer" use="optional" />
		<xs:attribute name="Float" type="xs:double" use="optional" />
		<xs:attribute name="Guid" type="edm:TGuidLiteral" use="optional" />
		<xs:attribute name="Decimal" type="xs:decimal" use="optional" />
		<xs:attribute name="Bool" type="xs:boolean" use="optional" />
		<xs:attribute name="Time" type="xs:time" use="optional" />
		<xs:attribute name="DateTime" type="xs:dateTime" use="optional" />
		<xs:attribute name="DateTimeOffset" type="xs:dateTime" use="optional" />
		<xs:attribute name="Path" type="edm:TPath" use="optional" />
	  </xs:attributeGroup>
	  <xs:complexType name="TStringConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="xs:string">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TBinaryConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="xs:hexBinary">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TIntConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="xs:integer">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TFloatConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="xs:double">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TGuidConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="edm:TGuidLiteral">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:simpleType name="TGuidLiteral">
		<xs:restriction base="xs:string">
		  <xs:pattern value="[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}"/>
		</xs:restriction>
	  </xs:simpleType>
	  <xs:complexType name="TDecimalConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="xs:decimal">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TBoolConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="xs:boolean">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TTimeConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="xs:time">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TDateTimeConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="xs:dateTime">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TDateTimeOffsetConstantExpression">
		<xs:simpleContent>
		  <xs:extension base="xs:dateTime">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TEnumMemberReferenceExpression">
		<xs:simpleContent>
		  <xs:extension base="edm:TPath">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TNullExpression">
		<xs:sequence>
		  <xs:group ref="edm:GEmptyElementExtensibility" minOccurs="0" maxOccurs="1" />
		</xs:sequence>
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TPathExpression">
		<xs:simpleContent>
		  <xs:extension base="edm:TPath">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TIfExpression">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <!-- Test, IfTrue, IfFalse -->
		  <xs:group ref="edm:GExpression" minOccurs="3" maxOccurs="3" />
		</xs:sequence>
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TRecordExpression">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="PropertyValue" type="edm:TPropertyValue" minOccurs="0" maxOccurs="unbounded" />
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attribute name="Type" type="edm:TUnwrappedFunctionType" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TPropertyValue">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:group ref="edm:GExpression" minOccurs="1" maxOccurs="1" />
		</xs:sequence>
		<xs:attribute name="Property" type="edm:TSimpleIdentifier" use="required" />
		<xs:attributeGroup ref="edm:GInlineExpressions" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TCollectionExpression">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:group ref="edm:GExpression" minOccurs="0" maxOccurs="unbounded"/>
		</xs:sequence>
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TAssertTypeExpression">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice maxOccurs="unbounded">
			<xs:group ref="edm:GExpression" minOccurs="1" maxOccurs="1" />
			<xs:choice minOccurs="0" maxOccurs="1">
			  <xs:element name="CollectionType" type="edm:TCollectionType" minOccurs="0" maxOccurs="1" />
			  <xs:element name="ReferenceType" type="edm:TReferenceType" minOccurs="0" maxOccurs="1" />
			  <xs:element name="RowType" type="edm:TRowType" minOccurs="0" maxOccurs="1" />
			</xs:choice>
		  </xs:choice>
		</xs:sequence>
		<xs:attribute name="Type" type="edm:TWrappedFunctionType" use="optional" />
		<xs:attributeGroup ref="edm:TFacetAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TIsTypeExpression">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice maxOccurs="unbounded">
			<xs:group ref="edm:GExpression" minOccurs="1" maxOccurs="1" />
			<xs:choice minOccurs="0" maxOccurs="1">
			  <xs:element name="CollectionType" type="edm:TCollectionType" minOccurs="0" maxOccurs="1" />
			  <xs:element name="ReferenceType" type="edm:TReferenceType" minOccurs="0" maxOccurs="1" />
			  <xs:element name="RowType" type="edm:TRowType" minOccurs="0" maxOccurs="1" />
			</xs:choice>
		  </xs:choice>
		</xs:sequence>
		<xs:attribute name="Type" type="edm:TWrappedFunctionType" use="optional" />
		<xs:attributeGroup ref="edm:TFacetAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TFunctionReferenceExpression">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice maxOccurs="unbounded">
			<!-- Parameter is used to complete function signature: type only. -->
			<xs:element name="Parameter" maxOccurs="unbounded">
			  <xs:complexType>
				<xs:choice maxOccurs="unbounded">
				  <xs:choice minOccurs="0" maxOccurs="1">
					<xs:element name="CollectionType" type="edm:TCollectionType" minOccurs="0" maxOccurs="1" />
					<xs:element name="ReferenceType" type="edm:TReferenceType" minOccurs="0" maxOccurs="1" />
					<xs:element name="RowType" type="edm:TRowType" minOccurs="0" maxOccurs="1" />
				  </xs:choice>
				  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
				</xs:choice>
				<xs:attribute name="Type" type="edm:TWrappedFunctionType" use="optional" />
				<xs:anyAttribute namespace="##other" processContents="lax" />
			  </xs:complexType>
			</xs:element>
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attribute name="Function" type="edm:TQualifiedName" use="required" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TEntitySetReferenceExpression">
		<xs:simpleContent>
		  <xs:extension base="edm:TPath">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TParameterReferenceExpression">
		<xs:simpleContent>
		  <xs:extension base="edm:TSimpleIdentifier">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>
	  <xs:complexType name="TApplyExpression">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:group ref="edm:GExpression" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Function" type="edm:TQualifiedName" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TPropertyReferenceExpression">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:group ref="edm:GExpression" minOccurs="1" maxOccurs="1"/>
		</xs:sequence>
		<xs:attribute name="Property" type="edm:TSimpleIdentifier" use="required" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TValueTermReferenceExpression">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:group ref="edm:GExpression" minOccurs="1" maxOccurs="1"/>
		</xs:sequence>
		<xs:attribute name="Term" type="edm:TQualifiedName" use="required" />
		<xs:attribute name="Qualifier" type="edm:TSimpleIdentifier" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TLabeledElement">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:group ref="edm:GExpression" minOccurs="1" maxOccurs="1" />
		</xs:sequence>
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TLabeledElementReferenceExpression">
		<xs:simpleContent>
		  <xs:extension base="edm:TSimpleIdentifier">
			<xs:anyAttribute namespace="##other" processContents="lax" />
		  </xs:extension>
		</xs:simpleContent>
	  </xs:complexType>

	  <!-- 
			base types  
		-->
	  <xs:complexType name="TAssociationEnd">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:group ref="edm:TOperations" minOccurs="0" maxOccurs="unbounded" />
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Type" type="edm:TQualifiedName" use="required" />
		<xs:attribute name="Role" type="edm:TSimpleIdentifier" use="optional" />
		<xs:attribute name="Multiplicity" type="edm:TMultiplicity" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:group name="TOperations">
		<xs:choice>
		  <xs:element name="OnDelete" type="edm:TOnAction" maxOccurs="1" minOccurs="0" />
		</xs:choice>
	  </xs:group>
	  <xs:complexType name="TOnAction">
		<xs:sequence>
		  <xs:group ref="edm:GEmptyElementExtensibility" minOccurs="0" maxOccurs="1" />
		</xs:sequence>
		<xs:attribute name="Action" type="edm:TAction" use="required" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TEntityProperty">
		<xs:sequence>
		  <xs:choice maxOccurs="unbounded">
			<xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attributeGroup ref="edm:TCommonPropertyAttributes" />
		<xs:attribute ref="annotation:StoreGeneratedPattern" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TComplexTypeProperty">
		<xs:sequence>
		  <xs:choice maxOccurs="unbounded">
			<xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attributeGroup ref="edm:TCommonPropertyAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TValueTerm">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="CollectionType" type="edm:TCollectionType" minOccurs="0" maxOccurs="1" />
			<xs:element name="ReferenceType" type="edm:TReferenceType" minOccurs="0" maxOccurs="1" />
			<xs:element name="RowType" type="edm:TRowType" minOccurs="0" maxOccurs="1" />
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		</xs:sequence>
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="Type" type="edm:TWrappedFunctionType" use="optional" />
		<xs:attributeGroup ref="edm:TFacetAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>
	  <xs:complexType name="TFunctionImportParameter">
		<xs:sequence>
		  <xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
		  <xs:choice minOccurs="0" maxOccurs="unbounded">
			<xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:choice>
		</xs:sequence>
		<xs:attributeGroup ref="edm:TFunctionImportParameterAttributes" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:complexType>

	  <xs:attributeGroup name="TFacetAttributes">
		<xs:attribute name="Nullable" type="xs:boolean" use="optional" />
		<xs:attribute name="DefaultValue" type="xs:string" use="optional" />
		<xs:attribute name="MaxLength" type="edm:TMaxLengthFacet" use="optional" />
		<xs:attribute name="FixedLength" type="edm:TIsFixedLengthFacet" use="optional" />
		<xs:attribute name="Precision" type="edm:TPrecisionFacet" use="optional" />
		<xs:attribute name="Scale" type="edm:TScaleFacet" use="optional" />
		<xs:attribute name="Unicode" type="edm:TIsUnicodeFacet" use="optional" />
		<xs:attribute name="Collation" type="edm:TCollationFacet" use="optional" />
		<xs:attribute name="SRID" type="edm:TSridFacet" use="optional" />
	  </xs:attributeGroup>

	  <xs:attributeGroup name="TCommonPropertyAttributes">
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="Type" type="edm:TPropertyType" use="required" />
		<xs:attribute name="Nullable" type="xs:boolean" default="true" use="optional" />
		<xs:attribute name="DefaultValue" type="xs:string" use="optional" />
		<!-- Start Facets -->
		<xs:attribute name="MaxLength" type="edm:TMaxLengthFacet" use="optional" />
		<xs:attribute name="FixedLength" type="edm:TIsFixedLengthFacet" use="optional" />
		<xs:attribute name="Precision" type="edm:TPrecisionFacet" use="optional" />
		<xs:attribute name="Scale" type="edm:TScaleFacet" use="optional" />
		<xs:attribute name="Unicode" type="edm:TIsUnicodeFacet" use="optional" />
		<xs:attribute name="Collation" type="edm:TCollationFacet" use="optional" />
		<xs:attribute name="SRID" type="edm:TSridFacet" use="optional" />
		<!--End Facets -->
		<xs:attribute name="ConcurrencyMode" type="edm:TConcurrencyMode" use="optional" />
		<xs:attribute ref="cg:SetterAccess" use="optional" />
		<xs:attribute ref="cg:GetterAccess" use="optional" />
	  </xs:attributeGroup>
	  <xs:attributeGroup name="TFunctionImportParameterAttributes">
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="Type" type="edm:TFunctionImportParameterAndReturnType" use="required" />
		<xs:attribute name="Mode" type="edm:TParameterMode" use="optional" />
		<xs:attribute name="Nullable" type="xs:boolean" use="optional" />
		<xs:attribute name="MaxLength" type="edm:TMaxLengthFacet" use="optional" />
		<xs:attribute name="Precision" type="edm:TPrecisionFacet" use="optional" />
		<xs:attribute name="Scale" type="edm:TScaleFacet" use="optional" />
		<xs:attribute name="SRID" type="edm:TSridFacet" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:attributeGroup>
	  <xs:attributeGroup name="TFunctionImportAttributes">
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="ReturnType" type="edm:TFunctionImportParameterAndReturnType" use="optional" />
		<!-- EntitySet and EntitySetPath are mutually exclusive. -->
		<xs:attribute name="EntitySet" type="edm:TSimpleIdentifier" use="optional" />
		<xs:attribute name="EntitySetPath" type="xs:string" use="optional" />
		<xs:attribute name="IsComposable" type="xs:boolean" use="optional" default="false" />
		<xs:attribute name="IsSideEffecting" type="xs:boolean" use="optional" />
		<xs:attribute name="IsBindable" type="xs:boolean" use="optional" default="false" />
		<xs:attribute ref="cg:MethodAccess" use="optional" />
		<xs:anyAttribute namespace="##other" processContents="lax" />
	  </xs:attributeGroup>
	  <xs:attributeGroup name="TTypeAttributes">
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
	  </xs:attributeGroup>
	  <xs:attributeGroup name="TDerivableTypeAttributes">
		<xs:attributeGroup ref="edm:TTypeAttributes" />
		<xs:attribute name="BaseType" type="edm:TQualifiedName" use="optional" />
		<xs:attribute name="Abstract" type="xs:boolean" use="optional" default="false" />
	  </xs:attributeGroup>
	  <xs:attributeGroup name="TEntitySetAttributes">
		<xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		<xs:attribute name="EntityType" type="edm:TQualifiedName" use="required" />
		<xs:attribute ref="cg:GetterAccess" use="optional" />
	  </xs:attributeGroup>
	  <xs:element name="EntityContainer">
		<xs:complexType>
		  <xs:sequence>
			<xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
			<xs:choice minOccurs="0" maxOccurs="unbounded">
			  <xs:element name="FunctionImport">
				<xs:complexType>
				  <xs:sequence>
					<xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
					<xs:choice minOccurs="0" maxOccurs="unbounded">
					  <xs:element name="ReturnType" type="edm:TFunctionImportReturnType" minOccurs="0" maxOccurs="unbounded" />
					  <xs:element name="Parameter" type="edm:TFunctionImportParameter" minOccurs="0" maxOccurs="unbounded" />
					  <xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
					  <xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
					  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
					</xs:choice>
				  </xs:sequence>
				  <xs:attributeGroup ref="edm:TFunctionImportAttributes" />
				</xs:complexType>
			  </xs:element>
			  <xs:element name="EntitySet">
				<xs:complexType>
				  <xs:sequence>
					<xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
					<xs:choice minOccurs="0" maxOccurs="unbounded">
					  <xs:element name="ValueAnnotation" type="edm:TValueAnnotation" minOccurs="0" maxOccurs="unbounded" />
					  <xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" minOccurs="0" maxOccurs="unbounded" />
					  <xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
					</xs:choice>
				  </xs:sequence>
				  <xs:attributeGroup ref="edm:TEntitySetAttributes" />
				  <xs:anyAttribute processContents="lax" namespace="##other" />
				</xs:complexType>
			  </xs:element>
			  <xs:element name="AssociationSet">
				<xs:complexType>
				  <xs:sequence>
					<xs:element name="Documentation" type="edm:TDocumentation" minOccurs="0" maxOccurs="1" />
					<xs:element name="End" minOccurs="0" maxOccurs="2">
					  <!-- 
						   1. The number of Ends has to match with ones defined in AssociationType 
						   2. Value for attribute Name should match the defined ones and EntitySet should be of the 
							  defined Entity Type in AssociationType 
						-->
					  <xs:complexType>
						<xs:sequence>
						  <xs:group ref="edm:GEmptyElementExtensibility" minOccurs="0" maxOccurs="1" />
						</xs:sequence>
						<xs:attribute name="Role" type="edm:TSimpleIdentifier" use="optional" />
						<xs:attribute name="EntitySet" type="edm:TSimpleIdentifier" use="required" />
					  </xs:complexType>
					</xs:element>
					<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
				  </xs:sequence>
				  <xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
				  <xs:attribute name="Association" type="edm:TQualifiedName" use="required" />
				  <xs:anyAttribute namespace="##other" processContents="lax" />
				</xs:complexType>
			  </xs:element>
			  <xs:element name="ValueAnnotation" type="edm:TValueAnnotation" />
			  <xs:element name="TypeAnnotation" type="edm:TTypeAnnotation" />
			</xs:choice>
			<xs:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" />
		  </xs:sequence>
		  <xs:attribute name="Name" type="edm:TSimpleIdentifier" use="required" />
		  <xs:attribute name="Extends" type ="edm:TSimpleIdentifier" use="optional" />
		  <xs:attribute ref="cg:TypeAccess" use="optional" />
		  <xs:attribute ref="annotation:LazyLoadingEnabled" use="optional" />
		  <xs:anyAttribute namespace="##other" processContents="lax" />
		</xs:complexType>
	  </xs:element>
	  <!-- 
		general  (more or less) purpose simple types 
		-->
	  <xs:simpleType name="TParameterMode">
		<xs:restriction base="xs:token">
		  <xs:enumeration value="In" />
		  <xs:enumeration value="Out" />
		  <xs:enumeration value="InOut" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TNamespaceName">
		<xs:restriction base="edm:TQualifiedName">
		  <xs:maxLength value="512" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TQualifiedName">
		<xs:restriction base="xs:string">
		  <!-- The below pattern represents the allowed identifiers in ECMA specification plus the '.' for namespace qualification  -->
		  <xs:pattern value="[\p{L}\p{Nl}][\p{L}\p{Nl}\p{Nd}\p{Mn}\p{Mc}\p{Pc}\p{Cf}]{0,}(\.[\p{L}\p{Nl}][\p{L}\p{Nl}\p{Nd}\p{Mn}\p{Mc}\p{Pc}\p{Cf}]{0,}){0,}" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TPath">
		<xs:restriction base="xs:string">
		  <!-- The below pattern represents the allowed identifiers in ECMA specification plus the '/' for path segment separation and
			   the '.' for namespace qualification inside the segments. It also allows using parens and commas to designate function signatures
			   such as "Namespace1.Namespace2.Function1(String,Collection(Int32))/Parameter1".-->
		  <xs:pattern value="[\p{L}\p{Nl}][\p{L}\p{Nl}\p{Nd}\p{Mn}\p{Mc}\p{Pc}\p{Cf}\(\)\,]{0,}([/\.][\p{L}\p{Nl}][\p{L}\p{Nl}\p{Nd}\p{Mn}\p{Mc}\p{Pc}\p{Cf}\(\)\,]{0,}){0,}" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TSimpleIdentifier">
		<xs:restriction base="xs:string">
		  <xs:maxLength value="480" />
		  <!-- The below pattern represents the allowed identifiers in ECMA specification -->
		  <xs:pattern value="[\p{L}\p{Nl}][\p{L}\p{Nl}\p{Nd}\p{Mn}\p{Mc}\p{Pc}\p{Cf}]{0,}" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TPropertyType">
		<xs:union memberTypes="edm:EDMSimpleType edm:TQualifiedName">
		  <xs:simpleType>
			<xs:restriction base="xs:token">
			  <!-- The below pattern represents the allowed identifiers in ECMA specification plus the '.' for namespace qualification and Collection() wrapper  -->
			  <xs:pattern value="Collection\([\p{L}\p{Nl}][\p{L}\p{Nl}\p{Nd}\p{Mn}\p{Mc}\p{Pc}\p{Cf}]{0,}(\.[\p{L}\p{Nl}][\p{L}\p{Nl}\p{Nd}\p{Mn}\p{Mc}\p{Pc}\p{Cf}]{0,}){0,}\)" />
			</xs:restriction>
		  </xs:simpleType>
		</xs:union>
	  </xs:simpleType>
	  <xs:simpleType name="TCommandText">
		<xs:restriction base="xs:string">
		  <xs:whiteSpace value="preserve" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TFunctionImportParameterAndReturnType">
		<xs:union memberTypes="edm:EDMSimpleType edm:TQualifiedName">
		  <xs:simpleType>
			<xs:restriction base="xs:token">
			  <xs:pattern value="Collection\([^\. \t]{1,}(\.[^\. \t]{1,}){0,}\)" />
			</xs:restriction>
		  </xs:simpleType>
		</xs:union>
	  </xs:simpleType>
	  <xs:simpleType name="TWrappedFunctionType">
		<xs:union memberTypes="edm:TQualifiedName">
		  <xs:simpleType>
			<xs:restriction base="xs:token">
			  <xs:pattern value="(Collection|Ref)\([^\. \t]{1,}(\.[^\. \t]{1,}){0,}\)" />
			</xs:restriction>
		  </xs:simpleType>
		</xs:union>
	  </xs:simpleType>
	  <xs:simpleType name="TUnwrappedFunctionType">
		<xs:union memberTypes="edm:TQualifiedName">
		  <xs:simpleType>
			<xs:restriction base="xs:token">
			  <xs:pattern value="[^\. \t]{1,}(\.[^\. \t]{1,}){0,}" />
			</xs:restriction>
		  </xs:simpleType>
		</xs:union>
	  </xs:simpleType>
	  <xs:simpleType name="TAction">
		<xs:restriction base="xs:token">
		  <xs:enumeration value="Cascade" />
		  <xs:enumeration value="None" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TMultiplicity">
		<xs:restriction base="xs:token">
		  <xs:enumeration value="0..1" />
		  <xs:enumeration value="1" />
		  <xs:enumeration value="*" />
		</xs:restriction>
	  </xs:simpleType>
	  <xs:simpleType name="TConcurrencyMode">
		<xs:restriction base="xs:token">
		  <xs:enumeration value="None" />
		  <xs:enumeration value="Fixed" />
		</xs:restriction>
	  </xs:simpleType>
	</xs:schema>

# 19	ABNF for CSDL[csdl19]

<!-- TODO: This ABSOLUTELY needs to be reworked. -->

	identifierLeadingCharacter 	= ; Any character from the Unicode classes L or Nl
	identifierCharacter 		= ; Any character from the Unicode classes L, Nl, Nd, Mn, Mc, Pc or Cf
	simpleIdentifier 			= identifierLeadingCharacter *identifierCharacter 
	qualifiedIdentifier 		= namespaceQualifiedIdentifier /
						 aliasQualifiedIdentifier 
	anyTypeReference			= "collection(" anySingleTypeReference ")" /
							anySingleTypeReference
	anyKeylessTypeReference	= "collection(" singleKeylessTypeReference ")" /
							singleKeylessTypeReference
	anySingleTypeReference		= singleEntityTypeReference /
							singleKeylessTypeReference
	singleEntityTypeReference	= qualifiedIdentifier / simpleIdentifier
							; identifies an EntityType by name
	singleKeylessTypeReference	= qualifiedIdentifier / simpleIdentifier
							; identifies a primitive, ComplexType or EnumType by name
	namespaceSegment	 		= simpleIdentifier
	alias					= simpleIdentifier 
	namespaceQualifiedIdentifier	= namespace "." simpleIdentifier
	aliasQualifiedIdentifier	= alias "." simpleIdentifier
	namespace		 		= namespaceSegment *("." namespaceSegment)
	coreModel				= "edm." 
	true					= "true" / "1"
	false					= "false" / "0"
	boolean				= true / false
	integralPrimitive			= [coreModel] (
							"byte" /
							"int16" /
							"int32" /
							"int64" /
							"sbyte"
							)
	spatialPrimitive			= [coreModel] (
							"geography" /
							"geographypoint" /
							"geographylinestring" /
							"geographypolygon" /
							"geographymultipoint" /
							"geographymultilinestring" /
							"geographymultipolygon" /
							"geographycollection" /
							"geometry" /
							"geometrypoint" /
							"geometrylinestring" /
							"geometrypolygon" /
							"geometrymultipoint" /
							"geometrymultilinestring" /
							"geometrymultipolygon" /
							"geometrycollection" /
							)
	nonNegativeInt32			= 1*10DIGIT ; 0-2147483647
	primitive 				= ["edm."] (
							integralPrimitive /
							spatialPrimitive /
							"" /
							"" /
							"" /
							"" /
							"" /
							"" /
							"" /
							"" /
							"" /
							"" /
							"" /
							"" /
							"" /
							)