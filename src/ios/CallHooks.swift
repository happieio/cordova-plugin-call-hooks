import Foundation
import CoreTelephony

@objc(CallHooks) class CallHooks : CDVPlugin  {
    static var callCenter:CTCallCenter = CTCallCenter()
    
    func callEnded(_ command: CDVInvokedUrlCommand) {
        CallHooks.callCenter.callEventHandler = { (call:CTCall!) in
            switch call.callState {
            
            case CTCallStateConnected:
                print("CTCallStateConnected")
                
            case CTCallStateDisconnected:
                print("CTCallStateDisconnected")
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "IDLE")
                self.commandDelegate!.send(pluginResult, callbackId:command.callbackId)
                
            default:
                break
            }
        }
    }
}
