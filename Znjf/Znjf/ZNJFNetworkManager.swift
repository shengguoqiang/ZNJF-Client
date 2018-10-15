//
//  ZNJFNetworkManager.swift
//  Znjf
//
//  Created by 大强神 on 2018/10/15.
//  Copyright © 2018年 江苏投吧金融服务有限公司. All rights reserved.
//

import UIKit
import AdSupport
import Alamofire
import SwiftyJSON

typealias ZNJFNetworkSuccessBlock = (JSON)->Void
typealias ZNJFNetworkFailureBlock = (Int, String)->Void

class ZNJFNetworkManager: NSObject {

    //声明单例
    static let sharedInstance: ZNJFNetworkManager = ZNJFNetworkManager()
    
    //主URL
    let kBaseUrl = "http://localhost:8080/znjf-app/service/"
    
    //声明公参
    let commonParam: Parameters = [
        "phoneVersion": UIDevice.current.systemVersion,//系统版本
        "deviceName": UIDevice.current.model,//设备型号
        "UUID": ASIdentifierManager.shared().advertisingIdentifier.uuidString,//广告标识符（设备唯一标示）
        "platform": "1",//平台编号 1iOS 2安卓
        "channel": "iOS",//渠道
        "appVersion": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!,//应用版本号
        "source": 20 //来源 20iOS 30安卓
                                   ]
    
    //声明请求方法(默认POST)
    @discardableResult
    func requestForData(funcName: String,
                        param: Parameters?,
                        method: HTTPMethod = .post,
                        success: @escaping ZNJFNetworkSuccessBlock,
                        failure: @escaping ZNJFNetworkFailureBlock) -> ZNJFNetworkManager {
        
        //拼接参数
        let finalParam: Parameters = {
            var tempParam = Parameters()
            //处理公参
            for (key, value) in commonParam {
                tempParam[key] = value
            }
            //处理各接口参数
            if let param = param {
                for (key, value) in param {
                    tempParam[key] = value
                }
            }
            return tempParam
        }()
        
        
        //调用Alamofire发送网络请求
        Alamofire.request(kBaseUrl + funcName, method: method, parameters: finalParam, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            let result = JSON(response.result.value ?? "")
            switch response.result {
            case .success:
                success(result)
            case .failure:
                failure(result["code"].intValue, result["message"].stringValue)
            }
        }
        return .sharedInstance
    }
}
