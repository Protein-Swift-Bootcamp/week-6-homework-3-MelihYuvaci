//
//  FeedManager.swift
//  News
//
//  Created by Melih Yuvacı on 10.01.2023.
//

import Foundation

protocol FeedManagerDelegate{
    func didUpdateFeeds(_ feedManager: FeedManager, feeds: [FeedModel])
    func didFailWithError(error: Error)
}

class FeedManager {
    
    var delegate: FeedManagerDelegate?
    
    let baseURL = "https://inshorts.deta.dev/news?category="
    var feedsArray = [FeedModel]()
    
    func fetchFeeds(category: String){
        let urlString = "\(baseURL)\(category)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let feeds = self.parseJson(safeData){
                        self.delegate?.didUpdateFeeds(self, feeds: feeds)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ data: Data)-> [FeedModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(FeedData.self, from: data)
            let category = decodedData.category
            for each in decodedData.data {
                let author = each.author
                let content = each.content
                //                let date = each.date
                let imageUrl = each.imageURL
                let readMoreUrl = each.readMoreURL
                let time = each.time
                let title = each.title
                feedsArray.append(FeedModel(category: category, author: author, content: content, imageUrl: imageUrl, readMoreUrl: readMoreUrl ?? "", time: time, title: title))
            }
            return feedsArray
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

