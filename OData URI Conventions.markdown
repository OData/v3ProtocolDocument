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
The service root URI identifies the root of an OData service. The resource identified by this URI MUST be an AtomPub Service Document (as specified in [RFC5023]) and follow the OData conventions for AtomPub Service Documents (or an alternate representation of an Atom Service Document if a different format is requested). OData: JSON Format specifies such an alternate JSON-based representation of a service document. The service document is required to be returned from the root of an OData service to provide clients with a simple mechanism to enumerate all of the collections of resources available for the data service.

## Resource Path ##

### Addressing Entities ###

### Addressing Links between Entities ###

### Addressing Operations ###

#### Addressing Service Operations ####
OData services can expose Service Operations which, like Entries, are identified using a URI. Service Operations are simple functions exposed by an OData service whose semantics are defined by the author of the function. A Service Operation can accept primitive type input parameters and can be defined to return a single primitive, single complex type, collection of primitives, collection of complex types, a single Entry, a Collection of Entries, or void. The basic rules for constructing URIs to address Service Operations and to pass parameters to them are illustrated in the following figure.

- ServiceRootUri: The service root URI identifies the root of the OData service.
- ServiceOperation: The name of a Service Operation exposed by an OData service.
- ParamName: The name of a parameter accepted by the Service Operation. If the Service Operation accepts multiple parameters, the order of the parameters in the query string of the URI is insignificant.
- ParamValue: The value of the parameter. The format of the value is defined by the literal form column of the table in the Abstract Types section of [OData:Core] (the OData overview specification) .

