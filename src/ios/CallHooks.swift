import Foundation
import CoreTelephony

@objc(CallHooks) class CallHooks : CDVPlugin  {
    func callEnded(_ command: CDVInvokedUrlCommand) {
        
        let callCenter:CTCallCenter = CTCallCenter()
        
        let timeStart:Double = NSDate().timeIntervalSince1970
        
        callCenter.callEventHandler = { (call:CTCall!) in
            switch call.callState {
            
            case CTCallStateConnected:
                print("CTCallStateConnected")
                
            case CTCallStateDisconnected:
                print("CTCallStateDisconnected")
                let timeEnd:Double = NSDate().timeIntervalSince1970
                let json = "{ \"start\":" + String(format:"%f", timeStart) + ", \"end\":" + String(format:"%f", timeEnd) + "}"
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK,
                                                   messageAs: json)
                self.commandDelegate!.send(pluginResult, callbackId:command.callbackId)
                
            default:
                break
            }
        }
    }
}
