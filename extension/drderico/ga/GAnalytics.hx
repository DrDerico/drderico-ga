package extension.drderico.ga;

#if (android && openfl)
import openfl.utils.JNI;
#end

/**
 * Google Analytics extension
 * @author DrDerico / drderico.com
 */
class GAnalytics
{

	public static function init(UA_code:String)
	{
		#if (android && openfl)
			if (initted)
			{
				trace("GoogleAnalytics: WON'T INIT TWICE!");
				return;
			}
			initted = true;

			try
			{
				// link JNI methods
				var javaClassName = "com.drderico.ga.DrGoogleAnalytics";
				ganalytics_init_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "init", "(Ljava/lang/String;)V");
				ganalytics_trackEvent_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "trackEvent", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V");
				ganalytics_trackSocial_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "trackSocial", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
				ganalytics_trackScreen_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "trackScreen", "(Ljava/lang/String;)V");
				ganalytics_sendTiming_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "sendTiming", "(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V");
				ganalytics_setDryRun_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "setDryRun", "(Z)V");
				ganalytics_setLocalDispatchPeriod_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "setLocalDispatchPeriod", "(I)V");
				ganalytics_setAppOptOut_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "setAppOptOut", "(Z)V");
				ganalytics_dispatchLocalHits_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "dispatchLocalHits", "()V");
				ganalytics_isInitialized_jni = openfl.utils.JNI.createStaticMethod(javaClassName, "isInitialized", "()Z");
			}
			catch (e:Dynamic)
			{
				trace("GoogleAnalytics linkMethods Exception: " + e);
			}

			ganalytics_init_jni(UA_code);
		#end
	}

	public static function isInitialized():Bool
	{
		#if (android && openfl)
			return ganalytics_isInitialized_jni();
		#end
		return false;
	}

	public static function trackEvent(category:String , action:String, label:String, value:Int = 1)
	{
		#if (android && openfl)
			ganalytics_trackEvent_jni(category, action, label, value);
		#end
	}

	public static function trackSocial(social_network:String, action:String, target:String)
	{
		#if (android && openfl)
			ganalytics_trackSocial_jni(social_network, action, target);
		#end
	}

	public static function trackScreen(screenName:String)
	{
		#if (android && openfl)
			ganalytics_trackScreen_jni(screenName);
		#end
	}

	/**
	 *
	 * @param	category
	 * @param	interval	A timing value, in milliseconds.
	 * @param	name
	 * @param	label
	 */
	public static function sendTiming(category:String, interval:Int, name:String, label:String)
	{
		#if (android && openfl)
			ganalytics_sendTiming_jni(category, interval, name, label);
		#end
	}

	/**
	 * Toggles dry run mode. In dry run mode, the normal code paths are executed locally, but hits are not sent to Google Analytics servers. This is useful for debugging calls to the Google Analytics SDK without polluting recorded data.
	 * By default, this flag is disabled.
	 *
	 * @param b
	 */
	public static function setDryRun(b:Bool)
	{
		#if (android && openfl)
			ganalytics_setDryRun_jni(b);
		#end
	}

	/**
	 * Sets dispatch period for the local dispatcher.
	 * The dispatcher will check for hits to dispatch every dispatchPeriod seconds.
	 * If zero or a negative dispatch period is given, automatic dispatch will be disabled,
	 * and the application will need to dispatch events manually using dispatchLocalHits().
	 * This method only works if local dispatching is in use.
	 * Local dispatching is only used in the absence of Google Play services on the device.
	 * In general, applications should not rely on the ability to dispatch hits manually.
	 *
	 * @param s the new dispatch period in seconds
	 */
	public static function setLocalDispatchPeriod(v:Int)
	{
		#if (android && openfl)
			ganalytics_setLocalDispatchPeriod_jni(v);
		#end
	}

	/**
	 * Sets or resets the application-level opt out flag.
	 * If set, no hits will be sent to Google Analytics.
	 * The value of this flag will not persist across application starts.
	 * The correct value should thus be set in application initialization code.
	 *
	 * @param b	true if application-level opt out should be enforced.
	 */
	public static function setAppOptOut(b:Bool)
	{
		#if (android && openfl)
			ganalytics_setAppOptOut_jni(b);
		#end
	}

	/**
	 * Dispatches hits queued in the application store (views, events, or transactions) to Google Analytics
	 * if a network connection is available.
	 * This method only works when Google Play service is not available on the device and local dispatching is used.
	 * In general, applications should not rely on the ability to dispatch hits manually.
	 */
	public static function dispatchLocalHits()
	{
		#if (android && openfl)
			ganalytics_dispatchLocalHits_jni();
		#end
	}

	static private var ganalytics_init_jni(default, null):String->Void = function(UA_code:String) { };
	static private var ganalytics_trackEvent_jni(default, null):String->String->String->Int->Void = function(category:String, action:String, label:String, value:Int) { };
	static private var ganalytics_trackSocial_jni(default, null):String->String->String->Void = function(social_network:String, action:String, target:String) { };
	static private var ganalytics_trackScreen_jni(default, null):String->Void = function(screenName:String) { };
	static private var ganalytics_sendTiming_jni(default, null):String->Int->String->String->Void = function(category:String, interval:Int, name:String, label:String) { };
	static private var ganalytics_setDryRun_jni(default, null):Bool->Void = function(b:Bool) { };
	static private var ganalytics_setLocalDispatchPeriod_jni(default, null):Int->Void = function(v:Int) { };
	static private var ganalytics_setAppOptOut_jni(default, null):Bool->Void = function(b:Bool) { };
	static private var ganalytics_dispatchLocalHits_jni(default, null):Void->Void = function() { };
	static private var ganalytics_isInitialized_jni(default, null):Void->Bool = function():Bool { return false; };

	static private var initted:Bool = false;
}