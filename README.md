# LandmarkRemark
Swift-Landmark Remark Application

You are to create a simple mobile application – working title: “Landmark Remark” -
that allows users to save location based notes on a map. These notes can be
displayed on the map where they were saved and viewed by the user that
created the note as well as other users of the application. The application must
demonstrate the functionality captured in the following user stories:
1. As a user (of the application) I can see my current location on a map
2. As a user I can save a short note at my current location
3. As a user I can see notes that I have saved at the location they were saved
on the map
4. As a user I can see the location, text, and user-name of notes other users
have saved
5. As a user I have the ability to search for a note based on contained text or
user-name

  Your application does not need to be pretty (i.e. artist designed) but you should
aim to make it as functional and useable as possible within the given constraints.

3.1 iOS 10.x Native Application
The iOS 10 Native Application must be written in Swift using no third party
(non-Apple) libraries except those explicitly called out in these specifications. You
may not use WebView to implement any aspect of the application. Your
application must perform well on an iPhone X and later form factor device.
Source code must be developed and runnable in XCode 10.


<---Overview--->
* Programming paradigm
  * Combination of OOP and POP
* Application Architecture
  * Combination of Modular and MVVM
* Included efforts to adhere to Engineering best practices
  * SOLID principles
  * Testable code writing
  * Test case writing and code coverage gathering
  * Clean,Testable, Scalable, Reusable and Maintainable code writing
* Dependency
  * Firebase iOS SDK (https://firebase.google.com/docs/ios/setup) 
  * Framework dependency added through Cocoapods (following pods required as dependency)
  * Firebase/Auth (For user authentication)
  * Firebase/Firestore (for Remote Database storage and required APIs--BAAS)
* Deployment target: iOS 10
* Supported devices: iPad and iPhone
* Xcode  version used: 10
* Assumptions
  * No CACHING OR LOCAL STORAGE required
  * It is ok to live with any limitations of BAAS being used for the assignment/initial prototype purpose.
  * It is ok to rely on GPX files for location simulation in simulators
* Implicit Requirements Identified
  * Authentication is necessary for the app to function properly and securely
  * Username must be unique
  * Back end persistence is required for landmark remarks to be stored by users.
  * Login, Signup, Already logged in check and Logout should be added.
  * Application theme/style(common code, color, font etc specific to controls or screens) must be added for better user experience
  * Extra layer of utility(Utilities+Firestore for all reusable helper methods) methods required to deal with BAAS(firestore here) to tackle changes of Firestore or selecting any new database in future easily
  * Independent Location Manager class(provider) required to decouple it from viewcontroller and making it reusable across projects/viewcontrollers
  * A user should be able to see his/her current location in map differently styled
  * A user should be able to refresh his/her current location.
  * A user should be able to see proper reason for location service usage.
  * Location must be fetched when in use only(for example while application loaded initially, user refreshes it and when creation of remark at current location). No continuous location monitoring required here.
  * A user should be able to differentiate his own location remarks with those created by others(Different annotation colors for example)
  * A user should be able tap and read full remark in alert if it's truncated due to annotation/map user experience limitation.
  * A user should be able to see other landmarks even if he has denied location service usage for the application(for example, user is only interested in seeing other landmark remarks and not interested in creating/adding his own)  
  * A user should be able to zoom in/out and explore full map to see all landmark remarks within application.
  * A user should be able search landmark remark and on selection redirected to map to see the same region/location.
* Approximate time estimation and efforts involved for this application development
  * BAAS selection and setup: 2 hours
  * Application architecture setup and planning: 2 hours
  * Application reusable(and independent) components/classes/methods and basic utility setup: 5 hours
  * Unit test case writing: 2 hours
  * User interface flow and design: 4 hours
  * ViewControllers and viewModel programming: 9 hours
  * Readme/Documentation and video recording: 1 hour
* User Interface and Application Demo link
  * No CACHING OR LOCAL STORAGE required
  * No higher order functions should be used for sorting/grouping rather relying on SpaceX API directly
* Limitations/known issues
  * No CACHING OR LOCAL STORAGE required
  * No higher order functions should be used for sorting/grouping rather relying on SpaceX API directly
* Future scalability/requirements/features possibility/Scope of improvements
  * No CACHING OR LOCAL STORAGE required
  * No higher order functions should be used for sorting/grouping rather relying on SpaceX API directly
* Approach overview
  * No CACHING OR LOCAL STORAGE required
  * No higher order functions should be used for sorting/grouping rather relying on SpaceX API directly
* Demo accounts if one do not wants to register as new user and use existing users
1. As a user (of the application) I can see my current location on a map
  * No higher order functions should be used for sorting/grouping rather relying on SpaceX API directly
2. As a user (of the application) I can see my current location on a map
  * No higher order functions should be used for sorting/grouping rather relying on SpaceX API directly





