//
//  FeedVC.swift
//  News
//
//  Created by Melih Yuvacı on 10.01.2023.
//

import UIKit
import Kingfisher

class FeedVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var feeds : [FeedModel] = []
    var feedManager = FeedManager()
    var category : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "ReusableFeedCell")
        feedManager.delegate = self
        
        if category != "" {
            navigationItem.title = category!
            feedManager.fetchFeeds(category: category!)
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        if let layout = collectionView.collectionViewLayout as? PinterestLayout{
            layout.delegate = self
        }
        
    }

}

extension FeedVC : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC{
            vc.newsUrl = feeds[indexPath.row].readMoreUrl
            navigationController?.pushViewController(vc, animated: true)
        }
        print(feeds[indexPath.row].author)
    }
}

extension FeedVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableFeedCell", for: indexPath) as! FeedCell
        cell.titleLabel.text = feeds[indexPath.row].title
        cell.imageView.kf.setImage(with: URL(string: feeds[indexPath.row].imageUrl))
        return cell
    }
}

extension FeedVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension FeedVC: FeedManagerDelegate{
    func didUpdateFeeds(_ feedManager: FeedManager, feeds: [FeedModel]) {
        DispatchQueue.main.async {
            self.feeds = feeds
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension FeedVC : PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 0.0
    }
}
