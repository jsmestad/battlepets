# BattlePets

This application contains two APIs. One contains the [BattlePet
Manager](/manager) while the other is the [BattlePet Arena](/arena). Both
applications are standard Rails applications and come with individual `README`
files that explain how to get them running.

## BattlePet Manager

This application supplies a few functions:

### User Management

In order to create a BattlePet, you must have an existing User ID. You can
create this using the `/users` endpoint. Once created, the ID of this user is
used when creating a new BattlePet.

See the in-application documentation for other endpoints for the User resource.

### BattlePet Management

A BattlePet must have a valid User ID associated to it and a unique name (you
cannot have two BattlePet's named "Furry").


## BattlePet Arena

This application creates contests between two BattlePets supplied by the user.

### Contest Types

* `FairFight` - means both challenger and defendant are equals. It is a total toss up!

