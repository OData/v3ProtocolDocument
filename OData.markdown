# OData #

# Overview #

- ASSIGNED TO: ARLO
- include the exec summary of data and its design principles.

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
