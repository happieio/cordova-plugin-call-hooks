import Foundation
import CoreTelephony

@objc(CallHooks) class CallHooks : CDVPlugin  {
    func callEnded(_ command: CDVInvokedUrlCommand) {
        
        let callCenter:CTCallCenter = CTCallCenter()
        
        callCenter.callEventHandler = { (call:CTCall!) in
            switch call.callState {
            
            case CTCallStateConnected:
                print("CTCallStateConnected")
                
            case CTCallStateDisconnected:
                print("CTCallStateDisconnected")
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "OFFHOOK")
                self.commandDelegate!.send(pluginResult, callbackId:command.callbackId)
                
            default:
                break
            }
        }
    }
}
