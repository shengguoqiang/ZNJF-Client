//
//  ViewController.swift
//  Znjf
//
//  Created by FTD on 2018/9/29.
//  Copyright © 2018年 江苏投吧金融服务有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mobile = "18808181237"
    let password = "123abc"
    var vercode = "211764"

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func verCode(_ sender: Any) {
        ZNJFNetworkManager.sharedInstance.requestForData(funcName: "verfication", param: ["mobile": mobile, "type": "1"], success: { (response) in
            print("请求成功：{response: \(response)}")
        }) { (code, message) in
            print("请求失败：{code: \(code), msg: \(message)}")
        }
    }
    
    @IBAction func register(_ sender: Any) {
        ZNJFNetworkManager.sharedInstance.requestForData(funcName: "regedit", param: ["mobile": mobile, "password": password, "verCode": vercode], success: { (response) in
            print("请求成功：{response: \(response)}")
        }) { (code, message) in
            print("请求失败：{code: \(code), msg: \(message)}")
        }
    }
    
    @IBAction func login(_ sender: Any) {
        ZNJFNetworkManager.sharedInstance.requestForData(funcName: "login", param: ["username": mobile, "password": password], success: { (response) in
            print("请求成功：{response: \(response)}")
        }) { (code, message) in
            print("请求失败：{code: \(code), msg: \(message)}")
        }
    }
    
    @IBAction func output(_ sender: Any) {
        ZNJFNetworkManager.sharedInstance.requestForData(funcName: "homePage", param: nil, success: { (response) in
            print("请求成功：{response: \(response)}")
        }) { (code, message) in
            print("请求失败：{code: \(code), msg: \(message)}")
        }
    }
}

