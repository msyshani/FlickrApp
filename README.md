# FlickrApp
An iOS App for searching images using Flickr API. 

[![Swift Version](https://img.shields.io/badge/swift-5.0-orange.svg)](https://swift.org)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)]()

- This app uses the Flickr image search API and shows the results in a 3-column scrollable view
- User can enter queries, such as "kittens" to view resulting images
- Supports endless scrolling, automatically requesting and displaying more images when the user scrolls to the bottom of the view.

## App Architecture - VIPER
**Why VIPER** Our traditional MVC and MVM architecture that we are all accquainted with have one primary problem i.e Bulky Controllers. Since all our business logic has been dumped in controller, at the end we see a huge and fat controller which becomes difficult to manage if our project is to be scalable. So thse are the primary reasons why we need VIPER:

- To make the structure more modular.
- To build the application on Single responsibility principle.
- To reduce the load and dependency on controllers.
- To build the app on basis of use cases or behaviour based.

![](https://imgur.com/HA9UuVE.png)

## Features
- [x] Main view has a search bar in which you can enter any text to view result of Flickr image search API for that text.

## Requirements
- iOS 12.0+
- Xcode 10.2

## What could be done better:

1) Purging data from memory ie; when user scrolls down and down from page 1 to n then the result array keeps on increasing. We could just keep result of current page (+ previous and next page) and purge all others. Fetch them on demand (of user's scrolling)
2) Image caching mechanism could be improved.
