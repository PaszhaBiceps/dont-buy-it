# Don't Buy It

This app servers as a reference on how different brands acted when russian aggression towards Ukraine started. 

## Features & Other

App is built using `Xcode 13.4.1` and as for the stack: `Swift UI`, `Core Data`.
 Project contains single dependancy (which was added via [SPM](https://www.swift.org/package-manager/)) - [Networking](https://github.com/freshOS/Networking) to handle the API.

`Note:` Due to API limitations app always loads all available data to `Core Data` and afterwards no additional network requests are fired (but user can still update the data manually from within the app).

### Localisation
Currently app is almost fully localised to `English` and `Ukrainian` languages (except from some resources and API stuff).
