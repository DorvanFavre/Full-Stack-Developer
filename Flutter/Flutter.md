# [Flutter](https://flutter.dev/?gclid=CjwKCAjwjbCDBhAwEiwAiudBy9PorWkelpr4JagzvtPQLohy0BScHpl7o61yS0v77CPj9i4yruxZ8xoC6DAQAvD_BwE&gclsrc=aw.ds)

Flutter is a framework using [Dart](https://dart.dev/) language.

## Starter guide

comming soon

### Dependecies

Dependecies are libraries that adds code features, all available on the [pub.dev](https://pub.dev/) website.

 - [RxDart](https://pub.dev/packages/rxdart/install) Stream features
 - [Http](https://pub.dev/packages/http/install) Http requests

Firebase
 - [Firebase Core](https://pub.dev/packages/firebase_core/install)
 - [Firebase Auth](https://pub.dev/packages/firebase_auth/install)
 - [Cloud Firestore](https://pub.dev/packages/cloud_firestore/install)
 - [Cloud Function](https://pub.dev/packages/cloud_functions/install)
 - [Firebase Messaging](https://pub.dev/packages/firebase_messaging/install)
 - [Firebase Storage](https://pub.dev/packages/firebase_storage/install)

### or [Create my own packages](Packages.md)


## Architecture

 - Global Access vs Scoped Access with Provider [article](https://medium.com/coding-with-flutter/flutter-global-access-vs-scoped-access-with-provider-8d6b94393bdf)
   - Dependecies injection should be done by passing by argument (or context) and not global access -> side effect and not testable

 - Uses of interfaces - [article](https://application-evenementielle--test-pk0q9rsv.web.app/)
   - In the **abstract class**, use a **factory constructor** to instanciate the desired **implementation class**

## Dart

 - Create singleton - [article](https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart) or [code](singleton.dart)
 - Class named parameter -> default value depending to another - [code][defaultParameter.dart]

## Front End

### Fonts

fontFamily: GoogleFonts.poppins().fontFamily,

