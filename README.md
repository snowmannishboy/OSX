OSX
===

In this directory are several versions of my first attempts at an Application intended for the Mac OS X Operating System. Currently, I have only targeted 10.9, though I plan to soon cross compile to 10.8, and distribute that as well. 
I have developed this program to be as lightweight as possible. As the intended distribution channel is the OS X App Store, application sandboxing has been enabled. Currently, the application only requires read access to the file system, and only to the directories that the user selects.

In an effort to be as clean as possible, wihtout being an expert in Objective-C or the Cocoa framework, CoreData, or even CoreFoundation (I'm working on it), I have decided to store data in SQLite format, using CoreData as the interface, though obviously it doesn't interact directly with this data store. 

At this stage of development, there is not enough data to have a sufficiently complex Schema, though eventually through the integration of native file tagging, I will have to integrate a sufficient data schema to integrate non-native tagging for platforms prior to 10.9

The only thing that is stored, and this can be verified by going through the entire repo, is the encrypted NSData object that Apple generates for Security-Scoped bookmarks. Nothiing related to the actual path's and/or name of files is ever stored, in fact, upon closing, this data is completely released.

Standard documents will be forthcoming, such as 
  * SRS - Software Requirements Specification
  * SAD - Software Architecture Document
  * SDD - Software Design Document

However I currently work, go to school, and do this on the side, so it will only occur as I get time to work on it.


Installation
===

Right now I have uploaded a binary, contained in "ImageBrowser.zip". This is signed through my credentials through the Apple Store, and on machines running OS X 10.9, all that should be required is un-zipping and placing inside the /Application directory or, the /Users/<current user>/Applications directory. 

The Application is also available through the Mac OS X App Store, at <a href="https://itunes.apple.com/us/app/image-browser/id823262437?mt=12">this link</a>. It is a completely free application, and as you can tell, open source as well


License
===
You.....can do pretty much whatever you want with this code. I wrote this application because I could not find a lightweight client for browsing and viewing animated GIF's on my Macbook. So far, it has proven to be pretty lightweight both in memory consumption and CPU utilization, as primitive view building blocks are used to provide most of the functionality. For example, a simple NSImageView and NSScrollView combination is used to allow both Operating System level support of image animation, as well as (since OS X 10.8) zoom support (positive, not negative). 


Support
===
For any questions/comments/anything, please contact me at <href="mailto:rnovak@asu.edu">this</a> email address. I will do my best to accomidate all requests.

A real support website is under works, and once I have it designed/implemented, it will be available at <a href="http://robert-novak.com/">http://robert-novak.com</a>
