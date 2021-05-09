# Life Goals 

 ![Icon](https://user-images.githubusercontent.com/36420903/117569420-7bf6a000-b0bd-11eb-8d3a-deb9218f305d.jpeg)

An app which allows you to set life goals and  it also allows you to complete the goals.

## Table of contents
* [Core Data](#CoreData)
* [Notifications](#Notifications)
* [MVVM](#MVVM)
* [Singletons](#Singletons)
* [Haptic Feedback](#HapticFeedback)
* [Dark Mode](#DarkMode)

# Requirements
* iOS 14.1+
* Xcode 12.5 

# ScreenShots
 ![CompletedGoal](https://user-images.githubusercontent.com/36420903/117569936-e7417180-b0bf-11eb-8c54-2a0589529403.png) ![HomeScreen](https://user-images.githubusercontent.com/36420903/117569946-f1637000-b0bf-11eb-8697-8bf5b01ac289.png) ![FormScreen](https://user-images.githubusercontent.com/36420903/117569941-ed375280-b0bf-11eb-8664-d3d236373b65.png)







 ---
#### **CoreData**
 Core data is a framework that allows you to manage model layered objects in an app, and it also lets you persist data as well. I used core data to save the goals, so when a user completes the form then the goal will be saved in core data.
 
 ---
  
#### **Notifications**
Notifications allow you to keep track of what is new on the app. I used notifications to remind a user when their goal needs to be completed.
 
 ---
#### **MVVM**
MVVM is an architecture pattern that allows you to separate the interface of an app, it has the development of the business logic which is the model. In this app, I use MVVM to separate the functions which perform actions in their class. 
 
 ---
#### **Singletons**

Singletons are used to stop instantiating in multiple files. I used the singleton for the database manager so that I don't have to keep creating instances of the class.
 
 ---
#### **Haptic Feedback**
Haptic feedback is used to send feedback back to the user using vibrations. I have used haptic feedback when a user saves a goal, it will create a  vibration to say they have successfully created a goal.

 ---
#### **Dark Mode**
Dark mode is used to change the interface of an app to light or dark. I use dark mode in my app when the user selects light or dark in the setting then the UI element will change depending on what theme has been selected.

  
 
