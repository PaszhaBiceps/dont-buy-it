# Don't Buy It

This app serves as a reference on how different brands acted when russian aggression towards Ukraine started.

## Features & Other

App is built using `Xcode 13.4.1` and as for the stack: `Swift UI`, `Core Data`.
 Project contains single dependancy (which was added via [SPM](https://www.swift.org/package-manager/)) - [Networking](https://github.com/freshOS/Networking) to handle the API.

`Note:` Due to API limitations app always loads all available data to `Core Data` and afterwards no additional network requests are fired (but user can still update the data manually from within the app).

## Structure
App itself consists of next screens:
- `Splash screen` - serves as a jump off point in the app. On this screen all the resource loading happens initially (due to the API limitations mentioned above).
- `Main screen` - a central hub of the applications. Here users can scroll through different brands to see how the operate right now. There are also abilities to search for a specific brand and filter brands by status. Also users can update brands data (if needed) vie the refresh button in the top left corner. 
- `Info screen` - this a simple pop up which describes all brand statuses in the app.

### Localisation
Currently app is almost fully localised to `English` and `Ukrainian` languages (except from some resources and API stuff).
