//
//  ZNJFWebViewController.swift
//  Znjf
//
//  Created by 大强神 on 2018/10/16.
//  Copyright © 2018年 江苏投吧金融服务有限公司. All rights reserved.
//

import UIKit
import WebKit

class ZNJFWebViewController: UIViewController {
    
    var request: URLRequest?
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: WKWebViewConfiguration())
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        
        setup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.load(request!)
    }

}

extension ZNJFWebViewController {
    
    //MARK: - 初始化设置
    func setup() {
        //注册js与原生交互d对象
        let userContentCtl = webView.configuration.userContentController
        userContentCtl.add(self, name: "ZNJFEventHandler")
    }
    
    //MARK: - js与原生交互方法
    //判断客户端是否登录
    func judgeLogin(callBack: (String)->Void) {
        let token = "dqs"
        callBack(token)
    }
    
    //toast提示
    func gotoShowToast(param: Dictionary<String, String>?) {
        print(param!["msg"] ?? "")
    }
    
}

extension ZNJFWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("请求开始：\(webView.url?.absoluteString ?? "")")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("请求完成")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("请求失败：\(error.localizedDescription)")
    }
}

extension ZNJFWebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("message = \(message)")
        completionHandler()
    }
}

extension ZNJFWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "ZNJFEventHandler" {
            if let msgDic = message.body as? Dictionary<String, Any> {
                let methodName = msgDic["methodName"] as! String
                let params = msgDic["params"] as? Dictionary<String, String>
                let callBackID = msgDic["callBackID"] as? String
                if methodName == "judgeLogin" {//判断客户端是否登录
                    judgeLogin { (token) in
                        webView.evaluateJavaScript("ZNJFEventHandler.callBack('\(callBackID!)', '\(token)')", completionHandler: nil)
                    }
                } else if methodName == "gotoShowToast" {//toast提示
                    gotoShowToast(param: params)
                }
            }
        }
    }
}
