//
//  MKAuthentication.swift
//  MKAuthentication
//
//  Created by xiaobin liu on 2018/11/21.
//  Copyright © 2018 Sky. All rights reserved.
//  支付宝登录页面的文案: 1.面容 ID 短时间内失败多次，需要验证手机密码     2.通过Home键验证已有手机指纹    3.验证登录密码


import Foundation
import LocalAuthentication

/// MARK - 身份验证(TouchID or FaceID)
public class MKAuthentication {
    
    /// 是否可以进行TouchID 或者 FaceID 来验证
    public static var isCan: Bool {
        
        let content = LAContext()
        return content.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    
    /// 显示身份验证View
    ///
    /// - Parameters:
    ///   - reason: 原因(例如: 验证多次失败之后,提示: 面容 ID 短时间内失败多次，需要验证手机密码)
    ///   - cancelTitle: 取消标题(iOS10之后才有)
    ///   - fallbackTitle: 回退标题(例如: 验证登录密码)
    ///   - reply: 回复
    /// - Returns: 是否调用成功(true: 成功, false: 失败(没有TouchID 或 面容ID 功能))
    @discardableResult
    public static func showAuthentication(reason: String,
                                          cancelTitle: String,
                                          fallbackTitle: String,
                                          reply: @escaping (Bool, NSError?) -> Void) -> Bool {
        
        if MKAuthentication.isCan {
            
            let content = LAContext()
            content.localizedFallbackTitle = fallbackTitle
            if #available(iOS 10.0, *) {
                content.localizedCancelTitle = cancelTitle
            }
            
            content.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                
                DispatchQueue.main.async {
                    
                    if success {
                        reply(true, nil)
                    } else {
                        reply(false, error! as NSError)
                    }
                }
            }
            return true
        } else {
            
            return false
        }
    }
}
