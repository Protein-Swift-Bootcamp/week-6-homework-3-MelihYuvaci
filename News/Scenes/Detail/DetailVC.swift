//
//  DetailVC.swift
//  News
//
//  Created by Melih Yuvacı on 10.01.2023.
//

import UIKit
import WebKit

class DetailVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var newsUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newsUrl != "" {
            print(newsUrl!)
            if let url = URL(string: newsUrl!){
                let request : URLRequest = .init(url: url)
                webView.load(request)
            }
        }
    }
}
