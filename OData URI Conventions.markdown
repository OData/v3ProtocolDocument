# OData URI Conventions #

## 1.0 Introduction ##
The Open Data Protocol (OData) enables the creation of REST-based data services, which allow resources, identified using Uniform Resource Identifiers (URIs) and defined in a data model, to be published and edited by Web clients using simple HTTP messages. This specification defines a set of recommended (but not required) rules for constructing URIs to identify the data and metadata exposed by an OData server as well as a set of reserved URI query string operators, which if accepted by an OData server, MUST be implemented as required by this document.

The [OData:Atom] and [OData:JSON] documents specify the format of the resource representations that are exchanged using OData and the [OData:Operations] document describes the actions that can be performed on the URIs (optionally constructed following the conventions defined in this document) embedded in those representations.

Servers are encouraged to follow the URI construction conventions defined in this specification when possible as  consistency promotes an ecosystem of reusable client components and libraries.

## 2.0 Uri Components ##
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

## 3.0 Service Root URI ##
The service root URI identifies the root of an OData service. The resource identified by this URI MUST be an AtomPub Service Document (as specified in [RFC5023]) and follow the OData conventions for AtomPub Service Documents (or an alternate representation of an Atom Service Document if a different format is requested). OData: JSON Format specifies such an alternate JSON-based representation of a service document. The service document is required to be returned from the root of an OData service to provide clients with a simple mechanism to enumerate all of the collections of resources available for the data service.

## 4.0 Resource Path ##
The resource path construction rules defined in this section are optional. OData servers are encouraged to follow the URI path construction rules (in addition to the required query string rules) as such consistency promotes a rich ecosystem of reusable client components and libraries.

The resource path section of a URI identifies the resource to be interacted with (such as Customers, a single Customer, Orders related to Customers in London, and so forth). The resource path enables any aspect of the data model (Collections of Entries, a single Entry, Properties, Links, Service Operations, and so on) exposed by an OData service to be addressed.

### 4.1 Addressing Entities ###
The basic rules for addressing a Collection (of Entities), a single Entity within a Collection, as well as a property of an Entity are covered in the 'resourcePath' syntax rule in Appendix A. 

Below is a snippet from Appendix A:

	resourcePath				= 	[ entityContainerName "." ] entitySetName [collectionNavigation] /
									( entityColServiceOpCall / entityColFunctionCall ) [ collectionNavigation ] /
									( entityServiceOpCall	/ entityFunctionCall ) [ singleNavigation ] /
									( complexColServiceOpCall / complexColFunctionCall ) [ boundOperation ] /
									( complexServiceOpCall / complexFunctionCall ) [ boundOperation / complexPropertyPath ] /
									( primitiveColServiceOpCall / primitiveColFunctionCall ) [ boundOperation ] /
									( primitiveServiceOpCall / primitiveFunctionCall ) [ boundOperation / value ] /
									actionCall 

Since OData has a uniform composable URI syntax and associated rules there are many ways to address a collection of entities, including, but not limited to:

- Via an EntitySet (see rule: entitySetName)

		For Example: http://services.odata.org/OData/OData.svc/Products

- By invoking a Function that returns a collection of Entities (see rule: entityColFunctionCall)

		For Example: http://services.odata.org/OData/OData.svc/GetProductsByCategoryId(categoryId=2)

- By invoking an Action that returns a collection of Entities (see rule: actionCall)
- By invoking a ServiceOperation that returns a collection of Entities (see rule: entityColServiceOpCall)

		For Example: http://services.odata.org/OData/OData.svc/ProductsByColor?color='red'

Likewise there are many ways to address a single Entity.

Sometimes a single Entity can be accessed directly, for example by:

- Invoking a Function that returns a single Entity (see rule: entityFunctionCall)
- Invoking an Action that returns a single Entity (see rule: actionCall)
- Invoking a ServiceOperation that returns a single Entity (see rule: entityServiceOpCall)
 
Often however a single Entity is accessed by composing more path segments to a resourcePath that identifies a Collection of Entities, for example by:

- Using a entityKey to select a single Entity (see rules: collectionNavigation and keyPredicate)

		For Example: http://services.odata.org/OData/OData.svc/Categories(1)

- Invoking an Action bound to a collection of Entities that returns a singleEntity (see rule: boundOperation)
- Invoking an Function bound to a collection of Entities that returns a singleEntity (see rule: boundOperation)

		For Example: http://services.odata.org/OData/OData.svc/Products/MostExpensive

