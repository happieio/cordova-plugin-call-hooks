import Foundation
import CoreTelephony

@objc(CallHooks) class CallHooks : CDVPlugin  {
    static var callCenter:CTCallCenter = CTCallCenter()
    
    @objc(callEnded:)
    func callEnded(_ command: CDVInvokedUrlCommand) {
        CallHooks.callCenter.callEventHandler = { (call:CTCall!) in
            switch call.callState {
            
            case CTCallStateConnected:
                print("CTCallStateConnected")
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "OFFHOOK")
                pluginResult?.setKeepCallbackAs(true)
                self.commandDelegate!.send(pluginResult, callbackId:command.callbackId)

            case CTCallStateDisconnected:
                print("CTCallStateDisconnected")
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "IDLE")
                pluginResult?.setKeepCallbackAs(true)
                self.commandDelegate!.send(pluginResult, callbackId:command.callbackId)
                
            default:
                break
            }
        }
    }
}
