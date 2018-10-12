//
//  ViewController.swift
//  Znjf
//
//  Created by FTD on 2018/9/29.
//  Copyright © 2018年 江苏投吧金融服务有限公司. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("HELLO WORLD!")
        Alamofire.request("http://localhost:8080/znjf-app/service/isTzbUser?mobile=18808181234").responseJSON { (response) in
            print("####json=\(response.result.value!)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

