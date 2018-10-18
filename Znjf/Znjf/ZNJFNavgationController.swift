//
//  ZNJFNavgationController.swift
//  Znjf
//
//  Created by 大强神 on 2018/10/16.
//  Copyright © 2018年 江苏投吧金融服务有限公司. All rights reserved.
//

import UIKit

class ZNJFNavgationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}
