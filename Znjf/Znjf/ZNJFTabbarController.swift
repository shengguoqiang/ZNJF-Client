//
//  ZNJFTabbarController.swift
//  Znjf
//
//  Created by 大强神 on 2018/10/16.
//  Copyright © 2018年 江苏投吧金融服务有限公司. All rights reserved.
//

import UIKit

class ZNJFTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化tab
        let homeVC = ZNJFHomePageController.init(nibName: "ZNJFHomePageController", bundle: nil)
//        homeVC.title = "首页"
//        homeVC.tabBarItem = UITabBarItem(title: "首页", image: nil, selectedImage: nil)
        let homeNav = ZNJFNavgationController.init(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "首页", image: nil, selectedImage: nil)
        addChildViewController(homeNav)
    }

}
