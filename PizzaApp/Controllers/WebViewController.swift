//
//  WebViewController.swift
//  PizzaApp
//
//  Created by Tanish Aggarwal on 2026-07-14.
//

import UIKit
import WebKit

class WebViewController: UIViewController , WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set delegate so we get loading callbacks
                webView.navigationDelegate = self
                
                // load a webpage - change this URL to whatever you like
                if let urlAddress = URL(string: "https://www.apple.com") {
                    let request = URLRequest(url: urlAddress)
                    webView.load(request)
                }
    }
    
    // called when the page starts loading
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            activity.startAnimating()
            activity.isHidden = false
        }
        
        // called when the page finishes loading
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            activity.stopAnimating()
            activity.isHidden = true
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
