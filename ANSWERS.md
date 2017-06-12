# LiveStream Project

Live stream is an iOS project built in Swift 3.1 with XCode 8.3.3
The purpose of this project is to intercept HTTP requests from a mobile video player. The main fetaures are the following:
- Play this stream: https://wowza-cloudfront.streamroot.io/liveorigin/stream4/playlist.m3u8
- Log every HTTP request the player is making into the console

### Tech
Here are the technolgy used to built the application:
* Swift 3.1
* UIKit, AVFoundation, AVKit
* Sh for scripting (toolchain + build phase)
* ruby for CI tools
* SwiftLint - Enforce coding style convention at the buildtime
* [Fastlane]- common tasks automation used here for unit tests, certificats and provisonning profiles, and tesflight upload
* [Fabric] Crashlytics/Fabric -  crash reporter, app monitoring
* Cocoapods - Dependency manager
* Git - SCM with bitbucket (to have private repo), with [GitFlow] worflow
* [Bundler] - Toolchain manager

### Installation
By cloning the project you should be able to build it , run it on simulator and even run unit tests via XCode. However to use all the toolchain(lint, fastlane, cocoapods update) there are some prerequists:
- Ruby 2.4.1
- [HomeBrew] - HomeBrew for mac os
- [Bundler] - Toolchain manager 

The main player here is bundler, which will allow you to install all tools declared in the gemfile with the right versions. 
 I've created a script to do so : ```scripts/toolchain_install.sh```
 Fastlane is set up , you can find 2 lanes in the fasfile. Those lanes can be executed via the scripts in the "scripts directory".
 - scripts/unit_tests.sh launch test lane which simply execute the unit tests
 - scripts/testflight_upload.sh launch testflight upload so the application can be test in production condition. I choose TetsFlight over fabric because there is no device registration with UIID in tesflight.
 
I managed the certificat and provisonning with fastlane beacause this is a test project. This is an option, and there must be a way not to keep the certificat in the repo. I'd rather create some build configurations with certificate defined for each one.

# Implementation
- To stream the video I choose AVDPlayer, the native iOS player which use HLS.
- To intercept http resquest, I used method swizzling, which basically mean to exchange an method implementation with another. hence, We could alter the implementation of a method and even modify the output. I created an helper method ```DebugLog()```to print ONLY when app run in debug so we won't havr them in production.

##### What are the limitations of your implementation?
My implementation swizzle DataTask method from URLSession to add a print() in the original implementation. In order to log the request sent by the player I check if the domain name is contained in the request before printing it. So here are the limitation:
- If there was other requests made in the application (for instance a GET request to fetch artworks) with the same domain name, the log would be erroned because there would also be requests not sent by player. One solution would be to compare requests paths before login, another would be to swizzle method only when the player is launched.

##### What could go wrong if your solution is put in production into a customer’s app?
1 - the streaming link was not active anymore? no backup link?
2- If there is a network error, there is no message yet

##### What could you do to improve the current implementation? 
- Improve the way I intercept the player http request
- Use another Clean Swift architecture to handle success and error workflow
- Handle network errors
- Create XConfig to handle build configuration and environment, and certificate instead of keeping them in the git repo
- Add full continuous integration with Jenkins, testreport, duplication report, lint report etc..

[HomeBrew]: <https://brew.sh/>
[Bundler]: <https://bundler.io/>
[Fastlane]: <https://fastlane.tools/>
[Swiftlint]: <https://github.com/realm/SwiftLint/>
[Fabric]: <https://fabric.io/home/>
[cleanSwift]: http://clean-swift.com/
[GitFlow]: https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow
