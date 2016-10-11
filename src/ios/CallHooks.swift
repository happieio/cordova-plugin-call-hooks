import Foundation
import CoreTelephony

@objc(CallHooks) class CallHooks : CDVPlugin  {
    func callEnded(_ command: CDVInvokedUrlCommand) {
        
        
        let callCenter:CTCallCenter = CTCallCenter()
        
        callCenter.callEventHandler = { (call:CTCall!) in
            
            switch call.callState {
            case CTCallStateConnected:
                let timeStart = NSDate().timeIntervalSince1970
                print("CTCallStateConnected")
                
            case CTCallStateDisconnected:
                print("CTCallStateDisconnected")
                let timeEnd = NSDate().timeIntervalSince1970
            default:
                break
            }
        }
    }
}
