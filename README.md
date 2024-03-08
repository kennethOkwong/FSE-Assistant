# FSE ASSISTANT - Under development

Welcome to FSE Assistant, a flutter mobile application to help Field Engineers working with ISPs carry out an hassle free wireless internet link survey.

## Description
FSE Assistant allows users to:
- Create and verify account
- Add their base stations
- Survey a location
- Save and share survey report

## Flutter concepts demonstrated in the project
1. Riverpod state management
2. Clean Architecture - Feature-first 
3. Googe maps API and package
4. GoRouter Navigation API
5. App theming
6. Firebase database
7. Shared preferences

## Getting Started
In addition firebase Auth and FireStore access, you'll need a google maps API key to successfuly setup and run the project.

The first step to testing or running this app is getting the code

    git clone https://github.com/kennethOkwong/FSE-Assistant.git
    .
    .
    flutter pub get

Specify your API key in the application manifest android/app/src/main/AndroidManifest.xml:

    <manifest ...
    <application ...
        <meta-data android:name="com.google.android.geo.API_KEY"
                android:value="YOUR API KEY HERE"/>

To setup for iOS, specify your API key in the application delegate ios/Runner/AppDelegate.swift:

    import UIKit
    import Flutter
    import GoogleMaps
    @UIApplicationMain
    @objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("YOUR API KEY HERE")
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    }

Run the app to confirm that everything works
    
    flutter run

## UI/UX design
UI/UX was designed by [Judith Emenike ](https://www.linkedin.com/in/emenike-judith-158952176/)and the Hi-Fi Figma file can be found [Here](https://www.figma.com/file/o1JvwCWHPA5ZEEwSzflD40/FIELD-SERVICE-ENGINEERING-ASSISTANT?type=design&node-id=65-5005&mode=design&t=0eCZ9QrY7kw4sjtj-0).

## FREQUENTLY ASKED QUESTIONS (FAQs)
1.	What is ‘FSE Assistant’ used for?
Ans: Field Service Engineer (FSE) Assistant is an app that aids Network Engineers in carrying out a seamless wireless link feasibility survey.

2.	Who is ‘FSE Assistant’ built for?
Ans: FSE Assistant is built for Network Engineers working with an Internet Service Provider (ISP).

3.	Why is adding my base stations important?
Ans: Adding base stations helps us calculate and provide the distances between them and your customer location during link surveys.

4.	Can I survey a customer location remotely?
Ans: Yes, by searching or picking customer’s location on map. However, being on site will aid you provide some details needed to produce a comprehensive report.

5.	Can I keep history of my surveys?
Ans: Yes. All your surveys are saved under ‘Surveys’ menu and can be referenced or shared when needed.

6.	How do I collaborate with my teammates?
Ans: We are working on allowing team leads add team mates to company accounts. However, a temporary solution might be creating a single account, adding base stations and then sharing the login details with teammates.

7.	What is the team behind the wheel?
Ans: FSE Assistant is built by Team Cadenny. The UI/UX design is done by Judith Emenike, Mobile Development by Kenneth Okwong (Computer Engineering Graduates of UNIUYO). Firebase is used for Backend.

