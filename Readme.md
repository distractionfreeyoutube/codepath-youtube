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
### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | id            | String   | unique id for the user (default field) |
   | subscriptions | Pointer to array of Channels | the channels a user is subscribed to |
   | communities   | Pointer to array of Communities  | the communities the user is a part of |
   | timer setting | Number   | number of minutes user sets to watch videos |
   
#### Channel

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | id            | String   | unique id for the channel (default field) |
   | videos        | Pointer to array of Videos| the videos posted on the channel |
   | createdAt     | DateTime | date when channel is created (default field) |
   
#### Video

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the channel video (default field) |
   | channel       | Pointer to Channel | channel that video comes from |
   | title         | String   | video title |
   | thumbnail     | File     | video thumbnail image |
   | comments      | Pointer to array of Comments | comments of the video |
   | createdAt     | DateTime | date when video is created (default field) |
   | updatedAt     | DateTime | date when video is last updated (default field) |
   
#### Comment

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the comment (default field) |
   | author        | Pointer to User| comment author |
   | message       | String   | comment content by author |
   | replies       | Pointer to array of Comments | replies to author's comment |
   | createdAt     | DateTime | date when comment is created (default field) |
   | updatedAt     | DateTime | date when comment is last updated (default field) |

#### Timer

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | duration      | Number   | duration set to watch videos after opening app |
   | sound         | File     | audio file for alarm sound |
   
#### Community

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | id            | String   | unique id for the community (default field) |
   | members       | Pointer to array of Users | users in the community |
   | posts         | Pointer to array of Posts | community posts|
   | createdAt     | DateTime | date when community is created (default field) |

#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the community post (default field) |
   | author        | Pointer to User| post author |
   | community     | Pointer to Community| community that post is created in |
   | message       | String   | message content by author |
   | replies       | Pointer to array of Posts | posts used to comment on original post |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   
#### Subscriptions

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the channel (default field) |
   | channelName   | String   | name of channel |
   | pfp           | File     | profile picture of the channel |
   | subscriberCount | Number | number of subscribers |
   | isSubscribed  | Boolean | true if the user is subscribed, false if the user is subscribed previously but is no longer subscribed |
   
   
### Networking

#### List of network requests by screen
   - Home Feed Screen
      - (Read/GET) Query all videos of each channel the user is subscribed to
         ```swift
         let query = PFQuery(className:"Video")
         query.whereKey("channel", containedIn: currentUser.subscriptions)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (videos: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let videos = videos {
               print("Successfully retrieved \(videos.count) videos.")
           // TODO: Do something with videos...
            }
         }
         ```
      - (Create/POST) Create a new comment on a video
      - (Delete) Delete existing user comment
   - Join Community Screen
      - (Read/GET) Query all communities associated with channels user is subscribed to
   - Community Screen
      - (Create/POST) Create a new post in this community
      - (Update/PUT) Update user post in the community
      - (Delete) Delete existing user post in this community
   - Profile Screen
      - (Read/GET) Query logged in user object
      - (Read/GET) Query all videos of each channel the user is subscribed to
      - (Update/PUT) Update channels user is subscribed to
      - (Update/PUT) Update user preference of timer duration
      
##### YouTube API
- Base URL - [https://www.googleapis.com/youtube/v3](https://www.googleapis.com/youtube/v3)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /channels | returns a collection of zero or more channel resources that match the request criteria
    `GET`    | /commentThreads | returns a list of comment threads that match the API request parameters
    `POST`   | /commentThreads | creates a new top-level comment
    `GET`    | /comments | returns a list of comments that match the API request parameters
    `POST`   | /comments | creates a reply to an existing comment
    `PUT`    | /comments | modifies a comment
    `DELETE` | /comments | deletes a comment
    `GET`    | /subscriptions | returns subscription resources that match the API request criteria
    `POST`   | /subscriptions | adds a subscription for the authenticated user's channel
    `DELETE` | /subscriptions | deletes a subscription 
    `GET`    | /videos | returns a list of videos that match the API request parameters
