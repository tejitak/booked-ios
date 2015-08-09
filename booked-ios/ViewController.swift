//
//  ViewController.swift
//  booked-ios
//
//  Created by Takuya Tejima on 2015/08/09.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var webview : WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var deviceBound : CGRect = UIScreen.mainScreen().bounds
        self.view.frame = deviceBound
        self.view?.backgroundColor = UIColor.blackColor()

        self.webview = WKWebView(frame: CGRectMake(0, 20, deviceBound.size.width, deviceBound.size.height - 20))
        self.webview?.navigationDelegate = self
        self.webview?.UIDelegate = self
        self.webview?.loadRequest(NSURLRequest(URL: NSURL(string: "https://dev-booked.herokuapp.com/")!))
        self.webview?.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.webview!)
    }
    
    override func loadView() {
        super.loadView()
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.view.makeToastActivity()
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        self.view.hideToastActivity()
    }
    
    
    
    // MARK: WKUIDelegate methods
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: (() -> Void)) {
        println("webView:\(webView) runJavaScriptAlertPanelWithMessage:\(message) initiatedByFrame:\(frame) completionHandler:\(completionHandler)")
        
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            completionHandler()
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func webView(webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: ((Bool) -> Void)) {
        println("webView:\(webView) runJavaScriptConfirmPanelWithMessage:\(message) initiatedByFrame:\(frame) completionHandler:\(completionHandler)")
        
        let alertController = UIAlertController(title: "Confirmation", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            completionHandler(false)
        }))
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            completionHandler(true)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