##### Examples #####
The example URIs below follow the addressing rules stated above and are based on the reference service found at this service root [http://services.odata.org/OData/OData.svc](http://services.odata.org/OData/OData.svc) and [http://services.odata.org/OData/OData.svc/$metadata](http://services.odata.org/OData/OData.svc/$metadata). In the following examples '[~](http://services.odata.org/OData/OData.svc)' is used as shorthand for [http://services.odata.org/OData/OData.svc](http://services.odata.org/OData/OData.svc) 

[~/ProductsByColor?color='red'](http://services.odata.org/OData/OData.svc/ProductsByColor?color='red')

Identifies the ProductByColor Service Operation and passes it a single string parameter. Since Service Operations are just functions, their semantics are up to the implementer of the function. In this case the Service Operation returns all the red Products. Is described by the Function Import named "ProductsByColor" that accepts a single string parameter named "color" in the service metadata document.

[~/ProductsByColor(3)/Category/Name?color='red'](http://services.odata.org/OData/OData.svc/ProductsByColor(3)/Category/Name?color='red')

Identifies the same function as the example above; however, since the function returns a collection of Entries (here, Products) it acts as a pseudo Collection in that additional path segments may follow identifying Entries or Links from the Entries within the pseudo Collection identified by the Service Operation. In this case, the result of the function is treated as a Collection of Entries, as described by the prior Addressing Entries section. Is described in the service metadata document by: 

- The Function Import named "ProductsByColor" that accepts a single string parameter named "color".
- The "Category" Navigation Property on the "Product" Entity Type.
- The "Name" property on the "Category" Entity Type.

[~/ProductsByColor?color='red'&param=foo](http://services.odata.org/OData/OData.svc/ProductsByColor?color='red'&param=foo)

Same as the example below, except an additional parameter (param) is specified. Since the function does not define an input parameter named param, this parameter is ignored and not considered part of the function invocation.

	http://services.odata.org/OData/OData.svc/ProductColors

Identifies the ProductColors Service Operation that accepts no parameters.
Is described by the Function Import named "ProductColors" in the service metadata document. This function returns a collection of strings.

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
The following Augmented Backus–Naur Form (ABNF) details the construction rules for OData Uris that target OData services that follow the Uri Conventions specified in this document.

	
	WSP							= 	; core to ABNF, see [RFC5234]

	DIGIT						= 	; core to ABNF, see [RFC5234]
                   
	HEXDIG						= 	; core to ABNF, see [RFC5234]

	ALPHA						= 	; core to ABNF, see [RFC5234]

    pchar 						= 	unreserved / pct-encoded / sub-delims / ":" / "@" 				; see [RFC3986]  
	
	unreserved  				= 	ALPHA / DIGIT / "-" / "." / "_" / "~" 							; see [RFC3986]  
	
	pct-encoded 				= 	"%" HEXDIG HEXDIG												; see [RFC3986] 
	
	sub-delims  				= 	"!" / "$" / "&" / "'" / "(" / ")" / "*" / "+" / "," / ";" / "="	; see [RFC3986]  

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

	year 						=	4*DIGIT;

	oneToNine					=   "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9" 
	
	zeroToTwelve				= 	[ "0" ] oneToNine /
									"1" ( "0" / "1" / "2" )	

	zeroToThirteen				= 	zeroToTwelve / "13"	

	zeroToSixty					= 	[ "0" ] oneToNine  /
									( "1" / "2" / "3" / "4" / "5" ) DIGIT /
									"60"

	zeroToThirtyOne				= 	[ "0" ] oneToNine /
									( "1" / "2" ) DIGIT /
									"30" /
									"31"

	zeroToTwentyFour			=  	[ "0" ] oneToNine /
									"1" DIGIT / 
									"2" ( "1" / "2" / "3" / "4" ) 

	month 						= 	zeroToTwelve

	day 						= 	zeroToThirtyOne

	hour						=  	zeroToTwentyFour

	minute 						=	zeroToSixty

	second						= 	zeroToSixty
	
	nanoSeconds					= 	1*7DIGIT

	sign						= 	"+" / "-"

	begin-object				= 	"{"

	end-object					=	"}"

	value-separator				= 	COMMA

	name-separator				=	":"

	odataIdentifier				= 	1*479pchar

	namespacePart				=  	odataIdentifier

	namespace				 	= 	namespacePart *("." namespacePart)

    entitySetName 				=	odataIdentifier
									; identifies by name an EntitySet

	entityTypeName				= 	odataIdentifier
									; identifies by name an EntityType

	complexTypeName				= 	odataIdentifier	
									; identifies by name a ComplexType

	operationQualifier			= 	[ namespace "." ] entityContainerName "."

	allOperationsInContainer 	= 	operationQualifier "*" 			

	qualifiedTypeName			= 	qualifiedEntityTypeName /
									qualifiedComplexTypeName / 
									primitiveTypeName /
									"collection(" (
										qualifiedEntityTypeName /
										qualifiedComplexTypeName / 
										primitiveTypeName 
									) ")"

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

	primitiveKeyProperty		=	odataIdentifier
									; that identifies a primitive property of an EntityType that is part of the EntityKey of that EntityType

	primitiveNonKeyProperty		= 	odataIdentifier
									; that identifies a primitive Property on the current EntityType or ComplexType.
	
	primitiveColProperty		= 	odataIdentifier
									; that identifies a property that is a collection of primitive types.

	complexProperty				= 	odataIdentifier
									; that identifies a ComplexType property on the current EntityType or ComplexType

	complexColProperty			=	odataIdentifier
									; that identifies a property that is a collection of a ComplexType

	streamProperty				= 	odataIdentifier
									; that identifies a stream Property on the current EntityType

	propertyName				= 	primitiveKeyProperty / 
									primitiveNonKeyProperty /
									primitiveColProperty / 
									complexProperty / 
									complexColProperty /
									streamProperty

	entityContainerName 		= 	odataIdentifier

	serviceOperation			= 	entityServiceOp / 
									entityColServiceOp /
									complexServiceOp / 
									complexColServiceOp /
									primitiveServiceOp /
									primitiveColServiceOp 

	entityServiceOp				= 	odataIdentifier
	
	entityColServiceOp			=	odataIdentifier
	
	complexServiceOp			= 	odataIdentifier
	
	complexColServiceOp			= 	odataIdentifier
	
	primitiveServiceOp			= 	odataIdentifier
	
	primitiveColServiceOp		= 	odataIdentitier

	entityNavigationProperty	=	odataIdentifier

	entityColNavigationProperty	=	odataIdentifier

	navigationProperty	 		= 	entityNavigationProperty / entityColNavigationProperty  

	entityFunction				= 	odataIdentifier
									; identifies by name a Function that returns an Entity

	entityColFunction			=	odataIdentifier
									; identifies by name a Function that returns a Collection of Entities

	complexFunction				= 	odataIdentifier
									; identifies by name a Function that returns a ComplexType instance

	complexColFunction			= 	odataIdentifier
									; identifies by name a Function that returns a Collection of ComplexType instances

	primitiveFunction			= 	odataIdentifier
									; identifies by name a Function that returns a Primitive value

	primitiveColFunction		= 	odataIdentitier
									; identifies by name a Function that returns a Collection of Primitive values

	function					=	entityFunction / 
									entityColFunction /
									complexFunction / 
									complexColFunction /
									primitiveFunction /
									primitiveColFunction

	fullEntityFunction			= 	[ operationQualifier ] entityFunction
									; operationQualifier is only optional if the entityFunction alone is unambiguous

	fullEntityColFunction		=	[ operationQualifier ] entityColFunction
									; operationQualifier is only optional if the entityColFunction alone is unambiguous

	fullComplexFunction			= 	[ operationQualifier ] complexFunction
									; operationQualifier is only optional if the complexFunction alone is unambiguous

	fullComplexColFunction		= 	[ operationQualifier ] complexColFunction
									; operationQualifier is only optional if the complexColFunction alone is unambiguous

	fullPrimitiveFunction		= 	[ operationQualifier ] primitiveFunction
									; operationQualifier is only optional if the primitiveFunction alone is unambiguous

	fullPrimitiveColFunction	= 	[ operationQualifier ] primitiveColFunction
									; operationQualifier is only optional if the primitiveColFunction alone is unambiguous
	
	fullFunction	 			= 	fullEntityFunction / 
									fullEntityColFunction /
									fullComplexFunction / 
									fullComplexColFunction /
									fullPrimitiveFunction /
									fullPrimitiveColFunction            

	entityAction				=	odataIdentifier
									; identifies by name an Action that returns an Entity

	entityColAction				=	odataIdentifier
									; identifies by name an Action that returns a Collection of Entities

	complexAction				=	odataIdentifier
									; identifies by name an Action that returns a ComplexType instance

	complexColAction			=	odataIdentifier
									; identifies by name an Action that returns a Collection of ComplexType instances

	primitiveAction				=	odataIdentifier
									; identifies by name an Action that returns a Primitive value

	primitiveColAction			=	odataIdentifier
									; identifies by name an Action that returns a Collection of Primitive values

	voidAction					=	odataIdentifier
									; identifies by name an Action

	action						=	entityAction / 
									entityColAction /
									complexAction /
									complexColAction /
									primitiveAction / 
									primitiveColAction / 
									voidAction
									
	fullAction					= 	[ operationQualifier ] action

	boundAction					= 	fullAction
									; with the additional 

	qualifiedActionName			= 	fullActionName
									; used in $select

	qualifiedFunctionName 		= 	fullFunction [ "(" parameterTypeNames ")" ]
                      				; the parameterTypeNames are required to uniquely identify the Function
                      				; only if the Function in question has overloads.

	parameterTypeNames    		= 	[ parameterTypeName *( "," parameterTypeName ) ]
                      				; the types of all the parameters to the corresponding functionImport 
                      				; in the order they are declared in the FunctionImport

	parameterTypeName     		= 	qualifiedTypeName 

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
						
	binary						= 	( %d88 / "binary" )
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

	filter						= 	"$filter" [ WSP ] "=" [ WSP] boolCommonExpr
	
	orderby						=	"$orderby" [ WSP ] "=" [ WSP] 
									commonExpr [WSP] [ "asc" / "desc" ] *( COMMA [ WSP ]  commonExpr [ WSP ] [ "asc" / "desc" ])

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

	selectClause   				= 	selectItem *( COMMA selectItem )

	selectItem     				= 	star / 
									[ qualifiedEntityType "/" ] (
										propertyName / 
										qualifiedActionName / 
										qualifiedFunctionName / 
										allOperationsInContainer /
										( navigationProperty [ "/" selectItem ] )
									)

	star           				= 	"*"

	skiptoken					=  	"$skiptoken=" 1*pchar

	customQueryOption   		= 	customName [ WSP ] [ "=" [ WSP ] customValue ]

	customName 					=	( unreserved / pct-encoded / ":" / "@" / "!" / "'" / "(" / ")" / "*" / "+" / "," / ";" ) 
									*( unreserved / pct-encoded / ":" / "@" / "!" / "$" / "'" / "(" / ")" / "*" / "+" / "," / ";" )			
									; MUST not start with '$'

	customValue					= 	*( unreserved / pct-encoded / ":" / "@" / "!" / "$" / "'" / "(" / ")" / "*" / "+" / "," / ";" / "=" )

	resourcePath				= 	"/"	
									[ entityContainerName "." ] entitySetName [collectionNavigation] /
									( entityColServiceOpCall / entityColFunctionCall ) [ collectionNavigation ] /
									( entityServiceOpCall	/ entityFunctionCall ) [ singleNavigation ] /
									( complexColServiceOpCall / complexColFunctionCall ) [ boundOperation ] /
									( complexServiceOpCall / complexFunctionCall ) [ boundOperation / complexPropertyPath ] /
									( primitiveColServiceOpCall / primitiveColFunctionCall ) [ boundOperation ] /
									( primitiveServiceOpCall / primitiveFunctionCall ) [ boundOperation / value ] /
									actionCall 

    collectionNavigation     	=	[ "/" qualifiedEntityTypeName ] "/" 
									(
										( "(" keyPredicate ")"  [ singleNavigation ] ) / 
                                  		boundEntityFuncCall [ singleNavigation ] /
										boundEntityColFuncCall [ collectionNavigation ] /
										boundPrimitiveFuncCall [ boundOperation / value ] /
										boundPrimitiveColFuncCall [ boundOperation ] /
										boundComplexFuncCall [ complexPropertyPath / boundOperation ] /
										boundComplexColFuncCall [ boundOperation ] /
										boundActionCall
									)

	singleNavigation			=	[ "/" qualifiedEntityTypeName ] "/"
                                    ( 
                               			( "$links" / navigationPropertyName ) / 
                                        ( entityColNavigationProperty [ collectionNavigation ] ) /
                                        ( entityNavigationProperty [ singleNavigation ] ) /
										primitivePropertyPath / 
                                        complexPropertyPath /
										collectionPropertyPath / 
                                        streamPropertyPath / 
                                        value /
                                        boundOperation 
                               		)
                        
    boundOperation              = 	[ "/" qualifiedEntityTypeName ] 
									"/" 
									(
										boundActionCall / 
										boundEntityColFuncCall [ singleNavigation ] /
										boundEntityFuncCall [ collectionNavigation ] /
										boundPrimitiveFuncCall [ boundOperation / value ] /
										boundPrimitiveColFuncCall [ boundOperation ] /
										boundComplexFuncCall [ complexPropertyPath / boundOperation ] /
										boundComplexColFuncCall [ boundOperation ]
									)
                                    ; boundOperation segments can only be composed if the type of the previous segment matches 
                                    ; the type of the first parameter of the action or function being called.
									; NOTE: the qualifiedEntityTypeName is only permitted if the previous segment is an Entity or Collection of Entities.

    primitivePropertyPath       = 	[ "/ qualifiedEntityTypeName" ] "/" ( primitiveKeyProperty / primitiveNonKeyProperty ) [ value ]
    
    complexPropertyPath     	=  	[ "/ qualifiedEntityTypeName" ] "/" complexProperty 
									[ 
										primitivePropertyPath / 
										complexPropertyPath /
										collectionPropertyPath /
										boundOperation
									] 

	collectionPropertyPath		=	[ "/" qualifiedEntityType ] "/" ( primitiveColProperty / complexColProperty ) [ boundOperation ]

    streamPropertyPath     		= 	[ "/" qualifiedEntityType ] "/" streamProperty

    value                   	= 	"/$value"

	key 						= 	simpleKey / compoundKey

	simpleKey 					= 	"(" primitiveLiteral ")"

	compoundKey 				= 	"(" keyValuePair 1*("," keyValuePair) ")"

    keyValuePair 				= 	primitiveKeyProperty "=" keyPropertyValue

	keyPropertyValue			= 	primitiveLiteral

	actionCall					= 	[ operationQualifier ] action [ "()" ]

	boundActionCall				= 	[ operationQualifier ] action [ "()" ]
									; with the added restriction that the binding parameter MUST be either an Entity or Collection of Entities
                                    ; and is specified by reference using the Uri immediately preceding (to the left) of the boundActionCall

	entityFunctionCall			= 	fullEntityFunctionCall functionParameters

	entityColFunctionCall		=	fullEntityColFunctionCall functionParameters

	complexFunctionCall			= 	fullComplexFunctionCall functionParameters

	complexColFunctionCall		= 	fullComplexColFunctionCall functionParameters

	primitiveFunctionCall		= 	fullPrimitiveFunctionCall functionParameters

	primitiveColFunctionCall	= 	fullPrimitiveFunctionCall functionParameters

	functionCall				= 	entityFunctionCall / 
									entityColFunctionCall /
									complexFunctionCall / 
									complexColFunctionCall /
									primitiveFunctionCall /
									primitiveColFunctionCall

	boundEntityFuncCall			= 	fullEntityFunctionCall functionParameters
									; with the added restrictions that the Function MUST support binding, and the binding parameter type 
									; MUST match the type of resource identified by Uri immediately preceding (to the left) of the boundEntityFuncCall
									; and the functionParameters MUST NOT include the bindingParameter.

	boundEntityColFuncCall		=	fullEntityColFunctionCall functionParameters
									; with the added restrictions that the Function MUST support binding, and the binding parameter type 
									; MUST match the type of resource identified by Uri immediately preceding (to the left) of the boundEntityColFuncCall
									; and the functionParameters MUST NOT include the bindingParameter.

	boundComplexFuncCall		= 	fullComplexFunctionCall functionParameters
									; with the added restrictions that the Function MUST support binding, and the binding parameter type 
									; MUST match the type of resource identified by Uri immediately preceding (to the left) of the boundComplexFuncCall
									; and the functionParameters MUST NOT include the bindingParameter.

	boundComplexColFuncCall		= 	fullComplexColFunctionCall functionParameters
									; with the added restrictions that the Function MUST support binding, and the binding parameter type 
									; MUST match the type of resource identified by Uri immediately preceding (to the left) of the boundComplexColFuncCall
									; and the functionParameters MUST NOT include the bindingParameter.

	boundPrimitiveFuncCall		= 	fullPrimitiveFunctionCall functionParameters
									; with the added restrictions that the Function MUST support binding, and the binding parameter type 
									; MUST match the type of resource identified by Uri immediately preceding (to the left) of the boundPrimitiveFuncCall
									; and the functionParameters MUST NOT include the bindingParameter.

	boundPrimitiveColFuncCall	= 	fullPrimitiveFunctionCall functionParameters
									; with the added restrictions that the Function MUST support binding, and the binding parameter type 
									; MUST match the type of resource identified by Uri immediately preceding (to the left) of the boundPrimitiveColFuncCall
									; and the functionParameters MUST NOT include the bindingParameter.

	boundFunctionCall			= 	boundEntityFuncCall / 
									boundEntityColFuncCall /
									boundComplexFuncCall / 
									boundComplexColFuncCall /
									boundPrimitiveFuncCall /
									boundPrimitiveColFuncCall

	functionParameters 			= 	"(" [ functionParameter *( "," functionParameter ) ] ")"

	functionParameter 			= 	functionParameterName "=" ( primitiveParameterValue / parameterAlias )

    primitiveParameterValue 	= 	primitiveLiteral

    parameterAlias 				= 	"@" *pchar

	aliasAndValue				= 	parameterAlias "=" parameterValue

	parameterAndValue			= 	functionParameterName "=" parameterValue

	primitivePropInJSONLight	=	TODO: arlo JSON Light format
									; unreferenced until complexInJSONLight is defined.

	primitivePropertyInVJSON	=	( primitiveKeyProperty / primitiveNonKeyProperty ) name-separator primitiveLiteralInVJSON

	complexPropertyInJSON		= 	complexPropertyInVJSON / complexPropertyInJSONLight

	complexPropertyInVJSON		= 	complexProperty name-separator complexInVJSON

	complexPropertyInJSONLight	= 	TODO: arlo JSON Light format.

	collectionPropertyInJSON	= 	colPropertyInJSONLight / collectionPropertyInVJSON

	collectionPropertyInVJSON	= 	( primitiveColProperty name-separator "[" [ primitiveVJSONLiteral *( COMMA primitiveLiteralInVJSON ) ] "]" /
									( complexColProperty name-separator "[" [ complexInVJSON *( COMMA complexInVJSON ) ] "]" /
		
	colPropertyInJSONLight 		= 	TODO: alro JSON Light format

	primitiveLiteralInVJSON		= 	TODO: arlo VJSON format.

	primitiveLiteralInJSONLight	= 	TODO: arlo JSON Light format.
							
	complexTypeMetadataInVJSON 	= 	quotation-mark "__metadata" quotation-mark
                   					name-separator
                   					begin-object
                   					[typeNVPInVJSON]
                   					end-object

	typeNVPInVJSON				= 	quotation-mark "type" quotation-mark
                    				name-separator
                    				quotation-mark qualifiedTypeName quotation-mark

	parameterValue				= 	primitiveLiteral / 						; note this is a Uri literal not a JSON literal
									complexTypeInJSON / 
									primitiveColInJSON /
									complexColInJSON

	complexInJSON				=	complexInVJSON / complexInJSONLight

	complexInJSONLight			= 	TODO: arlo JSON light format

	complexInVJSON 				= 	begin-object
                  					[
                    					(
					                      	complexTypeMetadataInVJSON / 
											primitivePropertyInVJSON /
											complexPropertyInVJSON /
											collectionPropertyInVJSON  
					                    )
					                    *( 
					                      	value-separator 
											( 
												primitivePropertyInVJSON /
												complexPropertyInVJSON /
												collectionPropertyInVJSON  
											) 
					                    )
					                ]  
									end-object


	entityServiceOpCall			= 	[ operationQualifier ] entityServiceOp [ "()" ]
	
	entityColServiceOpCall		=	[ operationQualifier ] entityColServiceOp [ "()" ]
	
	complexServiceOpCall		= 	[ operationQualifier ] complexServiceOp [ "()" ]
	
	complexColServiceOpCall		= 	[ operationQualifier ] complexColServiceOp [ "()" ]
	
	primitiveServiceOpCall		= 	[ operationQualifier ] primitiveServiceOp [ "()" ]
	
	primitiveColServiceOpCall	= 	[ operationQualifier ] primitiveServiceOp [ "()" ]

	serviceOperationCall    	=	entityServiceOpCall / 
									entityColServiceOpCall /
									complexServiceOpCall / 
									complexColServiceOpCall /
									primitiveServiceOpCall /
									primitiveColServiceOpCall 

	serviceOpParameterName		= 	odataIdentifier;
									; identifies by name a parameter to a ServiceOperation
	
	sopParameterNameAndValue	= 	serviceOperationParameterName "=" primitiveParameterValue
									; when a serviceOperation Parameter is omitted the parameter value MUST be assumed to be null		
    
	commonExpr		 			= 	[ WSP ] (
										boolCommonExpr / 
										methodCallExpr /
	             						parenExpr / 
										literalExpr / 
										addExpr /
	             						subExpr / 
										mulExpr / 
										divExpr /
	             						modExpr /  
										negateExpr / 
										memberExpr / 
										firstMemberExpr / 
										castExpr / 
										functionCallExpr 
									) [ WSP ]

	boolCommonExpr 				= 	[ WSP ] (
										boolLiteralExpr / 
										andExpr /
              							orExpr /
              							boolPrimitiveMemberExpr / 
										eqExpr / 
										neExpr /
              							ltExpr / 
										leExpr / 
										gtExpr /
              							geExpr / 
										notExpr / 
										isofExpr /
              							boolCastExpr / 
										boolMethodCallExpr  /
              							firstBoolPrimitiveMemExpr / 
										boolParenExpr /
              							boolFunctionCallExpr
									) [ WSP ]

	boolLiteralExpr				=   boolean

	literalExpr					=	primitiveLiteral

	parenExpr		 			= 	"(" [ WSP ] commonExpr [ WSP ] ")"

	boolParenExpr		 		= 	"(" [ WSP ] boolCommonExpr [ WSP ] ")"

	andExpr		 				= 	boolCommonExpr WSP "and" WSP boolCommonExpr

	orExpr		 				= 	boolCommonExpr WSP "or" WSP boolCommonExpr

	eqExpr      				= 	commonExpr WSP "eq" WSP commonExpr      

	neExpr       				= 	commonExpr WSP "ne" WSP commonExpr

	ltExpr       				= 	commonExpr WSP "lt" WSP commonExpr

	leExpr       				= 	commonExpr WSP "le" WSP commonExpr

	gtExpr       				= 	commonExpr WSP "gt" WSP commonExpr

	geExpr       				= 	commonExpr WSP "ge" WSP commonExpr

	addExpr       				= 	commonExpr WSP "add" WSP commonExpr

	subExpr       				= 	commonExpr WSP "sub" WSP commonExpr

	mulExpr       				= 	commonExpr WSP "mul" WSP commonExpr

	divExpr       				= 	commonExpr WSP "div" WSP commonExpr

	modExpr       				= 	commonExpr WSP "mod" WSP commonExpr

	negateExpr       			= 	"-" [ WSP ] commonExpr

	notExpr       				= 	"not" WSP commonExpr

	isofExpr       				= 	"isof" [ WSP ] "(" [ [ WSP ] commonExpr [ WSP ] "," ] [ WSP ] string [ WSP ] ")"

	castExpr       				= 	"cast" [ WSP ] "(" [ [ WSP ] commonExpr [ WSP ] "," ] [ WSP ] string [ WSP ] ")"

	boolCastExpr       			= 	"cast" [ WSP ] "(" [ [ WSP ] commonExpr [ WSP ] "," ] [ WSP ] "Edm.Boolean" [ WSP ] ")"

	firstMemberExpr       		= 	[ WSP ] [ qualifiedEntityTypeName "/"]
                        			[ lambdaPredicatePrefixExpr ]
                        			; A lambdaPredicatePrefixExpr is only defined inside a 
                        			; lambdaPredicateExpr. A lambdaPredicateExpr is required   
                        			; inside a lambdaPredicateExpr.
                        			entityColNavigationProperty [ collectionNavigationExpr ] ) /
                                    entityNavigationProperty [ singleNavigationExpr ] ) /
									primitivePropertyPath / 
                                    complexPropertyPath /
									collectionPropertyPath [ anyExpr / allExpr ]

	firstBoolPrimitiveMemExpr 	= 	[ qualifiedEntityTypeName "/"] entityProperty

	boolPrimitiveMemberExpr	 	= 	commonExpr [ WSP ]  "/" [WSP]
                                	[ qualifiedEntityTypeName "/" ] primitivePropertyPath

	memberExpr       			= 	commonExpr [ WSP ]  "/" [ WSP ] [ qualifiedEntityTypeName "/" ]
									entityColNavigationProperty [ collectionNavigationExpr ] ) /
                                    entityNavigationProperty [ singleNavigationExpr ] ) /
									primitivePropertyPath / 
                                    complexPropertyPath /
									collectionPropertyPath [ anyExpr / allExpr ]

	collectionNavigationExpr	= 	[ "/" qualifiedEntityTypeName ] "/" 
									(
                                  		boundFunctionExpr /
										anyExpr / 
										allExpr
									)

	singleNavigationExpr		= 	[ "/" qualifiedEntityTypeName ] "/"
                                    ( 
                                        ( entityColNavigationProperty [ collectionNavigationExpr ] ) /
                                        ( entityNavigationProperty [ singleNavigationExpr ] ) /
										primitivePropertyPath / 
                                        complexPropertyPath /
										collectionPropertyPath [ anyExpr / allExpr ] / 
                                        streamPropertyPath / 
                                        boundFunctionExpr 
                               		)
	
	functionExpr				= 	(
										entityColFuncCall [ singleNavigationExpr ] /
										entityFuncCall [ collectionNavigationExpr ] /
										primitiveFuncCall [ boundOperationExpr ] /
										primitiveColFuncCall [ boundOperationExpr ] /
										complexFuncCall [ complexPropertyPath / boundOperationExpr ] /
										bomplexColFuncCall [ boundOperationExpr ]
									)

	boolFunctionExpr 			= 	functionExpr
                       				; with the added restriction that the boolFunctionExpr MUST return a boolean value
	
	boundFunctionExpr			= 	[ "/" qualifiedEntityTypeName ] 
									"/" 
									(
										boundEntityColFuncCall [ singleNavigationExpr ] /
										boundEntityFuncCall [ collectionNavigationExpr ] /
										boundPrimitiveFuncCall [ boundFunctionExpr ] /
										boundPrimitiveColFuncCall [ boundFunctionExpr ] /
										boundComplexFuncCall [ complexPropertyPath / boundFunctionExpr ] /
										boundComplexColFuncCall [ boundFunctionExpr ]
									)
                                    ; boundOperation segments can only be composed if the type of the previous segment matches 
                                    ; the type of the first parameter of the action or function being called.
									; NOTE: the qualifiedEntityTypeName is only permitted if the previous segment is an Entity or Collection of Entities.

	boolBoundFunctionExpr		= 	boundFunctionExpr
									; with the added restriction that the boolBoundFunctionExpr MUST return a boolean value

	anyExpr      				=	"any(" [ lambdaVariableExpr ":" lambdaPredicateExpr ] ")"

	allExpr      				=   "all(" lambdaVariableExpr ":" lambdaPredicateExpr ")"

  	implicitVariableExpr       	= 	"$it"
        							; references the unnamed outer variable of the query

  	lambdaVariableExpr         	= 	odataIdentifier

  	inscopeVariableExpr        	=  	implicitVariableExpr | lambdaVariableExpr
    								; the lambdaVariableExpr must be the name of a variable introduced by either the 
    								; current lambdaMethodCallExpr’s lambdaVariableExpr or via a wrapping    
    								; lambdaMethodCallExpr’s lambdaVariableExpr.


  	lambdaPredicateExpr       	= 	boolCommonExpr
    								; this is a boolCommonExpr with the added restriction that any 
    								; firstMemberExprs inside the methodPredicateExpr MUST have a prefix of
    								; lambdaPredicatePrefixExpr
   
	methodCallExpr       		= 	boolMethodExpr /
                       				indexOfMethodCallExpr /
                       				replaceMethodCallExpr / 
                       				toLowerMethodCallExpr /
                       				toUpperMethodCallExpr / 
                       				trimMethodCallExpr /
                       				substringMethodCallExpr /
                       				concatMethodCallExpr /
                       				lengthMethodCallExpr /
                       				yearMethodCallExpr /
                       				monthMethodCallExpr /
                       				dayMethodCallExpr /
                      				hourMethodCallExpr /
                      				minuteMethodCallExpr /
                       				secondMethodCallExpr /
                       				roundMethodCallExpr /
                      				floorMethodCallExpr /
                      				ceilingMethodCallExpr /
                       				distanceMethodCallExpr /
                      				geoLengthMethodCallExpr /
									getTotalOffsetMinutesExpr

	boolMethodExpr       		= 	endsWithMethodCallExpr /
                       				startsWithMethodCallExpr /
                      				substringOfMethodCallExpr /                                         
                       				intersectsMethodCallExpr /
                       				anyMethodCallExpr /
                       				allMethodCallExpr

	endsWithMethodCallExpr 		= 	"endswith" [WSP]
                               		"(" [WSP] commonExpr [WSP]
                               		"," [WSP] commonExpr  [WSP] ")"

	indexOfMethodCallExpr 		= 	"indexof" [WSP]
                              		"(" [WSP] commonExpr [WSP]
                               		"," [WSP] commonExpr [WSP] ")"

	replaceMethodCallExpr 		=  "replace" [WSP]
                               		"(" [WSP] commonExpr [WSP]
                               		"," [WSP] commonExpr [WSP]
                               		"," [WSP] commonExpr [WSP] ")"

	startsWithMethodCallExpr  	= 	"startswith" [WSP]
                                 	"(" [WSP] commonExpr [WSP]
                                 	"," [WSP] commonExpr  [WSP] ")"

	toLowerMethodCallExpr       = 	"tolower" [WSP]
                              		"(" [WSP] commonExpr [WSP] ")"

	toUpperMethodCallExpr       = 	"toupper" [WSP]
                              		"(" [WSP] commonExpr [WSP] ")"

	trimMethodCallExpr      	= 	"trim" [WSP]
                           			"(" [WSP] commonExpr [WSP] ")"

	substringMethodCallExp    	= 	"substring" [WSP]
                                	"(" [WSP] commonExpr [WSP]
                                	"," [WSP] commonExpr [WSP]
                                	[ "," [WSP] commonExpr  [WSP] ] ")"

	substringOfMethodCallExpr  	= 	"substringof" [WSP]
                                  	"(" [WSP] commonExpr [WSP]
                                  	[ "," [WSP] commonExpr [WSP] ] ")"

	concatMethodCallExpr       	= 	"concat" [WSP]
                             		"(" [WSP] commonExpr [WSP]
                             		[ "," [WSP] commonExpr [WSP] ] ")"

	lengthMethodCallExpr       	= 	"length" [WSP]
                             		"(" [WSP] commonExpr [WSP] ")"

	getTotalOffsetMinutesExpr  	= 	"gettotaloffsetminutes" [WSP]
                             		"(" [WSP] commonExpr [WSP] ")" 

	yearMethodCallExpr       	= 	"year" [WSP]
                           			"(" [WSP] commonExpr [WSP] ")"

	monthMethodCallExpr       	= 	"month" [WSP]
                            		"(" [WSP] commonExpr [WSP] ")"

	dayMethodCallExpr       	= 	"day" [WSP]
                          			"(" [WSP] commonExpr [WSP] ")"

	hourMethodCallExpr       	= 	"hour" [WSP]
                           			"(" [WSP] commonExpr [WSP] ")"

	minuteMethodCallExpr       	= 	"minute" [WSP]
                             		"(" [WSP] commonExpr [WSP] ")"

	secondMethodCallExpr       	= 	"second" [WSP]
                             		"(" [WSP] commonExpr [WSP] ")"

	roundMethodCallExpr       	= 	"round" [WSP]
                            		"(" [WSP] commonExpr [WSP] ")"

	floorMethodCallExpr       	= 	"floor" [WSP]
                            		"(" [WSP] commonExpr [WSP] ")"

	ceilingMethodCallExpr       = 	"ceiling" [WSP]
                              		"(" [WSP] commonExpr [WSP] ")"

	distanceMethodCallExpr  	= 	"geo.distance" [WSP]
                               		"(" [WSP] commonExpr [WSP]
                               		"," [WSP] commonExpr  [WSP] ")"

	geoLengthMethodCallExpr  	= 	"geo.length" [WSP]
                               		"(" [WSP] commonExpr [WSP] ")"

	intersectsMethodCallExpr  	= 	"geo.intersects" [WSP]
                               		"(" [WSP] commonExpr [WSP]
                               		"," [WSP] commonExpr  [WSP] ")"




  




