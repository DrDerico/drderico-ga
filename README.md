DrDerico Google Analytics
=============================
A Google Analytics native extension for OpenFL (only for Android yet)
-----------------------------

This OpenFL native extension allows you to integrate Google Analytics into your OpenFL application.
Google Analytics is stored in Google Play Services and linked automatically.
The supported compilation target is Android yet.

Installation
------------
You can install it directly from haxelib:
	
	haxelib install drderico-ga


If you didn't install this extension via haxelib and or to have the latest dev version you can download
this sources and set its folder as the source using the following command:
	
	haxelib dev drderico-ga path/to/your/downloaded/files

Recompiling
-----------

    lime rebuild drderico-ga android

Usage
-----
Just call the public methods on the GAnalytics class.

**Basic reference**

First start the session via :
	GAnalytics.init( "YOUR-UA-CODE" );

Tracking a screen view :
	GAnalytics.trackScreen( "your-page-code" );

Tracking an event :
	GAnalytics.trackEvent( "event-cat" , "event-action", "event-label", 1 );

Tracking a social :
	GAnalytics.trackSocial( "social-network-name" , "event-action", "event-target" );

Sending a timing :
	GAnalytics.sendTiming( "timing-cat" , 15000, "timing-name", "timing-label" );

For more advance methods just take a look a the GAnalytics.hx class.

License
-------
This work is under BSD simplified License.
