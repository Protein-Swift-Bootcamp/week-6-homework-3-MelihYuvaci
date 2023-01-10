//
//  FeedVC.swift
//  News
//
//  Created by Melih Yuvacı on 10.01.2023.
//

import UIKit

class FeedVC: UIViewController {
    
    var feedManager = FeedManager()
    var category : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if category != "" {
            navigationItem.title = category!
            feedManager.fetchFeeds(category: category!)
        }
        
    }

}
