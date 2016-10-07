package io.happie.callhooks;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.content.Context;
import android.util.Log;

public class CallHooks extends CordovaPlugin {
    private final String pluginName = "CallHooks";

    @Override
    public boolean execute(final String action, final JSONArray data, final CallbackContext callbackContext) {
        Log.d(pluginName, pluginName + " called with options: " + data);
        if (action.equals("startNativeRaygun")) startNativeRaygun(data, callbackContext);
        else if(action.equals("testCrash")) testCrash();
        return true;
    }

    private void startNativeRaygun(final JSONArray data, final CallbackContext callbackContext) {
        final Context context = this.cordova.getActivity().getApplicationContext();
        this.cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                RaygunClient.Init(context);
                RaygunClient.AttachExceptionHandler();
                try {
                    JSONObject obj = data.getJSONObject(0);
                    String message;
                    if (obj.has("user")) {
                        RaygunUserInfo user = new RaygunUserInfo();
                        user.FullName = obj.getString("user");
                        RaygunClient.SetUser(user);
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
    }

    private void testCrash() {
        Integer integers[] = new Integer[Integer.MAX_VALUE];
        integers[2147483647] = 2147483647+1;
        testCrash();
        throw new RuntimeException("This is a crash");
    }
}