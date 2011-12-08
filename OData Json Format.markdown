# OData Json Format #

# Overview #

- Description of document; refer to core doc.
- Design goals
- Efficient format vs historical (needs better name) format

# 2. Notational Conventions #

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [[RFC2119](http://tools.ietf.org/html/rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")].

## 2.1 ??? ##

- Normative reference to the OData core document
- Any other notational conventions?

# Common Payload Format #

- This section includes all the stuff that is common between request and response payloads. Mostly, this means the representations of EDM values.
- Also, it contains only the stuff that is common between historical and efficient formats.

## Entities ##

### Properties ###

### Navigation Properties ###

### Metadata ###

## Primitive Values ##

- All of the types, by category (numeric, string, spatial, temporal, special)
- Specific statement of representation in payload.

## Complex Types ##

### Properties ###

### Metadata ###

# Request Specifics #

- All the stuff that only applies to request payloads. Is there any? Only that which is common between efficient and historical formats.

# Response Specifics #

- All the stuff that only applies to response payloads. Only that which is common between efficient and historical formats.

# Efficient Format Specifics #

- Repeat whatever sections from above change in the efficient format, and talk about what this format adds.

# Historical Format Specifics #

- Repeat whatever sections from above change in the historical format, and talk about what this format adds.

## Next Links ##

## Response-Level Properties ##

- Inline count
- Others?
