# OData #

# Overview #

- include the exec summary of data and its design principles.

# Data Model #

- high level overview of the data model that describes the system (not a full/formal definition of EDM, but just what you need to know to reason about the contents of the spec)
- ideally we can put the full/formal definition of EDM into an appendix or something.  We should also consider any changes or omissions to EDM we might need/want

# Terminology #

- glossary of terms used throughout the doc

# Conventions #

- any conventions used in the document (i.e. all examples should use the odata efficient format – more on that below)

# Versioning & Extensibility #

- how the protocol is versioned and the relation of this doc to prior OData versions.
- What versioning is the responsibility of the service author  vs. inherent in the protocol.  This is just a statement of concerns, not best practices re: versioning (that stuff can be put in a companion whitepaper)
- explicit extension points in the system and what types of extensibility we encourage

# Interaction Semantics #

## Metadata ##

### Service Document ###

### Metadata Document ###

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