These rules are recursive, so it is possible to address a single Entity via another single Entity, a collection via a single Entity and even a collection via a collection, examples include, but are not limited to:

- By following a Navigation from a single Entity to another related Entity (see rule: entityNavigationProperty)

		For Example: http://services.odata.org/OData/OData.svc/Products(1)/Supplier

- By invoking a Function bound to a single Entity that returns a single Entity (see rule: boundOperation)

		For Example: http://services.odata.org/OData/OData.svc/Products(1)/MostRecentOrder

- By invoking an Action bound to a single Entity that returns a single Entity (see rule: boundOperation)
- By following a Navigation from a single Entity to a related collection of Entities (see rule: entityColNavigationProperty)

		For Example: http://services.odata.org/OData/OData.svc/Categories(1)/Products

- By invoking a Function bound to a single Entity that returns a collection of Entities (see rule: boundOperation)

		For Example: http://services.odata.org/OData/OData.svc/Categories(1)/TopTenProducts

- By invoking an Action bound to a single Entity that returns a collection of Entities (see rule: boundOperation)
- By invoking a Function bound to a collection of Entities that returns a collection of Entities (see rule: boundOperation)

		For Example: http://services.odata.org/OData/OData.svc/Categories(1)/Products/AllOrders

- By invoking an Action bound to a collection of Entities that returns a collection of Entities (see rule: boundOperation)

Finally it is possible to compose path segments onto a resourcePath that identifies a Primivite, Complex instance, Collection of Primitives or Collection of Complex instances and bind an Action or Function that returns a Entity or Collections of Entities.

#### 4.1.1 Canonical Uri ####
For OData services conformant with the addressing conventions in this section, the canonical form of an absolute URI identifying a non contained Entity is formed by adding a single path segment to the service root URI. The path segment is made up of the name of the EntitySet associated with the Entity followed by the key predicate identifying the Entry within the Collection. 

