Title: Common Schema Definition Language (CSDL)
Author: Mark Stafford
Date: 29 March 2012
Keywords: odata, csdl

<!-- TODO: Verify that all links to csdl18 (abnf) are as tight as possible. -->
<!-- TODO: Verify that all primitive types are declared with Edm. prefix. -->
<!-- TODO: Verify that MSFT fwlinks should be replaced. -->

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
[18	ABNF for CSDL][csdl18]  
[19	Informative XSD for CSDL][csdl19]

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

The concurrency mode attribute MUST NOT be applied to any properties of a complex type.

The concurrency mode attribute MUST NOT be applied to properties whose type is a complex type.

# 6	Entity Type Constructs[csdl6]
## 6.1	The edm:EntityType Element[csdl6.1]
### 6.1.1	The edm:Name Attribute[csdl6.1.1]
### 6.1.2	The edm:BaseType Attribute[csdl6.1.2]
### 6.1.3	The edm:Abstract Attribute[csdl6.1.3]
### 6.1.4	The edm:OpenType Attribute[csdl6.1.4]
## 6.2	The edm:Key Element[csdl6.2]
## 6.3	The edm:PropertyRef Element[csdl6.3]
## 6.4	The edm:NavigationProperty Element[csdl6.4]
### 6.4.1	The edm:Name Attribute[csdl6.4.1]
### 6.4.2	The edm:Relationship Attribute[csdl6.4.2]
### 6.4.3	The edm:ToRole Attribute[csdl6.4.3]
### 6.4.4	The edm:FromRole Attribute[csdl6.4.4]
### 6.4.5	The edm:ContainsTarget Attribute[csdl6.4.5]
# 7	Complex Type Constructs[csdl7]
## 7.1	The edm:ComplexType Element[csdl7.1]
# 8	Enumeration Type Constructs[csdl8]
## 8.1	The edm:EnumType Element[csdl8.1]
### 8.1.1	The edm:UnderlyingType Attribute[csdl8.1.1]
### 8.1.2	The edm:IsFlags Attribute[csdl8.1.2]
## 8.2	The edm:Member Element[csdl8.2]
### 8.2.1	The edm:Name Attribute[csdl8.2.1]
### 8.2.2	The edm:Value Attribute[csdl8.2.2]
# 9	Other Type Constructs[csdl9]
## 9.1	Collection Types[csdl9.1]
### 9.1.1	The edm:CollectionType Element[csdl9.1.1]
## 9.2	The edm:TypeRef Element[csdl9.2]
## 9.3	Reference Types[csdl9.3]
### 9.3.1	The edm:ReferenceType Element[csdl9.3.1]
## 9.4	Row Types[csdl9.4]
### 9.4.1	The edm:RowType Element[csdl9.4.1]
# 10	Association Constructs[csdl10]
## 10.1	The edm:Association Element[csdl10.1]
## 10.2	The edm:End Element[csdl10.2]
### 10.2.1	The edm:Type Attribute[csdl10.2.1]
### 10.2.2	The edm:Role Attribute[csdl10.2.2]
### 10.2.3	The edm:Multiplicity Attribute[csdl10.2.3]
## 10.3	The edm:OnDelete Element[csdl10.3]
## 10.4	The edm:ReferentialConstraint Element[csdl10.4]
## 10.5	The edm:Principal Element[csdl10.5]
## 10.6	The edm:Dependent Element[csdl10.6]
## 10.7	The edm:PropertyRef Element[csdl10.7]
# 11	Model Functions[csdl11]
## 11.1	The edm:Function Element[csdl11.1]
### 11.1.1	The edm:ReturnType Attribute[csdl11.1.1]
## 11.2	The edm:Parameter Element[csdl11.2]
## 11.3	The edm:ReturnType Element[csdl11.3]
# 12	Entity Container Constructs[csdl12]
## 12.1	The edm:EntityContainer Element[csdl12.1]
## 12.2	The edm:EntitySet Element[csdl12.2]
## 12.3	The edm:AssociationSet Element[csdl12.3]
### 12.3.1	The edm:End Element[csdl12.3.1]
## 12.4	The edm:FunctionImport Element[csdl12.4]
### 12.4.1	The edm:ReturnType Attribute[csdl12.4.1]
### 12.4.2	The edm:EntitySet Attribute[csdl12.4.2]
### 12.4.3	The edm:EntitySetPath Attribute[csdl12.4.3]
### 12.4.4	The edm:IsSideEffecting Attribute[csdl12.4.4]
### 12.4.5	The edm:IsBindable Attribute[csdl12.4.5]
### 12.4.6	The edm:IsComposable Attribute[csdl12.4.6]
## 12.5	The edm:ReturnType Element[csdl12.5]
## 12.6	The edm:Parameter Element[csdl12.6]
### 12.6.1	The edm:Type Attribute[csdl12.6.1]
### 12.6.2	The edm:Mode Attribute[csdl12.6.2]
### 12.6.3	Parameter Facets[csdl12.6.3]
# 13	Vocabulary Concepts[csdl13]
# 14	Vocabulary Terms[csdl14]
## 14.1	edm:EntityType and edm:ComplexType Terms[csdl14.1]
## 14.2	The edm:ValueTerm Element[csdl14.2]
# 15	Vocabulary Annotations[csdl15]
## 15.1	The edm:Annotations Element[csdl15.1]
## 15.2	The edm:TypeAnnotation Element[csdl15.2]
## 15.3	The edm:PropertyValue Element[csdl15.3]
## 15.4	The edm:ValueAnnotation Element[csdl15.4]
## 15.5	The edm:Qualifier Attribute[csdl15.5]
# 16	Vocabulary Expressions[csdl16]
## 16.1	Constant Expressions[csdl16.1]
### 16.1.1	The edm:Binary Constant Expression[csdl16.1.1]
### 16.1.2	The edm:Bool Constant Expression[csdl16.1.2]
### 16.1.3	The edm:DateTime Constant Expression[csdl16.1.3]
### 16.1.4	The edm:DateTimeOffset Constant Expression[csdl16.1.4]
### 16.1.5	The edm:Decimal Constant Expression[csdl16.1.5]
### 16.1.6	The edm:Float Constant Expression[csdl16.1.6]
### 16.1.7	The edm:Guid Constant Expression[csdl16.1.7]
### 16.1.8	The edm:Int Constant Expression[csdl16.1.8]
### 16.1.9	The edm:String Constant Expression[csdl16.1.9]
### 16.1.10	The edm:Time Constant Expression[csdl16.1.10]
## 16.2	Dynamic Expressions[csdl16.2]
### 16.2.1	The edm:Apply Expression[csdl16.2.1]
### 16.2.2	The edm:AssertType Expression[csdl16.2.2]
### 16.2.3	The edm:Collection Expression[csdl16.2.3]
### 16.2.4	The edm:EntitySetReference Expression[csdl16.2.4]
### 16.2.5	The edm:EnumMemberReference Expression[csdl16.2.5]
### 16.2.6	The edm:FunctionReference Expression[csdl16.2.6]
### 16.2.7	The edm:If Expression[csdl16.2.7]
### 16.2.8	The edm:IsType Expression[csdl16.2.8]
### 16.2.9	The edm:LabeledElement Expression[csdl16.2.9]
### 16.2.10	The edm:LabeledElementReference Expression[csdl16.2.10]
### 16.2.11	The edm:Null Expression[csdl16.2.11]
### 16.2.12	The edm:ParameterReference Expression[csdl16.2.12]
### 16.2.13	The edm:Path Expression[csdl16.2.13]
### 16.2.14	The edm:PropertyReference Expression[csdl16.2.14]
### 16.2.15	The edm:Record Expression[csdl16.2.15]
### 16.2.16	The edm:ValueTermReference Expression[csdl16.2.16]
# 17	CSDL Examples[csdl17]
## 17.1	Title for example[csdl17.1]
# 18	ABNF for CSDL[csdl18]
# 19	Informative XSD for CSDL[csdl19]