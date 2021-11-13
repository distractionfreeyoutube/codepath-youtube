README
===

# Distraction-free Youtube (tbc)

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Our app removes distracting elements of Youtube while keeping those that makes Youtube enjoyable. User can only access unwatched videos in their subscription box and can set limits to their watch time.

### App Evaluation
- **Category:** Social Media
- **Mobile:** This app would be primarily developed for mobile but would be just as viable on a computer.
- **Story:** Minimizes the number of hours spent watching distracting videos by providing you with only the content you need.
- **Market:** There are similar products on the market such as DF (Distraction Free) YouTube which removes the recommended video list and other distracting elements from the Youtube webpage. This shows that there is a need for this kind of application. However, there isn't a mobile app designed for this purpose. Everyone who is interested in using Youtube without being addicted to the platform can use our app.
- **Habit:** The frequency of using the app varies from user to user.
- **Scope:** We will start by letting users who would like to reduce their screentime to use our app. Then, the app can be expanded to an app that promotes real-life interactions and intentional living by reducing social media usage.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User logs in to their Youtube account
* User accesses their unwatched subscription content
* User watches the videos
* User sets the watch time limit
* User swipe to unsubscribe/ remove video from list
* Notification when time's up
* Up next playlist

**Optional Nice-to-have Stories**

* Profile Page
* Settings (colour scheme, etc.)
* Chat window/ community page to interact with fellow users who are trying to recover from Youtube addiction/ reduce screentime

### 2. Screen Archetypes

* Login Page
   * User logs in to their Youtube account
* Subscription Page
   * User accesses their unwatched subscription content
   * Up next playlist
   * User swipe to unsubscribe/ remove video from list
* Video Player
   * User watches the videos
* Timer Page
   * User sets the watch time limit
   * Notification when time's up

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Timer
* Subscription
* Video Player

**Flow Navigation** (Screen to Screen)

* Login
   * -> Google login
   * -> Subscription Page
* Subscription Page
   * -> Timer (via tab bar controller)
   * -> Video Player (via pressing the Youtube videos)
* Video Player
   * -> Timer (via tab bar controller)
   * -> Subscription Page (via tab bar controller)
* Timer
   * -> Video Player (via pressing the Youtube videos)
   * -> Subscription Page (via tab bar controller)

## Wireframes
<img src="https://i.imgur.com/EbAfKAA.jpg" width="200"/>
<img src="https://i.imgur.com/acHvgmN.jpg" width="200"/>
<img src="https://i.imgur.com/fmeJrGt.jpg" width="200"/>
<img src="https://i.imgur.com/K65WLPV.jpg" width="200"/>
<img src="https://i.imgur.com/RN1nLUe.jpg" width="200"/>
<img src="https://i.imgur.com/xFGqpEG.jpg" width="200"/>

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
