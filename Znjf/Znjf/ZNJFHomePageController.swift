//
//  ZNJFHomePageController.swift
//  Znjf
//
//  Created by 大强神 on 2018/10/16.
//  Copyright © 2018年 江苏投吧金融服务有限公司. All rights reserved.
//

import UIKit
import Kingfisher

class ZNJFHomePageController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    var link: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ZNJFNetworkManager.sharedInstance.requestForData(funcName: "homePage", param: nil, success: { [unowned self] (response) in
            print(response)
            let configList = response["configList"].arrayValue
            for config in configList {
                if config["bussinessCode"].stringValue == "JFSC" {
                    self.btn.setTitle(config["iconName"].stringValue, for: .normal)
                    print("iconUrl = \(config["iconUrl"].stringValue)")
                    self.btn.kf.setImage(with: URL(string: config["iconUrl"].stringValue), for: .normal)
                    self.link = config["bussinessLink"].stringValue
                }
            }
            
        }) { (code, msg) in
            print("请求失败：{code: \(code), msg: \(msg)}")
        }
    }

    @IBAction func btnDidClick(_ sender: UIButton) {
        
        let web = ZNJFWebViewController.init(nibName: "ZNJFWebViewController", bundle: nil)
        web.request = URLRequest(url: URL(string: kBaseUrl + link)!)
        navigationController?.pushViewController(web, animated: true)
        
    }
}
