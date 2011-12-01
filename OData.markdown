# OData #

# Overview #

The OData Protocol is an application-level protocol for interacting with data via RESTful web services. The protocol supports the description of data models and editing and querying of data according to those models. It provides facilities for:

- Metadata: A machine-readable description of the data model exposed by a particular data provider.
- Data: Sets of data entities and the relationships between them.
- Querying: Requesting that the server perform a set of filtering and other transformations to its data, then return the results.
- Editing: Creating, editing, and deleting data.

The OData Protocol is different from other REST-based web service approaches in that it provides a uniform way to describe both the data and the data model. This improves semmantic interoperability between systems and allows an ecosystem to emerge. Towards that end, the OData Protocol follows these design principles:

- Prefer mechanisms that work on a variety of data stores. In particular, do not assume a relational data model.
- Backwards compatability is paramount. Clients and servers which speak different versions of the OData Protocol should interoperate, supporting everything allowed in the lower of the two versions.
- Follow REST principles unless there is a good and specific reason not to.
- OData should degrade gracefully. It should be easy to make a very basic but compliant OData endpoint, with additional work necessary only to support additional capabilities.

----------

- ASSIGNED TO: ARLO
- include the exec summary of odata and its design principles.

*Sample text, taken from the AtomPub RFC's Introduction section.*

>  The Atom Publishing Protocol is an application-level protocol for
>    publishing and editing Web Resources using HTTP [RFC2616] and XML 1.0
>    [REC-xml].  The protocol supports the creation of Web Resources and
>    provides facilities for:
> 
>    o  Collections: Sets of Resources, which can be retrieved in whole or
>       in part.
> 
>    o  Services: Discovery and description of Collections.
> 
>    o  Editing: Creating, editing, and deleting Resources.
> 
>    The Atom Publishing Protocol is different from many contemporary
>    protocols in that the server is given wide latitude in processing
>    requests from clients.  See Section 4.4 for more details.

----

# Data Model #

- ASSIGNED TO: MikeF
- high level overview of the data model that describes the system (not a full/formal definition of EDM, but just what you need to know to reason about the contents of the spec)
- ideally we can put the full/formal definition of EDM into an appendix or something.  We should also consider any changes or omissions to EDM we might need/want

# Terminology #

- glossary of terms used throughout the doc

# 2. Notational Conventions #

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [[RFC2119](http://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")].

## 2.1. Json Example Payloads ##

Some sections of this specification are illustrated with non-normative example OData request and response payloads. However, the text of this specification provides the definition of conformance.

OData payloads are representable in multiple formats. Those formats are specified in separate documents. In this document, when an example is necessary, it will be given in the minimal Json format.

## 2.2. CSDL Schema ##

Some sections of this specification are illustrated with fragments of a non-normative RELAX NG Compact schema [[RNC](http://tools.ietf.org/html/rfc5023#ref-RNC "RELAX NG Compact Syntax")]. However, the text of this specification provides the definition of conformance. Complete schemas appear in Appendix B.

# Versioning#

- how the protocol is versioned and the relation of this doc to prior OData versions.
- What versioning is the responsibility of the service author  vs. inherent in the protocol.  This is just a statement of concerns, not best practices re: versioning (that stuff can be put in a companion whitepaper)

# Versioning & Extensibility #

- explicit extension points in the system and what types of extensibility we encourage

# Interaction Semantics #

## Metadata ##

### Service Document ###

- ASSIGNED TO: MikeP

### Metadata Document ###

- ASSIGNED TO: Alex
- i.e. $metadata

## Querying Data ##

- description of how data is queried in OData (i.e. GET requests).  Might need some additional structure, but figured that can be flushed out as we progress
- this would include description of everything after the ? ($filter, select, top, skip, etc)

## Data Modification ##

- description of POST, PUT, DELETE, PATCH/MERGE 

## Additional Operations  ##

- Actions 
- Functions
- Service Operations (ideally we want to end of life these in favor of the above two – should consider if /how we include these)
- Batch Processing

# Appendices #

## A: Formal CSDL description ##

## B: XSD for CSDL ##
