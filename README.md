# Pre-work - *TippiT*

**TippiT** is a tip calculator application for iOS.

Submitted by: **Ngan Phan**

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [X] UI animations
* [X] Remembering the bill amount across app restarts (if <10mins)
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

* [X] Tip percentages are configurable and remembered across app restarts
* [X] Specify the number of people to calculate the split amount
* [X] Settings to round up the split amount

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://github.com/ntphan527/TippiT/blob/master/TippiT.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** The iOS app development platform seems to be well thought out. The Xcode editor makes it easier for developers new to the iOS frameworks to get aquainted with the API much more quickly with its autocomplete functionality. The availability of the Interface Builder also makes it easier to design and quickly realize the flow of the app that is being created. Swift as a language is also easier to understand and learn since it resembles Java. Swift is much easier to learn than Objective-C.

Outlets and actions allow the view and the controller to communicate with each other. The controller references components in the view via outlets. And when the view needs to call the controller to trigger some behavior in response to user interaction with the view, it does so via actions. I'm not exactly sure how these are implemented under the hood. But when you right-click on the Storyboard, it seems like they are implemented as an array of Connection, belonging to the ViewController, declared as XML. This xml will probably go through code generation to generate class files for each function.

**Question 2:** "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** A strong reference cycle is when 2 class instances hold a strong reference to each other making it hard to deallocate neither instance. A closure can reference constants and variables outside of its code block, located within the class that it resides. Moreover, a closure is itself a reference type. So if the closure is assigned to a class variable and inside the closure it holds a reference to the class instance itself, then this results in a strong reference cycle.


## License

    Copyright [2017] [Ngan Phan]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
