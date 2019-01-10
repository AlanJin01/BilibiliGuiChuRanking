//
//  NextViewController.swift
//  BilibiliGuiChuRanking2
//
//  Created by J K on 2019/1/10.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit

class NextViewController: UIViewController, UIWebViewDelegate {

    var webView: UIWebView!
    
    //视频网址
    var path = String()
    var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(NextViewController.back))

        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        webView.delegate = self
        webView.backgroundColor = #colorLiteral(red: 1, green: 0.7658459821, blue: 0.7677842445, alpha: 1)
        self.view.addSubview(webView)
        
        loadingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 140, height: 50))
        loadingLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        loadingLabel.textAlignment = NSTextAlignment.center
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = #colorLiteral(red: 1, green: 0.4317408278, blue: 0.4798942456, alpha: 1)
        
        self.view.addSubview(loadingLabel)
    }
    
    //返回根视图
    @objc func back() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: "https://www.bilibili.com/video/av\(self.path)")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
        
    }

}
