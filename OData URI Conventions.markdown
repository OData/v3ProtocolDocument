# OData URI Conventions #

## Introduction ##
The Open Data Protocol (OData) enables the creation of REST-based data services, which allow resources, identified using Uniform Resource Identifiers (URIs) and defined in a data model, to be published and edited by Web clients using simple HTTP messages. This specification defines a set of recommended (but not required) rules for constructing URIs to identify the data and metadata exposed by an OData server as well as a set of reserved URI query string operators, which if accepted by an OData server, MUST be implemented as required by this document.

The [OData:Atom] and [OData:JSON] documents specify the format of the resource representations that are exchanged using OData and the [OData:Operations] document describes the actions that can be performed on the URIs (optionally constructed following the conventions defined in this document) embedded in those representations.

Servers are encouraged to follow the URI construction conventions defined in this specification when possible as  consistency promotes an ecosystem of reusable client components and libraries.

## Uri Components ##
A URI used by an OData service has at most three significant parts: the service root URI, resource path and query string options. Additional URI constructs (such as a fragment) MAY be present in a URI used by an OData service; however, this specification applies no further meaning to such additional constructs.

![](http://odata.org/images/ODataUri_thumb.png)

The following are two example URIs broken down into their component parts:

	http://services.odata.org/OData/OData.svc 
  	\_______________________________________/
				   | 
			service root URI 

	http://services.odata.org/OData/OData.svc/Category(1)/Products?$top=2&$orderby=name
	\_______________________________________/ \__________________/ \__________________/
                   |                                |                    |
             service root URI                  resource path        query options

## Service Root URI ##

## Resource Path ##

### Addressing Entities ###

### Addressing Links between Entities ###

### Addressing Operations ###

#### Addressing Service Operations ####

##### Service Operation Parameters #####

#### Addressing Functions ####

#### Addressing Actions ####

## Query String Options ##

### System Query Options ###

### Filter System Query Option ###

#### Logical Operators ####

#### Arithmetic Operators ####

#### Grouping Operators ####

#### Canonical Functions ####

### Select System Query Option ###

### OrderBy System Query Option ###

### Expand System Query Option ###

### Top and Skip System Query Options ###

### Inlinecount System Query Option ####

### Format System Query Option ###

## Custom Query Options ##

## Uri Equivalence ##

# Appendix A: ABNF for OData URIs #

TODO:

	$metadata
	servicedoc
	
	entitysets
	DONE keys
	$links
	$count
	DONE $select 
	DONE $expand 
	DONE $top
	DONE $skip 
	$orderby 
	$filter 
	DONE $format 
	DONE $inlinecount
	serviceOperations
	functions
	actions
	$value

	odataUri      				= 	scheme           ; see section 3.1 of [RFC3986]
                      			  	host             ; section 3.2.2 of [RFC3986]
                                  	[ ":" port ]     ; section 3.2.3 of [RFC3986]                         
                      			  	serviceRoot 
                                  	[ "$metadata" / "$batch" / odataRelativeUri ]  

	serviceRoot					= 	*( "/" segment-nz ) 

    segment-nz 					= 	; section 3.3 of [RFC3986]
								  	; the non empty sequence of characters
                         			; outside the set of URI reserved
                         			; characters as specified in [RFC3986]

	odataRelativeUri			= 	resourcePath ["?" queryOptions ]

	queryOptions				= 	queryOption *("&" queryOption)
	
	queryOption					= 	systemQueryOption / 
									customQueryOption / 
									serviceOperationParameterValue / 
									functionAliasAndValue
	
	systemQueryOption			= 	expand / 
								  	filter /
   									orderby /
                 					skip /
                 					top /
                 					format /
                 					inlinecount /
                					select /
                 					skiptoken

	expand						= 	"$expand=" expandClause *("," expandClause)

	expandClause  				= 	[ qualifiedEntityTypeName "/" ] navigationPropertyName 
									*([ "/" qualifiedEntityTypeName ] "/" navigationPropertyName)  

	count						= 

	filter						= 	"$filter="
	
	orderby						=	"$orderby="

	skip						=   "$skip=" 1*DIGIT

	top							=  	"$top=" 1*DIGIT

	format						= 	"$format=" (
										"json" / 
										"atom" / 
      									"xml" / 
                 						<a data service specific value indicating a format specific to the specific data service> / 
										<An IANA-defined [IANA-MMT] content type>
									)
 
	
	inlinecount					=  	"$inlinecount=" ( "allpages" / "none" )

	select 						=	"$select=" selectClause

	selectClause   				= 	selectItem *("," selectItem)

	selectItem     				= 	star / 
									[ qualifiedEntityType "/" ] (
										propertyName / 
										qualifiedActionName / 
										qualifiedFunctionName / 
										allOperationsInContainer /
										( navigationProperty [ "/" selectItem ] )
									)

	allOperationsInContainer 	= 	[namespace "."] entityContainer ".*" 

	star           				= 	"*"

	qualifiedActionName			= 	fullActionName

	qualifiedFunctionName 		= 	fullFunctionName [ "(" parameterTypeNames ")" ]
                      				; the parameterTypeNames are required to uniquely identify the Function
                      				; only if the Function in question has overloads.

	parameterTypeNames    		= 	[ parameterTypeName *( "," parameterTypeName ) ]
                      				; the types of all the parameters to the corresponding functionImport 
                      				; in the order they are declared in the FunctionImport

	parameterTypeName     		= 	qualifiedTypeName 

	skiptoken					=  	"$skiptoken="

	customQueryOption   		= 	;TODO: look for something in RFC3986

	resourcePath				= 	"/"	
									( [entityContainerName "."] entitySetName / serviceOperationEntColCall ) [ paren ] ["/" qualifiedEntityTypeName] [ navPath ] [ count ] / 
									functionCall ["/" qualifiedEntityTypeName] [ navigationPath ] [ count ] / 
									serviceOperation ["/" qualifiedEntityTypeName] / 
									actionCall

	navigationPath				= 	TODO

	odataIdentifier				= 	1*479pchar

    entitySetName 				=	odataIdentifier

	entityTypeName				= 	odataIdentifier

	complexTypeName				= 	odataIdentifier						

	qualifiedTypeName			= 	qualifiedEntityTypeName /
									qualifiedComplexTypeName / 
									primitiveTypeName 

	qualifiedEntityTypeName 	= 	namespace "." entityTypeName

	qualifiedComplexTypeName	= 	namespace "." complexTypeName

	primitiveTypeName			= 	["edm."] (
										"binary" /
                    					"boolean" /
                    					"byte" /
                    					"datetime" /
                    					"decimal" /
                    					"double" /
                    					"single" /
                    					"float" /
                    					"guid" /
                    					"int16" /
                    					"int32" /
                    					"int64" /
                    					"sbyte" /
                    					"string" /
                    					"time" /
                    					"datetimeoffset" /
                    					"stream" /
                    					concreteSpatialTypeName /
                   	 					abstractSpatialTypeName
									)

	concreteSpatialTypeName  	= 	"point" /
                       				"linestring" /
                       				"polygon" /
                       				"geographycollection" /
                       				"multipoint" /
                       				"multilinedtring" /
                       				"multipolygon" /
                       				"geometricpoint" /
                       				"geometriclinestring" /
                       				"geometricpolygon" /
                       				"geometrycollection" /
                       				"geometricmultipoint" /
                       				"geometricmultilinestring" /
                       				"geometricmultipolygon" /

	abstractSpatialTypeName  	= 	"geography" /
                           			"geometry"                     

	primitivePropertyName		= 	odataIdentifier
									; that identifies a primitive Property on the current EntityType or ComplexType.

	streamPropertyName			= 	odataIdentifier
									; that identifies a stream Property on the current EntityType

	complexTypePropertyName		= 	odataIdentifier
									; that identifies a ComplexType property on the current EntityType or ComplexType

	propertyName				= 	primitivePropertyName / 
									streamPropertyName / 
									complexTypePropertyName

	navigationPropertyName 		= 	odataIdentifier

	key 						= 	simpleKey / compoundKey

	simpleKey 					= 	"(" primitiveLiteral ")"

	compoundKey 				= 	"(" keyValuePair 1*("," keyValuePair) ")"

    keyValuePair 				= 	keyPropertyName "=" keyPropertyValue

	keyPropertyValue			= 	primitiveLiteral

	keyPropertyName 			= 	propertyName 
                    				; with the added restriction that the property MUST be part of the 
									; defining EntityType's key.
	
	serviceOperationCall		= 	fullServiceOperationName ["()"]

	serviceOperationEntColCall 	= 	serviceOperationCall
									; with the added restriction that the serviceOperation identified MUST return
									; a collection of an EntityType

	actionCall					= 	fullActionName ["()"]

	functionCall 				= 	fullFunctionName "(" functionParameters ")"

	functionParameters 			= 	[ functionParameter *( "," functionParameter ) ]

	functionParameter 			= 	functionParameterName "=" ( primitiveParameterValue / parameterAlias )

    primitiveParameterValue 	= 	primitiveLiteral

    parameterAlias 				= 	"@" *pchar

	functionAliasAndValue		= 	parameterAlias "=" parameterValue

	parameterValue				= 	primitiveLiteral / 
									complexTypeInJson / 
									colPrimitiveInJson /
									colComplexTypeInJson

	complexTypeInJson			= 	TODO

	colPrimitiveInJson			= 	TODO

	colComplexTypeInJson		= 	TODO

	fullServiceOperationName    =	[ [ namespace "." ] entityContainerName "."] serviceOperationName

	fullActionName				= 	[ [ namespace "." ] entityContainerName "." ] actionName
									; entityContainerName is only optional if the actionName alone is unambiguous
	
	fullFunctionName 			= 	[ [ namespace "." ] entityContainerName "." ] functionName
									; entityContainerName is only optional if the functionName alone is unambiguous

	functionName				= 	odataIdentifier

	namespace				 	= 	namespacePart *("." namespacePart)

	namespacePart				=  	odataIdentifier

	entityContainerName 		= 	odataIdentifier

    primitiveLiteral 			=

    pchar 						= 	; section 3.3 of [RFC3986]                      







