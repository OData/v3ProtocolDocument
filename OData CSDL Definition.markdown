#Appendix A: Formal Common Schema Definition Langauge (CSDL)#

------

- ASSIGNED TO: MikeP  
      to add to outline:  
	- Model Functions?
	- CollectionType/TypeRef?
	- ReferenceType/RowType?
	- Expressions  
	- Annotations
	- dataservice attributes (i.e., to functions)
 
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
The CSDL returned by an OData Service MUST contain a single root `edmx:EDMX` Element, containing a single child [`edmx:DataServices`](#The"edmx:DataServices"Element) element describing the entity model(s) exposed by the OData service. In addition, it may have zero or more [`edmx:Reference`](#The"edmx:ReferenceElement.) elements to specify the location of schemas referenced by this document and zero or more [`edmx:AnnotationsReference`](#The"edmx:AnnotationsReference"Element) elements to specify the location of annotations to be applied to this document.

#### 2.1.1. The "Version" Attribute ####
The `Version` attribute, as described in **todo:ref xmlschema**, MUST be present on the `edmx:EDMX` element. 

The Version attribute is a string value that specifies the version of the EDMX wrapper, and must be of the form
`majorversion + "." + minorversion`. This version of the specification defines version `"1.0"` of the EDMX Wrapper.

### 2.2 The "edmx:DataServices" Element ###
The `edmx:DataServices` element contains zero or more [`Schema`](#The"Schema"Element) elements, defining the schema(s) exposed by the OData service.
#### 2.2.1. The "metadata:DataServiceVersion" Attribute ####

### 2.3. The "edmx:Reference" Element ###
The `edmx:Reference` element specifies the location of other schemas referenced by this EDMX.
#### 2.3.1. The "Url" Attribute ####

### 2.4. The "edmx:AnnotationsReference" Element ###
The `edmx:AnnotationsReference` element specifies the location of a seperate document that annotates this EDMX.

The `edmx:AnnotationsReference` element contains zero or more [`edmx:Include`](#The"edmx:Include"Element) elements that specify the annotations to include from the target document.
#### 2.4.1. The "Url" Attribute ####

### 2.5. The "edmx:Include" Element ###
The `edmx:AnnotationsReference` element specifies the location of a seperate document that annotates this EDMX.
#### 2.5.1. The "TermNamespace" Attribute ####
#### 2.5.2. The "Qualifier" Attribute ####


## 3. Schema Constructs ##
Each Entity Model exposed by the OData service is described by a Schema.

### 3.1. The "Schema" Element ###
#### 3.1.1. The "Namespace" Attribute ####
#### 3.1.2. The "Alias" Attribute ####
#### 3.1.3. The "NamespaceUri" Attribute ####

### 3.2. The "Using" Element ###
#### 3.2.1. The "Namespace" Attribute ####
#### 3.2.2. The "Alias" Attribute ####


## 4. Entity Type Constructs ##
Entity Types are nominal structured records with a key that consist of named primitive or complex properties.

### 4.1. The "edm:EntityType" Element ###
The `edm:EntityType` Element represents an Entity Type in the EDM. The `edm:EntityType` element contains zero or more child [`edm:Property`](#The"edm:Property"Element) elements, describing the properties of the entity type.
#### 4.1.1. The "edm:Name" Attribue ####
#### 4.1.1. The "edm:BaseType" Attribue ####
#### 4.1.1. The "edm:Abstract" Attribue ####

### 4.2. The "edm:Key" Element ###

### 4.3. The "edm:PropertyRef" Element ###
#### 4.3.1. The "edm:Name" Attribue ####

### 4.4. The "edm:Property" Element ###
#### 4.4.1. The "edm:Name" Attribue ####
#### 4.4.2. The "edm:Type" Attribue ####
#### 4.4.3. The "edm:Nullable" Attribue ####
#### 4.4.4. The "edm:ReadOnly" Attribue ####
#### 4.4.5. The "edm:Default" Attribue ####
#### 4.4.6. The "edm:MaxLength" Attribue ####
#### 4.4.7. The "edm:FixedLength" Attribue ####
#### 4.4.8. The "edm:Precision" Attribue ####
#### 4.4.9. The "edm:Scale" Attribue ####
#### 4.4.10. The "edm:Unicode" Attribue ####
#### 4.4.11. The "edm:Collation" Attribue ####
#### 4.4.12. The "edm:SRID" Attribue ####
#### 4.5.13. The "edm:ConcurrencyMode" Attribue ####

### 4.5. The "edm:NavigationProperty" Element ###
#### 4.5.1. The "edm:Name" Attribue ####
#### 4.5.2. The "edm:Relationship" Attribue ####
#### 4.5.3. The "edm:ToRole" Attribue ####
#### 4.5.4. The "edm:FromRole" Attribue ####


## 5. Complex Type Constructs ##
Complex Types are nominal structured types also consisting of a list of properties but with no key, thus can only exist as a property of a containing Entity Type or as a temporary value. 
### 5.1. The "edm:ComplexType" Element ###
The `edm:ComplexType` Element represents a Complex Type in the EDM. The `edm:ComplexType` element contains zero or more child [`edm:Property`](#The"edm:Property"Element) elements, describing the properties of the complex type.
#### 5.1.1. The "edm:Name" Attribue ####
#### 5.1.2. The "edm:BaseType" Attribue ####
#### 5.1.2. The "edm:Abstract" Attribue ####


## 6. Enumeration Type Constructs ##
Enumeration Types define a set of named values. 

### 6.1. The "edm:Enum" Element ###
The `edm:Enum` Element represents an Enumeration Type in the EDM. The `edm:Enum` element contains zero or more child [`edm:Member`](#The"edm:Member"Element) elements enumerating the members of the enum.
#### 6.1.1. The "edm:Name" Attribue ####
#### 6.1.2. The "edm:UnderlyingType" Attribue ####
#### 6.1.3. The "edm:IsFlag" Attribue ####

### 6.2. The "edm:Member" Element ###
#### 6.2.1. The "edm:Name" Attribue ####
#### 6.2.2. The "edm:Value" Attribue ####



## 7. Association Constructs ##
Associations define the relationship between two or more Entity Types 

### 7.1. The "edm:Association" Element ###
#### 7.1.1. The "edm:Name" Attribue ####

### 7.2. The "edm:End" Element ###
#### 7.2.1. The "edm:Type" Attribue ####
#### 7.2.2. The "edm:Role" Attribue ####
#### 7.2.3. The "edm:Multiplicity" Attribue ####

### 7.3. The "edm:OnDelete" Element ###
#### 7.3.1. The "edm:Action" Attribue ####

### 7.4. The "edm:ReferentialConstraint" Element ###

### 7.5. The "edm:Principal" Element ###
#### 7.5.1. The "edm:Role" Attribue ####

### 7.6. The "edm:Dependent" Element ###
#### 7.6.1. The "edm:Role" Attribue ####


## 8. Entity Containers Constructs ##
Instances of EntityTypes live within EntitySets. Instances of Associations live within AssociationSets. All Entity Sets and Association Sets are grouped in an Entity Container.

### 8.1. The "edm:EntityContainer" Element ###
### 8.2. The "edm:EntitySet" Element ###
### 8.3. The "edm:AssociationSet" Element ###


## 9. Function and Action Constructs ##
### 9.1. The "edm:FunctionImport" Element ###
#### 9.1.1. The "edm:Name" Attribue ####
#### 9.1.1. The "edm:ReturnType" Attribue ####
#### 9.1.1. The "edm:EntitySet" Attribue ####
#### 9.1.1. The "edm:EntityPath" Attribue ####

### 9.2. The "edm:ReturnType" Element ###
#### 9.2.1. The "edm:Type" Attribue ####
#### 9.2.2. The "edm:EntitySet" Attribue ####

### 9.3. The "edm:Parameter" Element ###
#### 9.3.1. The "edm:Name" Attribue ####
#### 9.3.2. The "edm:Type" Attribue ####
#### 9.3.3. The "edm:Mode" Attribue ####
#### 9.3.4. The "edm:MaxLength" Attribue ####
#### 9.3.5. The "edm:Precision" Attribue ####
#### 9.3.6. The "edm:Scale" Attribue ####


## 10. Annotation Constructs ##
### 10.1. The "edm:TypeAnnotation" Element ###

### 10.2. The "edm:PropertyValue" Element ###
#### 10.2.1 The "edm:Path" Attribute ####
#### 10.2.2 The "edm:String" Attribute ####
#### 10.2.3 The "edm:Int" Attribute ####
#### 10.2.4 The "edm:Float" Attribute ####
#### 10.2.5 The "edm:Decimal" Attribute ####
#### 10.2.6 The "edm:DateTime" Attribute ####

### 10.3. The "edm:ValueAnnotation" Element ###
#### 10.3.1 The "edm:Path" Attribute ####
#### 10.3.2 The "edm:String" Attribute ####
#### 10.3.3 The "edm:Int" Attribute ####
#### 10.3.4 The "edm:Float" Attribute ####
#### 10.3.5 The "edm:Decimal" Attribute ####
#### 10.3.6 The "edm:DateTime" Attribute ####

### 10.4. The "edm:ValueTerm" Element ###
#### 10.4.1. The "edm:Name" Attribue ####
#### 10.4.2. The "edm:Type" Attribue ####


## 11. Expression Constructs ##
Expressions are used to specify values in annotations. They may appear as a direct child of an [edm:PropertyValue](#The"edm:PropertyValue"Element) or an [edm:ValueAnnotation](#The"edm:ValueAnnotation"Element).

## B: XSD for CSDL ##

------

- ASSIGNED TO: Alex

------
