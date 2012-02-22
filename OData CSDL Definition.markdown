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
