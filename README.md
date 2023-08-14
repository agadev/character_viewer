# character_viewer

Character Viewer Flutter project.

## App Description
A Flutter framework and support both iOS and Android platforms. It fetches and 
displays data from a RESTful Web API. The app is comprised of two screens, a list and a detail.

## App Features
1. App supports both portrait and landscape orientations on both phones and tablets.
2. On phones, the list and detail are separate screens, 
   on tablets :the list and detail appears on the same screen.

3. On all devices, the list is displayed as a text only, 
   vertically scrollable list of character names.

4. The app offers search functionality that allows users to filters the character list of 
   entries whose titles or descriptions contain the query text.

5. Clicking on an item loads the detail view of that character, including the character’s image,
   title, and description. 

6. For the image in the detail view, we use the URL path in the "Icon" field of the API JSON response. 
   For items with blank or missing image URLs, we use a placeholder image. 
   The image path is appended to https://duckduckgo.com/ in order to be construct full image URL.

7. Two variants of the app should are created, using a single shared codebase. 
   Each variant should have a different name, package-name, and url that it pulls data from.

8. Unit tests and UI tests are included for functionality.
   
## App Variants
   
    Variant One
    Name: Simpsons Character Viewer
    Data API: http://api.duckduckgo.com/?q=simpsons+characters&format=json
    Package/Bundle name: com.atul.simpsonsviewer

    Version Two
    Name: The Wire Character Viewer
    Data API: http://api.duckduckgo.com/?q=the+wire+characters&format=json
    Package/Bundle name: com.atul.wireviewer

## Libaries used
  1. Riverpod: used for state management 
  2. Dio: used for network calls.
  3. Mocktail: for unit testing, mock generation
  4. Flutter Flavor: for getting the flavor object.

## Project Structure and Architecture

This code uses clean architecture with domain, data and ui layer implementations to create 
the Flutter app that displays a list of Simpsons/TheWire characters from the DuckDuckGo API. 

## Directory Structure

   lib->
     app.dart
     main_simpsons.dart
     main_wire.dart
     features--->
                 home--->
                         data --->
                                  character_repository.dart
                         
                         domain --->
                                    home_controller.dart
                                    character.dart
                    
                         ui --->
                                character_detail_page.dart
                                home_page.dart

## The app is organized into layers, with the 
1.**main_simpsons.dart** file at the top, entry point for application for simpsons viewer flavor
2.**main_wire.dart** file at the top, entry point for application for wire viewer flavor
3.**app.dart** file, which initializes the app. 

### The features/home directory contains the code for the home page feature.
## ui layer (ui folder includes)
1. home_page.dart file :  displays the UI for home page containing characters list
2. character_detail_page.dart: displays character details,including description,title,picture.

## domain layer contains business logic 
1. home_controller.dart: defines business logic and state. 
   It contains methods for getting characters from the repository. Filtering characters, 
   showing the selected character.
2. character.dart file: contains data for character such as title,description, imageUrl

## data layer contains repository which fetches characters from api
1. character_repository.dart : it is responsible for fetching data from the API and 
   convert to list of characters. Dio is used for doing rest calls.

## Flavors
We can set up app flavors for this Flutter app that supports both Android and iOS platforms:

 ## 1. Android Flavor
 In your `android/app/build.gradle` file, define your product flavors inside the `android` block:

        android {
            ...
            flavorDimensions "app"
            productFlavors {
                simpsonsviewer {
                    dimension "app"
                    applicationId "com.atul.simpsonsviewer"
                }
                wireviewer {
                    dimension "app"
                    applicationId "com.atul.wireviewer"
                }
            }
        }
        
 ## 2. iOS Flavor 
     In xcode the steps to create flavors in iOS:
     Open your project in Xcode.
     Select Product > Scheme > New Scheme from the menu to add a new Scheme. 
     Duplicate the build configurations to differentiate between the default configurations that are already available 
     and the new configurations for the free scheme. Under the Info tab at the end of the Configurations dropdown list, click the plus button 
     and duplicate each configuration name (Debug, Release, and Profile).
     Then, in the `Build Settings` tab of the new target, change the `Product Bundle Identifier` 
     to match the package name of your flavor (e.g. `com.atul.simpsonsviewer`).


  ## To run app either select "SimpsonsViewer" or "WireViewer" as flavor 
   and corresponding main class.

  flutter build --flavor SimpsonsViewer -t lib/main_simpsons.dart. 
  In this way, the entry point of the app is set to main_simpsons.dart

## Unit Tests
   Using mocktail library for testing.
   
   Tests are located similarly to actual code, test/features folder contains all tests
   
     1. character_repository_test.dart inside test/features/data contains the tests 
        for the character_repository.

     2. home_controller_test.dart inside test/features/domain contains the tests 
        for the home_controller.

     3. home_page_test.dart inside test/features/ui 
        contains tests for home_page and character_detail_page

     4. common_data.dart contains some fake data needed for testing.

  ##  Test Lines Coverage
     1. character_repository.dart   100% coverage
     2. app.dart  100% coverage
     3. main_simpons.dart 100% coverage
     4. main_wire.dart 100% coverage
     5. character_detail_page.dart  90% coverage
     6. character.dart  57% coverage,can be increased easily by writing 2 trivial tests
     7. home_controller.dart 70% coverage

     Test coverage can be increased close to 100% by writing few more tests.
    

