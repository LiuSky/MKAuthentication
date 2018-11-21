//
//  ViewController.swift
//  MKAuthentication
//
//  Created by Sky on 11/21/2018.
//  Copyright (c) 2018 Sky. All rights reserved.
//

import UIKit
import MKAuthentication
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MKAuthentication.showAuthentication(reason: "面容 ID 短时间内失败多次，需要验证手机密码",
                                            cancelTitle: "取消",
                                            fallbackTitle: "验证登录密码") { (success, error) in
                                                
                                                if success {
                                                    debugPrint("成功")
                                                    let vc = UIViewController()
                                                    vc.view.backgroundColor = UIColor.yellow
                                                    self.present(vc, animated: true, completion: nil)
                                                } else {
                                                    
                                                    guard let temError = error as NSError? else {
                                                        return
                                                    }
                                                    
                                                    switch Int32(temError.code) {
                                                    case kLAErrorAuthenticationFailed:
                                                        debugPrint("验证失败")
                                                    case kLAErrorUserCancel:
                                                        debugPrint("被用户手动取消")
                                                    case kLAErrorUserFallback:
                                                        debugPrint("用户不使用TouchID,选择手动输入密码")
                                                    case kLAErrorSystemCancel:
                                                        debugPrint("被系统取消 (如遇到来电,锁屏,按了Home键等)")
                                                    case kLAErrorPasscodeNotSet:
                                                        debugPrint("无法启动,因为用户没有设置密码")
                                                    case kLAErrorTouchIDNotEnrolled:
                                                        debugPrint("无法启动,因为用户没有设置TouchID")
                                                    case kLAErrorTouchIDNotAvailable:
                                                        debugPrint("无效")
                                                    case kLAErrorTouchIDLockout:
                                                        
                                                        debugPrint("被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)")
                                                        //                                                        let can = content.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil)
                                                        //                                                        if can {
                                                        //
                                                        //                                                            content.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "输入密码", reply: { (success, error) in
                                                        //                                                                debugPrint(success)
                                                        //                                                                debugPrint(error)
                                                        //                                                            })
                                                        //                                                        } else {
                                                        //                                                            debugPrint("调起账号密码页面失败")
                                                    //                                                        }
                                                    case kLAErrorAppCancel:
                                                        debugPrint("当前软件被挂起并取消了授权 (如App进入了后台等)")
                                                    case kLAErrorInvalidContext:
                                                        debugPrint("当前软件被挂起并取消了授权 (LAContext对象无效)")
                                                    default:
                                                        debugPrint("取消")
                                                    }
                                                }
                                                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

