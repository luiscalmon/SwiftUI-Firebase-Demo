# My Stuffs
## SwiftUI Firebase Demo

A prove of concept iOS app developed in SwiftUI with a Firebase backend.
In-app purchase has been added to give users the opportunity to support future versions of My Stuff.

## Backend
The types that interact with Firebase are:

### UserManager
All the user account logic is managed here using FirebaseAuth.

### FirestoreBackend
This is a generic type where all the persistent logic is implemented using FirebaseFirestore.

No one else type in the app knows about Firebase.

## User Interface
The app presents a TabView with a UserView tabItem to manage user account  and several Rows tabItem. Rows and complementary Row are generic types that allow reuse the same code for diferents Stuffs.

## GenericHelper
GenericHelper is a protocol for conforming type to specialise the generic types. 
The conforming types Appointment, Note and Task are used to demonstrate private data accessible just by the owner.
The conforming type Message is used to demonstrate private data updated just by the owner, but publicly read.
