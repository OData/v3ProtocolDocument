# OData #

# 1. Overview #

------

- ASSIGNED TO: Review

------

The OData Protocol is an application-level protocol for interacting with data via RESTful web services. The protocol supports the description of data models and defines data edit/query patterns according to those models. It provides facilities for:

- Metadata: A machine-readable description of the data model exposed by a particular data provider.
- Data: Sets of data entities and the relationships between them.
- Querying: Requesting that the server perform a set of filtering and other transformations to its data, then return the results.
- Editing: Creating, editing, and deleting data.

The OData Protocol is different from other REST-based web service approaches in that it provides a uniform way to describe both the data and the data model. This improves semmantic interoperability between systems and allows an ecosystem to emerge.

Towards that end, the OData Protocol follows these design principles:

- Prefer mechanisms that work on a variety of data stores. In particular, do not assume a relational data model.
- Backwards compatability is paramount. Clients and servers which speak different versions of the OData Protocol should interoperate, supporting everything allowed in the lower of the two versions.
- Follow REST principles unless there is a good and specific reason not to.
- OData should degrade gracefully. It should be easy to make a very basic but compliant OData endpoint, with additional work necessary only to support additional capabilities.

# 2. Data Model #

This section provides a high-level description of the Entity Data Model (EDM); the abstract data model that MUST be used to describe the data exposed by an OData service. <ref>Section XXXX</ref> defines an OData Metadata Document which is a representation of a service's data model exposed for client consumption.  

The central concepts in the EDM are **entities** and **associations**. Entities are instances of **Entity Types** (e.g. Customer, Employee, etc) which are nominal structured records with a key that consist of named primitive or complex properties. 

**Complex Types** are nominal structured types also consisting of a list of properties but with no key, thus can only exist as a property of a containing Entity Type or as a temporary value. 

The **Entity Key** of an Entity Type is formed from a subset of primitive properties of the Entity Type. The Entity Key (e.g. CustomerId, OrderId, etc) is a fundamental concept to uniquely identify instances of Entity Types (entities) and allows entities to participate in relationships. 

Properties statically declared as part of the Entity Type's structural definition are called **declared properties** and those which are not are **dynamic properties**. Entity Types which allow dynamic properties are called Open Entity Types. If an instance of an Open Entity Type does not include a value for a dynamic property, the instance must be treated as if it included the property with a value of null. A dynamic property MAY NOT have the same name as a declared property.

Entities are grouped in named collections called **Entity Sets** (e.g. Customers is a set of Customer Entity Type instances).

**Association Types** define the relationship between two or more Entity Types (e.g. Employee WorksFor Department). Instances of Association Types are grouped in **Association Sets**. **Navigation Properties** are special properties on Entity Types which are bound to a specific association and are used to refer to specific associations of an entity. 
 
Finally, all instance containers (Entity Sets and Association Sets) are grouped in an **Entity Container**.

//TODO: put primitive type table here in subsection
//TODO: what about named streams?  anything else core that I missed?


# 3. Terminology #

------

- ASSIGNED TO: All

------


# 4. Notational Conventions #

------

- ASSIGNED TO: Edit

------

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [[RFC2119](http://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")].

## 4.1. Json Example Payloads ##

------

- ASSIGNED TO: Review

------

Some sections of this specification are illustrated with non-normative example OData request and response payloads. However, the text of this specification provides the definition of conformance.

OData payloads are representable in multiple formats. Those formats are specified in separate documents. In this document, when an example is necessary, it will be given in the minimal Json format.

## 4.2. CSDL Schema ##

------

- ASSIGNED TO: Review

------

Some sections of this specification are illustrated with fragments of a non-normative RELAX NG Compact schema [[RNC](http://tools.ietf.org/html/rfc5023#ref-RNC "RELAX NG Compact Syntax")]. However, the text of this specification provides the definition of conformance. Complete schemas appear in Appendix B.

# Versioning#

------

- ASSIGNED TO: MikeP

------

- how the protocol is versioned and the relation of this doc to prior OData versions.
- What versioning is the responsibility of the service author  vs. inherent in the protocol.  This is just a statement of concerns, not best practices re: versioning (that stuff can be put in a companion whitepaper)

# Extensibility #

------

- ASSIGNED TO: MikeP

------

- explicit extension points in the system and what types of extensibility we encourage

#Interaction Semantics#

## Metadata ##

###Service Document ###

------

- ASSIGNED TO: MikeP

------

### Metadata Document ###

An OData Metadata Document is an representation of the data model (<ref> see section 2. Data Model</ref>) that describes the data exposed by an OData service. 

<ref>Appendix A</ref> describes an XML representation for OData Metadata Documents and provides an XSD to validate its syntax rules. The media type of the XML representation of an OData Metadata Document is 'application/xml'      

As of OData v3, OData services MUST expose a Metadata Document which defines all data exposed by the service.  The URI of the document MUST be http://<service root>/$metadata, where <service root> is the root URI of the OData service as described in <ref>//TODO</ref>. 

Retrieval of a Metadata Document by a client MUST be done by issuing an HTTP GET request to document's URI.  If the request doesn't specify a format preference (via Accept header or <ref>$format query string option</ref>) then the XML representation MUST be returned.      

------

- ASSIGNED TO: Alex, above text added by MFlasko.  Alex I think all that is left is inline CSDL into an appendix.

------

## Querying Data ##

------

- ASSIGNED TO: Mike(*)

------

- description of how data is queried in OData (i.e. GET requests).  Might need some additional structure, but figured that can be flushed out as we progress
- this would include description of everything after the ? ($filter, select, top, skip, etc)

## Data Modification ##

------

- ASSIGNED TO: Arlo

------

### POST ###

### DELETE ###

### PUT ###

### PATCH/MERGE ###

## Additional Operations ##

### Actions ###

------

- ASSIGNED TO: Alex

------

### Functions ###

------

- ASSIGNED TO: Alex

------

### Service Operations ###

------

- ASSIGNED TO: Alex

------

(ideally we want to end of life these in favor of the above two – should consider if /how we include these)

### Batch Processing ###

------

- ASSIGNED TO: MikeP

------

# Appendices #

## A: Formal CSDL description ##

------

- ASSIGNED TO: Alex

------

## B: XSD for CSDL ##

------

- ASSIGNED TO: Alex

------
