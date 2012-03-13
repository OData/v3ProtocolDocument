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

	DONE $metadata
	$metadata # links
	DONE primitive literals
	TODO: arlo - spatial literals
	DONE servicedoc
	DONE entitysets
	DONE keys
	navigationPath
	$links
	DONE $count
	DONE $select 
	DONE $expand 
	DONE $top
	DONE $skip 
	DONE $skiptoken
	$orderby 
	$filter 
	DONE $format 
	DONE $inlinecount
	serviceOperations
	functions
	DONE actions
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
									sopParameterNameAndValue / 
									aliasAndValue /
									parameterNameAndValue
	
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

	count						= 	"/$count" 

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

	skiptoken					=  	"$skiptoken=" 1*pchar

	customQueryOption   		= 	;TODO: look for something in RFC3986

	resourcePath				= 	"/"	
									( [entityContainerName "."] entitySetName / serviceOperationEntColCall ) [ paren ] ["/" qualifiedEntityTypeName ] [ navPath ] [ count ] / 
									functionCall ["/" qualifiedEntityTypeName ] [ navigationPath ] [ count ] / 
									serviceOperation ["/" qualifiedEntityTypeName ] / 
									actionCall

    navigationPath     			=	( "("keyPredicate")"  [navigationPathOptions] ) / 
                                  	operation
                        
    operation                   = 	"/" actionCall / ( boundFunctionCall [navigationPathOptions] )
                                    ; operation segments can only be composed if the type of the previous segment matches 
                                    ; the type of the first parameter of the action or function being called.

    navigationPathOptions   	=	[
                                  		navPathNP / 
                                        propertyPath / 
                                        complexPropertyPath / 
                                        namedStreamPath / 
                                        value /
                                        operation 
                                  	]

    navPathNP            		= 	[ "/" qualifiedEntityTypeName ] "/"
                                    ( 
                               			( "$links" / entityNavProperty ) / 
                                        ( collectionNavPropName [ paren ] [ navigationPath ] ) /
                                        ( singleNavPropName [ navigationPathOptions ] )
                               		)

    propertyPath                = 	TODO
    
    complexPropertyPath     	=  	TODO

    namedStreamPath       		= 	TODO

    value                   	= 	"/$value"

	odataIdentifier				= 	1*479pchar

    entitySetName 				=	odataIdentifier

	entityTypeName				= 	odataIdentifier

	complexTypeName				= 	odataIdentifier						

	qualifiedTypeName			= 	qualifiedEntityTypeName /
									qualifiedComplexTypeName / 
									primitiveTypeName /
									"collection(" (
										qualifiedEntityTypeName /
										qualifiedComplexTypeName / 
										primitiveTypeName 
									) ")"
									; TODO verify here.

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

    boundActionCall           	=   actionCall
                                    ; with the added restriction that the binding parameter MUST be either an Entity or Collection of Entities
                                    ; and is specified by reference using the Uri immediately preceding (to the left) of the boundActionCall

	functionCall 				= 	fullFunctionName "(" functionParameters ")"

    boundFunctionCall          	=   functionCall
                                    ; with the added restriction that the binding parameter MUST be either an Entity or Collection of Entities
                                    ; and is specified by reference using the Uri immediately preceding (to the left) of the boundFunctionCall

    boundFunctionEntityCall    	=    boundFunctionCall
                                    ; with the added restriction that the function MUST return a single Entity

    boundFunctionEntColCall    =    boundFunctionCall
                                    ; with the added restriction that the function MUST return a collection of Entities

	functionParameters 			= 	[ functionParameter *( "," functionParameter ) ]

	functionParameter 			= 	functionParameterName "=" ( primitiveParameterValue / parameterAlias )

    primitiveParameterValue 	= 	primitiveLiteral

    parameterAlias 				= 	"@" *pchar

	aliasAndValue				= 	parameterAlias "=" parameterValue

	parameterAndValue			= 	functionParameterName "=" parameterValue

	sopParameterNameAndValue	= 	serviceOperationParameterName "=" primitiveParameterValue
									; when a serviceOperation Parameter is omitted the parameter value MUST be assumed to be null

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

    primitiveLiteral 			=	null /
									binary / 
									boolean /
									byte /
									dateTime /
									dateTimeOffset /
									decimal /
									double /
									geography /
									geographyCollection / 
									geographyLineString /
									geographyMultiLineString /
									geographyMultiPoint /
									geographyMultiPolygon /
									geographyPoint / 
									geographyPolygon /
									geometry /
									geometryCollection / 
									geometryLineString /
									geometryMultiLineString /
									geometryMultiPoint /
									geometryMultiPolygon /
									geometryPoint / 
									geometryPolygon /
									guid / 
									int16 /
									int32 /
									int64 / 
									sbyte /
									single /
									string / 
									time 

  	null 						= 	"null" [ "'" qualifiedTypeName "'" ] 
         							; The optional qualifiedTypeName is used to specify what type this null value should be considered. 
									; Knowing the type is useful for function overload resolution purposes. 
						
	binary						= 	( "X" / "binary" )
                     				SQUOTE 
                     				2*HEXDIG 
                     				SQUOTE
									; note: "X" is case sensitive "binary" is not hence using the character code.

	boolean						=  	( "true" / "1" ) / 
									( "false" / "0" )
	
	byte						=	3*DIGIT
									; numbers in the range from 0 to 257

	dateTime					= 	"datetime" SQUOTE dateTimeBody SQUOTE

	dateTimeOffset				= 	"datetimeoffset" SQUOTE dateTimeOffsetBody SQUOTE

	dateTimeBody				= 	year "-" month "-" day "T" hour ":" minute [ ":" second [ "." nanoSeconds ] ] 

	dateTimeOffsetBody			= 	dateTimeBody "Z" / ; TODO: is the Z optional?
									dateTimeBody sign zeroToThirteen [ ":00" ] /
									dateTimeBody sign zeroToTwelve [ ":" zeroToSixty ] 
	
	decimal						= 	sign 1*29DIGIT ["." 1*29DIGIT] ("M"/"m")
	
	double						=	(  
										sign 1*17DIGIT /
 										sign *DIGIT "." *DIGIT /
										sign 1*DIGIT "." 16*DIGIT ( "e" / "E" ) sign 1*3DIGIT
									) ("D" / "d") /
									nanInfinity [ "D" / "d" ]

	geography 					= 	TODO: arlo

	geographyCollection 		= 	TODO: arlo 

	geographyLineString 		= 	TODO: arlo

	geographyMultiLineString 	= 	TODO: arlo

	geographyMultiPoint 		= 	TODO: arlo

	geographyMultiPolygon 		= 	TODO: arlo

	geographyPoint 				= 	TODO: arlo

	geographyPolygon 			= 	TODO: arlo

	geometry 					= 	TODO: arlo

	geometryCollection 			= 	TODO: arlo 

	geometryLineString 			= 	TODO: arlo

	geometryMultiLineString 	= 	TODO: arlo

	geometryMultiPoint 			= 	TODO: arlo

	geometryMultiPolygon 		= 	TODO: arlo

	geometryPoint 				= 	TODO: arlo 

	geometryPolygon 			= 	TODO: arlo

	guid						= 	"guid" SQUOTE 8*HEXDIG "-" 4*HEXDIG "-" 4*HEXDIG "-" 12*HEXDIG SQUOTE

	int16						= 	[ sign ] 5*DIGIT
									; numbers in the range from -32768 to 32767
	
	int32						= 	[ sign ] 10*DIGIT
									; numbers in the range from -2147483648 to 2147483647

	int64						= 	[ sign ] 19*DIGIT ( "L" / "l" )
									; numbers in the range from -9223372036854775808 to 9223372036854775807

	sbyte						= 	[ sign ] 3*DIGIT
									; numbers in the range from -128 to 127

	single						= 	(  
										sign 1*8DIGIT /
 										sign *DIGIT "." *DIGIT /
										sign 1*DIGIT "." 8*DIGIT ( "e" / "E" ) sign 1*2DIGIT
									) ("F" / "f") /
									nanInfinity [ "F" / "f" ]

	string						= 	SQUOTE *UTF8-char SQUOTE

	time						= 	time SQUOTE sign "P" [ 1*DIGIT "Y" ] [ 1*DIGIT "M" ] [ 1*DIGIT "D" ] [ "T" [ 1*DIGIT "H" ] [ 1*DIGIT "M" ] [ 1*DIGIT "S" ] ] SQUOTE
									; the above is an approximation of the rules for an xml duration.
									; see the lexical representation for duration in http://www.w3.org/TR/xmlschema-2 for more information

	commonExpression			= 	TODO

	year 						=	4*DIGIT;

	month 						= 	zeroToTwelve

	day 						= 	"0" oneToNine /
									( "1" / "2" ) DIGIT /
									"30" /
									"31"

	hour						=  	"0" oneToNine /
									"1" DIGIT / 
									"2" ( "1" / "2" / "3" / "4" )

	minute 						=	zeroToSixty

	second						= 	zeroToSixty
	
	nanoSeconds					= 	1*7DIGIT

	zeroToSixty					= 	"0" oneToNine  /
									( "1" / "2" / "3" / "4" / "5" ) DIGIT /
									"60"

	zeroToTwelve				= 	"0" oneToNine /
									"1" ( "0" / "1" / "2" )								

	zeroToThirteen				= 	"0" oneToNine /
									"1" ( "0" / "1" / "2" / "3" )

	oneToNine					=   "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9" 

	sign						= 	"+" / "-"

    pchar 						= 	; section 3.3 of [RFC3986]   

	WSP							= 	; core to ABNF, see [RFC5234]

	DIGIT						= 	; core to ABNF, see [RFC5234]
                   
	HEXDIG						= 	; core to ABNF, see [RFC5234]

	SQUOTE            			= 	%x27              ; ' (single quote)
	
	EQ                			=   %x3D              ; = (equal sign)

	SEMI              			=  	%x3B              ; ; (semicolon)

	SP                			=  	%x20              ;   (single-width horizontal space character)

	COMMA             			=  	%x2C              ; , (comma)

	nan               			=  	"NaN"

	negativeInfinity  			=  	"-INF"

	positiveInfinity   			=  	"INF"

	nanInfinity       			=  	nan / negativeInfinity / positiveInfinity

	DIGIT             			=  	; core to ABNF, see [RFC5234]

	UTF8-char         			=  	; see [RFC3629]






