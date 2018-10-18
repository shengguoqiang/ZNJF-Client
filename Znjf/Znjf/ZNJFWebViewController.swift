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

        print("width = \(UIScreen.main.bounds.width)")
        print("height = \(UIScreen.main.bounds.height)")
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: WKWebViewConfiguration())
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.load(request!)
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
