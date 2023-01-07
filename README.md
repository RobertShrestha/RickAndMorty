# RickAndMorty


IOS App using RickAndMorty Open APIs

## Getting Started

  

### Installation or Setup

  

1. Just download the repo or clone the repo

  

2. Open Terminal and go inside the folder,e.g cd [path to inside the repo folder]

  

3. Type pod install

  

4. Go to the folder,Just open the .xcworkspace

  

  

- [RxSwift](https://github.com/ReactiveX/RxSwift) This is a Swift version of Rx.

  

- [SDWebImage](https://github.com/SDWebImage/SDWebImage) This library provides an async image downloader with cache support. For convenience, we added categories for UI elements like UIImageView, UIButton, MKAnnotationView.

  

- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager) Handle Keyboard and user inputs

  

  

### Todo

  

- [ ] Add other framework for Offline storage for both bookmarked characters and characters and use Type Erasure

  

- [ ] Realm

  

- [ ] CoreData

  

- [ ] Local File

  

- [ ] Localization

  

- [ ] Search Fuctionality

  

- [ ] Filter using Gender and Status

  

- [ ] Dark Mode

  

- [ ] UI Improvement

  

- [ ] Add Swiftlint to enforce Swift style and conventions.

  

- [ ] Add filter option in source.

  

- [ ] Shift the change country feature to some better place.

  

  

- [ ] Change filter design from using actionsheet to using UIPageViewController for better UI/UX

  

- [ ] Implement BDD if possible

  

- [ ] Add Tests

  

  

### Done

  

- [x] Character Listing

  

- [x] Bookmark and Unbookmark character from character detail view

  

- [x] Save Bookmarked character to UserDefaults

  

- [x] Pagination

  

  

### Action

  

- Use a Tab controller as main controller and have two tabs Characters and bookmarked
	-  Load all the bookmarks from the loadCharacters() function of StorageClient

- User Hero animation for smooth transition between character and charater detail

- Two way to handle offline Storage

	- Instead of directly calling the API in CharacterService.swift file what we do is call the api then store all the data in the offline storage( I was thinking of sqlite ) by injecting it through the service or storageClient then pass the data to the view model this is work well with pagination and make the app for fast

	- Alternative we can used to different storage for offline and online. If online then we can hit the API and get the data otherwise we can get the data from offline storage.

  

  

### Any comments or feedback for improvement of codebase is highly appreciated.

  

### Happy Coding
