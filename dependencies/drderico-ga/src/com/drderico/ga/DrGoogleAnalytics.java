package com.drderico.ga;

import org.haxe.extension.Extension;

import android.content.Intent;
import android.util.Log;

import com.google.android.gms.analytics.GoogleAnalytics;
import com.google.android.gms.analytics.HitBuilders;
import com.google.android.gms.analytics.Tracker;

/**
 * Extension for GoogleAnalytics
 * Uses Google Play Services
 * @author DrDerico  / drderico.com
 *
 */
public class DrGoogleAnalytics extends Extension
{

	private static final String TAG = "DrGoogleAnalytics";
	private static Tracker _tracker;
	private static String _UA_code;

	/**
	 * Starting new session
	 * @param UA_code	code like "UA-xxxxxx"
	 */
	public static void init(String UA_code)
	{
		_UA_code = UA_code;
	}

	private static Tracker getTracker() throws Exception
	{
		if (_tracker == null)
		{
			if (_UA_code.isEmpty())
				throw new Exception("You must call 'init' method to start work with GoogleAnalytics extension");

			_tracker = GoogleAnalytics.getInstance(mainContext).newTracker(_UA_code);
			setLocalDispatchPeriod(15);
		}

		return _tracker;
	}
	
	public static boolean isInitialized()
	{
		return GoogleAnalytics.getInstance(mainContext).isInitialized();
	}

	public static void trackEvent(String category, String action, String label, int value)
	{
		try
		{
			HitBuilders.EventBuilder b = new HitBuilders.EventBuilder();
			b.setCategory(category);
			b.setAction(action);
			b.setLabel(label);
			b.setValue(Long.valueOf(value));
			getTracker().send(b.build());
		}
		catch (Exception e)
		{
			logException(e);
		}
	}

	public static void trackSocial(String social_network, String action, String target)
	{
		try
		{
			HitBuilders.SocialBuilder b = new HitBuilders.SocialBuilder();
			b.setNetwork(social_network);
			b.setAction(action);
			b.setTarget(target);
			getTracker().send(b.build());
		}
		catch (Exception e)
		{
			logException(e);
		}
	}

	/**
	 * 
	 * @param category
	 * @param interval	  A timing value, in milliseconds. 
	 * @param name
	 * @param label
	 */
	public static void sendTiming(String category, int interval, String name, String label)
	{
		try
		{
			HitBuilders.TimingBuilder b = new HitBuilders.TimingBuilder();
			b.setCategory(category);
			b.setValue(Long.valueOf(interval));
			b.setVariable(name);
			b.setLabel(label);
			getTracker().send(b.build());
		}
		catch (Exception e)
		{
			logException(e);
		}
	}

	public static void trackScreen(String screenName)
	{
		try
		{
			getTracker().setScreenName(screenName);
			getTracker().send(new HitBuilders.AppViewBuilder().build());
		}
		catch (Exception e)
		{
			logException(e);
		}
	}

	/**
	 * Toggles dry run mode. In dry run mode, the normal code paths are executed locally, but hits are not sent to Google Analytics servers. This is useful for debugging calls to the Google Analytics SDK without polluting recorded data.
	 * By default, this flag is disabled. 
	 * @param b
	 */
	public static void setDryRun(boolean b)
	{
		GoogleAnalytics.getInstance(mainContext).setDryRun(b);
	}

	/**
	 * Sets dispatch period for the local dispatcher.
	 * The dispatcher will check for hits to dispatch every dispatchPeriod seconds.
	 * If zero or a negative dispatch period is given, automatic dispatch will be disabled,
	 * and the application will need to dispatch events manually using dispatchLocalHits().
	 * This method only works if local dispatching is in use.
	 * Local dispatching is only used in the absence of Google Play services on the device.
	 * In general, applications should not rely on the ability to dispatch hits manually.
	 * @param s the new dispatch period in seconds 
	 */
	public static void setLocalDispatchPeriod(int s)
	{
		GoogleAnalytics.getInstance(mainContext).setLocalDispatchPeriod(s);
	}

	/**
	 * Sets or resets the application-level opt out flag.
	 * If set, no hits will be sent to Google Analytics.
	 * The value of this flag will not persist across application starts.
	 * The correct value should thus be set in application initialization code.
	 * @param b	true if application-level opt out should be enforced.  
	 */
	public static void setAppOptOut(boolean b)
	{
		GoogleAnalytics.getInstance(mainContext).setAppOptOut(b);
	}

	/**
	 * Dispatches hits queued in the application store (views, events, or transactions) to Google Analytics
	 * if a network connection is available.
	 * This method only works when Google Play service is not available on the device and local dispatching is used.
	 * In general, applications should not rely on the ability to dispatch hits manually. 
	 */
	public static void dispatchLocalHits()
	{
		GoogleAnalytics.getInstance(mainContext).dispatchLocalHits();
	}

	@Override
	public boolean onActivityResult(int requestCode, int resultCode, Intent data)
	{
		return true;
	}

	@Override
	public void onStart()
	{
		super.onStart();
		GoogleAnalytics.getInstance(mainContext).reportActivityStart(mainActivity);
	}

	@Override
	public void onStop()
	{
		super.onStop();
		GoogleAnalytics.getInstance(mainContext).reportActivityStop(mainActivity);
	}

	private static void logException(Exception e)
	{
		Log.e(TAG, e.getMessage());
		e.printStackTrace();
	}

}