For example the URIs [http://services.odata.org/OData/OData.svc/Categories(1)/Products(1)](http://services.odata.org/OData/OData.svc/Categories(1)/Products(1)) and [http://services.odata.org/OData/OData.svc/Products(1)](http://services.odata.org/OData/OData.svc/Products(1)) represent the same Entry, but the canonical URI for the Entry is [http://services.odata.org/OData/OData.svc/Products(1)](http://services.odata.org/OData/OData.svc/Products(1)).

For contained Entities the canonical Uri begins with canonical Uri of the parent, with further path segments that:

- Name and navigation throught the Containing NavigationProperty 
- and, if the NavigationProperty returns a Collection, an EntityKey (see rule: entityKey) that uniquely identifies the entity in that collection.

### 4.2 Addressing Links between Entities ###
Much like the use of links on Web pages, the data model used by OData services supports relationships as a first class construct. For example, an OData service could expose a Collection of Products Entries each of which are related to a Category Entry.

Links between Entries are addressable in OData just like Entries themselves are (as described above). The basic rules for addressing relationships are shown in the following figure. By the following rule:

	entityUri 		= 	; any uri that identifies a single entity
						; examples include: an entitySet followed by a key or a function/serviceOperation that returns a single entity.
	links 			= 	entityUri "$links" / navigationPropertyName   

For example: [http://services.odata.org/OData/OData.svc/Category(1)/$links/Products](http://services.odata.org/OData/OData.svc/Category(1)/$links/Products) addresses the links between Category(1) and Products.

### 4.3 Addressing Operations ###

#### 4.3.1 Addressing Service Operations ####
OData services can expose Service Operations which, like Entries, are identified using a URI. Service Operations are simple functions exposed by an OData service whose semantics are defined by the author of the function. A Service Operation can accept primitive type input parameters and can be defined to return a single primitive, single complex type, collection of primitives, collection of complex types, a single Entry, a Collection of Entries, or void. The basic rules for constructing URIs to address Service Operations and to pass parameters to them are illustrated in the following figure.

TODO: AlexJ - needs rewording to sync with ABNF
- ServiceRootUri: The service root URI identifies the root of the OData service.
- ServiceOperation: The name of a Service Operation exposed by an OData service.
- ParamName: The name of a parameter accepted by the Service Operation. If the Service Operation accepts multiple parameters, the order of the parameters in the query string of the URI is insignificant.
- ParamValue: The value of the parameter. The format of the value is defined by the literal forms governed by the Syntax rule 'primitiveLiteral' in Appendix A.

##### 4.3.1.1 Examples #####
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

#### 4.3.2 Addressing Functions ####
TODO: AlexJ - extract appropriate content from 'Invoking a Function in OData.markdown'

#### 4.3.3 Addressing Actions ####
TODO: AlexJ - extract appropriate content from 'Invoking an Action in OData.markdown'

## 5.0 Query String Options ##
The Query Options section of an OData URI specifies three types of information: System Query Options, Custom Query Options, and Operation (Function and ServiceOperation) Parameters. All OData services MUST follow the query string parsing and construction rules defined in this section and its subsections.

### 5.1 System Query Options ###
System Query Options are query string parameters a client may specify to control the amount and order of the data that an OData service returns for the resource identified by the URI. The names of all System Query Options are prefixed with a "$" character. 

An OData service may support some or all of the System Query Options defined. If a data service does not support a System Query Option, it must reject any requests which contain the unsupported option.

The semantics of all System Query Options are defined in the [OData:Core](OData) document.

The grammar and syntax rules the System Query Options are defined in  

### 5.1.2 Filter System Query Option ###
The $filter system query option allows clients to filter the set of resources that are addressed by a request uri. 
$filter specifies conditions that MUST be met by a resource for it to be returned in the set of matching resources. 

The semantics of $filter are covered in the [OData:core](OData) document.

The [filter](#filterRule) syntax rule defines the formal grammar of the $filter query option.

#### 5.1.2.1 Logical Operators ####
OData defines a set of logical operators that evaluate to true or false (i.e. a boolCommonExpr as defined in Appendix A).
Logical Operators are typically used in the Filter System Query Option to filter the set of resources.
However Servers MAY allow for the use of Logical Operators with the OrderBy System Query Option.
 
The syntax rules for the Logical Operators are defined in Appendix A.

##### 5.1.2.1.1 Equals Operator #####
The Equals operator (or 'eq') evaluates to true if the left operand is equal to the right operand, otherwise if evaluates to false.

##### 5.1.2.1.2 Not Equals Operator #####
The Not Equals operator (or 'ne') evaluates to true if the left operand is not equal to the right operand, otherwise if evaluates to false. 	
 
##### 5.1.2.1.3 Greater Than Operator #####
The Greater Than operator (or 'gt') evaluates to true if the left operand is greater than the right operand, otherwise if evaluates to false. 	

##### 5.1.2.1.4 Greater Than or Equal Operator #####
The Greater Than or Equal operator (or 'ge') evaluates to true if the left operand is greater than or equal to the right operand, otherwise if evaluates to false. 

##### 5.1.2.1.5 Less Than Operator #####
The Less Than operator (or 'lt') evaluates to true if the left operand is less than the right operand, otherwise if evaluates to false.

##### 5.1.2.1.6 Less Than or Equal Operator #####
The Less Than operator (or 'le') evaluates to true if the left operand is less than or equal to the right operand, otherwise if evaluates to false.

##### 5.1.2.1.7 Logical And Operator #####
The Logical And operator (or 'and') evaluates to true if both the left and right operands both evaluate to true, otherwise if evaluates to false.

##### 5.1.2.1.8 Logical Or Operator #####
The Logical Or operator (or 'or') evaluates to false if both the left and right operands both evaluate to false, otherwise if evaluates to true.

##### 5.1.2.1.9 Logical Negation Operator #####
The Logical Negation Operator (or 'not') evaluates to true if the operand evaluates to false, otherwise it evalutes to false.

##### 5.1.2.1.10 Examples #####
The following examples illustrate the use and semantics of each of the logical operators:	

	http://services.odata.org/OData/OData.svc/Products?$filter=Name eq 'Milk' (Requests all products with a Name equal to 'Milk').

	http://services.odata.org/OData/OData.svc/Products?$filter=Name ne 'Milk' (Requests all products with a Name not equal to 'Milk').

	http://services.odata.org/OData/OData.svc/Products?$filter=Name gt 'Milk' (Requests all products with a Name greater than 'Milk'). 

	http://services.odata.org/OData/OData.svc/Products?$filter=Name ge 'Milk' (Requests all products with a Name greater than or equal to 'Milk').

	http://services.odata.org/OData/OData.svc/Products?$filter=Name lt 'Milk' (Requests all products with a Name less than 'Milk').

	http://services.odata.org/OData/OData.svc/Products?$filter=Name le 'Milk' (Requests all products with a Name less than or equal to 'Milk').

	http://services.odata.org/OData/OData.svc/Products?$filter=Name eq 'Milk' and Price lt '2.55M' (Requests all products with the Name 'Milk' that also have a Price less than 2.55).

	http://services.odata.org/OData/OData.svc/Products?$filter=Name eq 'Milk' or Price lt '2.55M' (Requests all products that either have the Name 'Milk' or have a Price less than 2.55).

	http://services.odata.org/OData/OData.svc/Products?$filter=not endswith(Name, 'ilk') (Requests all products that do not have a Name that ends with 'ilk'). 

#### 5.1.2.2 Arithmetic Operators ####
OData defines a set of arithmetic operators that require operands that evaluate to numeric types.
Arithmetic Operators are typically used in the Filter System Query Option to filter the set of resources.
However Servers MAY allow for the use of Arithmetic Operators with the OrderBy System Query Option.

The syntax rules for the Arithmetic Operators are defined in Appendix A.

##### 5.1.2.2.1 Addition Operator #####
The Addition Operator (or 'add') adds the left and right numeric operands together.

##### 5.1.2.2.2 Subtraction Operator #####
The Subtraction Operator (or 'sub') subtracts the right numeric operand from the left numeric operand.

##### 5.1.2.2.3 Multiplication Operator #####
The Multiplication Operator (or 'mul') multiples the left and right numeric operands together.

##### 5.1.2.2.4 Division Operator #####
The Division Operator (or 'div') divides the left numeric operand by the right numeric operand.

##### 5.1.2.2.5 Modulo Operator #####
The Modulo Operator (or 'mod') evaluates to the remainder when the left integral operand is divided by the right integral operand.

##### 5.1.2.2.6 Examples ######
The following examples illustrate the use and semantics of each of the Arithmetic operators:

	http://services.odata.org/OData/OData.svc/Products?$filter=Price add 2.45M eq '5.00M' (Requests all products with a Price of 2.55M).

	http://services.odata.org/OData/OData.svc/Products?$filter=Price sub 0.55M eq '2.00M' (Requests all products with a Price of 2.55M).

	http://services.odata.org/OData/OData.svc/Products?$filter=Price mul 2.0M eq '5.10M' (Requests all products with a Price of 2.55M).

	http://services.odata.org/OData/OData.svc/Products?$filter=Price div 2.55M eq '1M' (Requests all products with a Price of 2.55M).

	http://services.odata.org/OData/OData.svc/Products?$filter=Rating mod 5 eq 0 (Requests all products with a Rating exactly divisable by 5).

#### 5.1.2.3 Parenthesis Operator ####
he Parenthesis Operator (or '( )') overrides the group an expression, so that Parenthesis Operator evaluates to the expression grouped inside the parenthesis. For example:

	http://services.odata.org/OData/OData.svc/Products?$filter=( 4 add 5 ) mod ( 4 sub 1 ) eq 0

Requests all products, because 9 mod 3 is 0. 

#### 5.1.2.4 Canonical Functions ####
In addition to operators, a set of functions are also defined for use with the filter query string operator. The following table lists the available functions. Note: ISNULL or COALESCE operators are not defined. Instead, there is a null literal which can be used in comparisons.

The syntax rules for all canonical functions are defined in Appendix A.

##### 5.1.2.4.1 substringof #####
The substringof canonical function has this signature:

	Edm.Boolean substringof(Edm.String, Edm.String)

If implemented the substringof canonical function MUST return true if, and only if, the second parameter string value contains the first parameter string value.
The substringOfMethodCallExpr syntax rule defines how the substringof function is invoked.

For example:
	
	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=substringof('Alfreds', CompanyName) eq true

Returns all Customers with a CompanyName that contains 'Alfreds'.

##### 5.1.2.4.2 endswith #####
The endswith canonical function has this signature:

	Edm.Boolean endswith(Edm.String, Edm.String)

If implemented the endswith canonical function MUST returns true if, and only if, the first parameter string value ends with the second parameter string value.
The endsWithMethodCallExpr syntax rule defines how the endswith function is invoked.

For example:

	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=endswith(CompanyName, 'Futterkiste')

Returns all Customers with a CompanyName that end with 'Futterkiste'.

##### 5.1.2.4.3 startswith #####
The startswith canonical function has this signature:

	Edm.Boolean startswith(Edm.String, Edm.String)

If implemented the startswith canonical function MUST return true if, and only if, the first parameter string value starts with the second parameter string value.
The startsWithMethodCallExpr syntax rule defines how the startswith function is invoked.

For example:

	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=startswith(CompanyName, 'Alfr')
 
Returns all Customers with a CompanyName that starts with 'Alfr'

##### 5.1.2.4.4 length #####
The length canonical function has this signature:

	Edm.Int32 length(Edm.String)

If implemented the length canonical function MUST return the number of characters in the parameter value.
The lengthMethodCallExpr syntax rule defines how the startswith function is invoked.

For example:

	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=length(CompanyName) eq 19
 
Returns all Customers with a CompanyName that is 19 characters long.

##### 5.1.2.4.5 indexof #####
The length canonical function has this signature:

	Edm.Int32 indexof(Edm.String, Edm.String)

If implemented the indexof canonical function MUST return the zero based character position of the first occurance of the second parameter value in the first parameter value.
The indexOfMethodCallExpr syntax rule defines how the startswith function is invoked.

For example:

	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=indexof(CompanyName, 'lfreds') eq 1
 
Returns all Customers with a CompanyName containing 'lfreds' starting at the second character. 
 
##### 5.1.2.4.6 replace #####
The replace canonical function has this signature:

	Edm.String replace(Edm.String, Edm.String, Edm.String)

If implemented the replace canonical function MUST return the first parameter value, with all occurances of the second parameter value replaced by the third parameter value.
The replaceMethodCallExpr syntax rule defines how the replace function is invoked.

For example:

	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=replace(CompanyName, ' ', '') eq 'AlfredsFutterkiste'
 
Returns all Customers with a CompanyName that equals 'AlfredsFutterkiste' once ' ' has been replaced by ''. 

##### 5.1.2.4.7 substring ######
The substring canonical function has consists of two overloads, with the following signatures:
	 
	Edm.String substring(Edm.String, Edm.Int32)
	Edm.String replace(Edm.String, Edm.Int32, Edm.Int32)

If implemented the two argument substring canonical function MUST return a substring of the first parameter string value, starting at the Nth character and finishing at the last character (where N is the second parameter integer value).
If implemented the three argument substring canonical function MUST return a substring of the first parameter string value identified by selecting M characters starting at the Nth character (where N is the second parameter integer value and M is the third parameter integer value).

The substringMethodCallExpr syntax rule defines how the substring canonical functions are invoked.

For example:
 
	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=substring(CompanyName, 1) eq 'lfreds Futterkiste'
 
Returns all customers with a CompanyName of 'lfreds Futterkiste' once the first character has been removed.

	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=substring(CompanyName, 1, 2) eq 'lf'
 
Returns all customers with a CompanyName that has 'lf' as the second and third characters respectively. 

##### 5.1.2.4.8 tolower #####
The tolower canonical function has this signature:

	Edm.String tolower(Edm.String)

If implemented the tolower canonical function MUST return the input parameter string value with all uppercase characters converted to lowercase.
The toLowerMethodCallExpr syntax rule defines how the tolower function is invoked.

For example:

	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=tolower(CompanyName) eq 'alfreds futterkiste'
 
Returns all Customers with a CompanyName that equals 'alfreds futterkiste' once any uppercase characters have been converted to lowercase.

##### 5.1.2.4.9 toupper ######
The toupper canonical function has this signature:

	Edm.String toupper(Edm.String)

If implemented the toupper canonical function MUST return the input parameter string value with all lowercase characters converted to uppercase.
The toUpperMethodCallExpr syntax rule defines how the tolower function is invoked.

For example:

	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=toupper(CompanyName) eq 'ALFREDS FUTTERKISTE'
 
Returns all Customers with a CompanyName that equals 'ALFREDS FUTTERKISTE' once any lowercase characters have been converted to uppercase.
 
##### 5.1.2.4.10 trim #####
The trim canonical function has this signature:

	Edm.String trim(Edm.String)

If implemented the trim canonical function MUST return the input parameter string value with all leading and trailing whitespace characters removed.
The trimMethodCallExpr syntax rule defines how the trim function is invoked.

For example:
	
	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=length(trim(CompanyName)) eq length(CompanyName)

Returns all customers with a CompanyName without leading or trailing whitespace characters.

##### 5.1.2.4.11 concat #####
The concat canonical function has this signature:

	Edm.String concat(Edm.String, Edm.String)

If implemented the concat canonical function MUST return a string that concatinates both input parameter string values together.
The concatMethodCallExpr syntax rule defines how the concat function is invoked.

For example:
	
	http://services.odata.org/Northwind/Northwind.svc/Customers?$filter=concat(concat(City, ', '), Country) eq 'Berlin, Germany'

Returns all customers with from the City of Berlin and the Country called Germany.

##### 5.1.2.4.12 year #####
The year canonical function has the following signatures:

	Edm.Int32 year(Edm.DateTime)
	Edm.Int32 year(Edm.DateTimeOffset)
	
If implemented the year canonical function MUST return the year component of the DateTime or DateTimeOffset parameter value.
The yearMethodCallExpr syntax rule defines how the year function is invoked. 

For example:

	http://services.odata.org/Northwind/Northwind.svc/Employees?$filter=year(BirthDate) eq 1971
 
Returns all Employees who were born in 1971.

##### 5.1.2.4.13 years #####
TODO: for Edm.Time

##### 5.1.2.4.14 month #####
The month canonical function has the following signatures:

	Edm.Int32 month(Edm.DateTime)
	Edm.Int32 month(Edm.DateTimeOffset)
	
If implemented the month canonical function MUST return the month component of the DateTime or DateTimeOffset parameter value.
The monthMethodCallExpr syntax rule defines how the month function is invoked. 

For example:

	http://services.odata.org/Northwind/Northwind.svc/Employees?$filter=month(BirthDate) eq 5
 
Returns all Employees who were born in May.

##### 5.1.2.4.15 day #####
The day canonical function has the following signatures:

	Edm.Int32 day(Edm.DateTime)
	Edm.Int32 day(Edm.DateTimeOffset)
	
If implemented the day canonical function MUST return the day component DateTime or DateTimeOffset parameter value.
The dayMethodCallExpr syntax rule defines how the day function is invoked. 

For example:

	http://services.odata.org/Northwind/Northwind.svc/Employees?$filter=day(BirthDate) eq 8
 
Returns all Employees who were born on the 8th day of a month.

##### 5.1.2.4.16 days #####
TODO: for Edm.Time

##### 5.1.2.4.17 hour #####
The day canonical function has the following signatures:

	Edm.Int32 hour(Edm.DateTime)
	Edm.Int32 hour(Edm.DateTimeOffset)
	
If implemented the hour canonical function MUST return the hour component of the DateTime or DateTimeOffset parameter value.
The hourMethodCallExpr syntax rule defines how the hour function is invoked. 

For example:

	http://services.odata.org/Northwind/Northwind.svc/Employees?$filter=hour(BirthDate) eq 4
 
Returns all Employees who were born in the 4th hour of a day.

##### 5.1.2.4.18 hours #####
TODO: for Edm.Time

##### 5.1.2.4.19 minute #####
The minute canonical function has the following signatures:

	Edm.Int32 minute(Edm.DateTime)
	Edm.Int32 minute(Edm.DateTimeOffset)
	
If implemented the minute canonical function MUST return the minute component of the DateTime or DateTimeOffset parameter value.
The minuteMethodCallExpr syntax rule defines how the minute function is invoked. 

For example:

	http://services.odata.org/Northwind/Northwind.svc/Employees?$filter=minute(BirthDate) eq 40
 
Returns all Employees who were born in the 40th minute of any hour on any day.

##### 5.1.2.4.20 minutes ######
TODO: for Edm.Time

##### 5.1.2.4.21 second #####
The second canonical function has the following signatures:

	Edm.Int32 second(Edm.DateTime)
	Edm.Int32 second(Edm.DateTimeOffset)
	
If implemented the second canonical function MUST return the second component of the DateTime or DateTimeOffset parameter value.
The secondMethodCallExpr syntax rule defines how the second function is invoked. 

For example:

	http://services.odata.org/Northwind/Northwind.svc/Employees?$filter=second(BirthDate) eq 40
 
Returns all Employees who were born in the 40th second of any minute of any hour on any day.

##### 5.1.2.4.22 seconds #####
TODO: for Edm.Time
 
##### 5.1.2.4.23 round #####
The round canonical function has the following signatures
	
	Edm.Double round(Edm.Double)
	Edm.Decimal round(Edm.Decimal)

If implemented the round canonical function MUST return round the input numeric parameter value to the nearest numeric value with no decimal component.
The roundMethodCallExpr syntax rule defines how the round function is invoked.
 
For example:

	http://services.odata.org/Northwind/Northwind.svc/Orders?$filter=round(Freight) eq 32
 
Returns all Orders that have a Freight cost that rounds to 32.

##### 5.1.2.4.24 floor #####
The floor canonical function has the following signatures
 
	Edm.Double floor(Edm.Double)
	Edm.Decimal floor(Edm.Decimal)

If implemented the floor canonical function MUST return round the input numeric parameter down value to the nearest numeric value with no decimal component.
The floorMethodCallExpr syntax rule defines how the floor function is invoked.
 
For example:

	http://services.odata.org/Northwind/Northwind.svc/Orders?$filter=floor(Freight) eq 32
 
Returns all Orders that have a Freight cost that rounds down to 32.

##### 5.1.2.4.25 ceiling #####
The ceiling canonical function has the following signatures
 
	Edm.Double ceiling(Edm.Double)
	Edm.Decimal ceiling(Edm.Decimal)

If implemented the ceiling canonical function MUST return round the input numeric parameter up value to the nearest numeric value with no decimal component.
The ceilingMethodCallExpr syntax rule defines how the ceiling function is invoked.
 
For example:

	http://services.odata.org/Northwind/Northwind.svc/Orders?$filter=ceiling(Freight) eq 32
 
Returns all Orders that have a Freight cost that rounds up to 32.
 
##### 5.1.2.4.26 isof #####
The isof canonical function has the following signatures

	Edm.Boolean isof(type)
	Edm.Boolean isof(expression, type)

If implemented the single parameter isof canonical function MUST return true if, and only if, the current instance is assignable to the type specified.
If implemented the two parameter isof canonical function MUST return true if, and only if, the object referred to by the expression is assignable to the type specified.

The isofMethodCallExpr syntax rule defines how the isof function is invoked.

For example:

	http://services.odata.org/Northwind/Northwind.svc/Orders?$filter=isof('NorthwindModel.BigOrder')

Returns only orders that are also BigOrders.

 	http://services.odata.org/Northwind/Northwind.svc/Orders?$filter=isof(Customer, 'NorthwindModel.MVPCustomer')

Returns only orders that have a customer that is a MVPCustomer.

##### 5.1.2.4.27 cast #####
TODO: figure out how to actually do a cast!

#### 5.1.2.5 Operator Precedence ####
OData Servers MUST use the following operator precedence for supported operators when evaluating $filter and $orderby expressions:

	GROUP 					OPERATOR			DESCRIPTION				 

	Logical Operators 		eq 					Equal 					 
							ne 					Not Equal 				 
							gt 					Greater Than 			 
							ge 					Greater Than or Equal 
							lt					Less Than 
							le 					Less Than or Equal 
							and 				Logical And 
							or 					Logical Or 
							not 				Logical Negation 

	Arithmetic Operators 	add 				Addition 
							sub 				Subtraction 
							mul 				Multiplication 
							div 				Division 
							mod 				Modulo 

	Grouping Operators 		( ) 				Precedence grouping 

### 5.1.3 Expand System Query Option ###
The $expand system query option allows clients to request related resources when a resource that satifies a particular request is retrieved.  

The semantics of $expand are covered in the [OData:core](OData) document.

The [expand](#expandRule) syntax rule defines the formal grammar of the $expand system query option.

### 5.1.4 Select System Query Option ###
The $select system query option allows clients to requests a limited set of information for each Entity or ComplexType identified by the ResourcePath and other System Query Options like $filter, $top, $skip etc. 
The $select query option is often used in conjunction with the $expand query option, to first increase the scope of the resource graph returned ($expand) and then selectively prune that resource graph ($select).

The semantics of $select are covered in the [OData:core](OData) document.

The [select](#selectRule) syntax rule defines the formal grammar of the $select query option.

### 5.1.4 OrderBy System Query Option ###
The $orderby system query option allows clients to request resource in a particular order. 

The semantics of $orderby are covered in the [OData:core](OData) document.

The [orderby](#orderByRule) syntax rule defines the formal grammar of the $orderby query option.

### 5.1.5 Top and Skip System Query Options ###
The $top system query option allows clients a required number of resources, used in conjunction $skip query option which allows a client to ask the server to begin sending resource after skipping a required number of resource, a client can request a particular page of matching resources.  

The semantics of $top and $skip are covered in the [OData:core](OData) document.

The [skip](#skipRule) and [top](#topRule) syntax rules define the formal grammar of the $top and $skip query options respectively.

### 5.1.6 Inlinecount System Query Option ####
The $inlinecount system query option allows clients to request a count of the number of matching resources inline with the resources in the response. 
Typically this is most useful when a server implements serverside paging, as it allows clients to retrieve the number of matching resources even if the server decides to only response with a single page of matching resources.

The semantics of $inlinecount is covered in the [OData:core](OData) document.

The [inlinecount](#inlinecountRule) syntax rule define the formal grammar of the $inlinecount query option.

### 5.1.7 Format System Query Option ###
The $format system query option if supported allows clients to request a response in a particular format. Generally requesting a particular format is done using standard content type negotiation, however occasionally the client has no access to request headers which makes standard content type negotiation not an option, it is in these situations that $format is generally used. Where present $format takes precedence over standard content type negotiation.

The semantics of $format is covered in the [OData:core](OData) document.

The [format](#formatRule) syntax rule define the formal grammar of the $format query option. 

## 5.2 Custom Query Options ##
Custom query options provide an extensible mechanism for data service-specific information to be placed in a data service URI query string. A custom query option is any query option of the form shown by the rule "customQueryOption" in Appendix A: ABNF for OData URI Conventions. 

Custom query options MUST NOT begin with a "$" character because the character is reserved for system query options. A custom query option MAY begin with the "@" character, however this doing  can result in custom query options that collide with Function Parameters values specified using Parameter Aliases.

For example this URI addresses provide a 'securitytoken' via a custom query option:
	http://service.odata.org/OData/OData.svc/Products?$orderby=Name&securitytoken=0412312321

## 5.3 Uri Equivalence ##
When determining if two URIs are equivalent, each URI SHOULD be normalized using the rules specified in [RFC3987](http://www.ietf.org/rfc/rfc3987.txt) and [RFC3986](http:// "http://www.ietf.org/rfc/rfc3986.txt") and then compared for equality using the equivalence rules specified in [HTTP/1.1](http://www.ietf.org/rfc/rfc2616.txt), Section 3.2.3.

# 6.0 Appendix A: ABNF for OData URI Conventions #
TODO: Add open properties to the ABNF

The following Augmented Backus–Naur Form (ABNF) details the construction rules for OData Uris that target OData services that follow the Uri Conventions specified in this document.

	
	WSP							= 	; core to ABNF, see [RFC5234]

	DIGIT						= 	; core to ABNF, see [RFC5234]
                   
	HEXDIG						= 	; core to ABNF, see [RFC5234]

	ALPHA						= 	; core to ABNF, see [RFC5234]

    pchar 						= 	unreserved / pct-encoded / sub-delims / ":" / "@" 				; see [RFC3986]  
	
	unreserved  				= 	ALPHA / DIGIT / "-" / "." / "_" / "~" 							; see [RFC3986]  
	
	pct-encoded 				= 	"%" HEXDIG HEXDIG												; see [RFC3986] 
	
	sub-delims  					= 	"!" / "$" / "&" / "'" / "(" / ")" / "*" / "+" / "," / ";" / "="	; see [RFC3986]  

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

	star           				= 	"*"

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

	expand						= 	"$expand=" expandClause 

	expandClause				=  	expandItem *("," expandItem)

	expandItemPath  			= 	[ qualifiedEntityTypeName "/" ] navigationPropertyName 
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
									[ qualifiedEntityTypeName "/" ] (
										propertyName / 
										qualifiedActionName / 
										qualifiedFunctionName / 
										allOperationsInContainer /
										( navigationProperty [ "/" selectItem ] )
									)

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

	primitivePropertyInVJSON	=	quotation-mark ( primitiveKeyProperty / primitiveNonKeyProperty ) quotation-mark name-separator primitiveLiteralInVJSON

	complexPropertyInJSON		= 	complexPropertyInVJSON / complexPropertyInJSONLight

	complexPropertyInVJSON		= 	quotation-mark complexProperty quotation-mark name-separator complexInVJSON

	complexPropertyInJSONLight	= 	TODO: arlo JSON Light format.

	collectionPropertyInJSON	= 	colPropertyInJSONLight / collectionPropertyInVJSON

	collectionPropertyInVJSON	= 	( quotation-mark primitiveColProperty quotation-mark name-separator "[" [ primitiveVJSONLiteral *( COMMA primitiveLiteralInVJSON ) ] "]" /
									( quotation-mark complexColProperty quotation-mark name-separator "[" [ complexInVJSON *( COMMA complexInVJSON ) ] "]" /
		
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

	isofExpr       				= 	"isof" [ WSP ] "(" [ [ WSP ] commonExpr [ WSP ] "," ] [ WSP ] qualifiedTypeName [ WSP ] ")"

	castExpr       				= 	"cast" [ WSP ] "(" [ [ WSP ] commonExpr [ WSP ] "," ] [ WSP ] qualifiedTypeName [ WSP ] ")"

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




  




