//
//  FeedData.swift
//  News
//
//  Created by Melih Yuvacı on 10.01.2023.
//

import Foundation

struct FeedData : Codable{
    let category: String
    let data: [Datum]
    let success: Bool
}
struct Datum: Codable {
    let author, content: String
    let date: DateEnum
    let id: String
    let imageURL: String
    let readMoreURL: String?
    let time, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author, content, date, id
        case imageURL = "imageUrl"
        case readMoreURL = "readMoreUrl"
        case time, title, url
    }
}

enum DateEnum: String, Codable {
    case the10Jan2023Tuesday = "10 Jan 2023,Tuesday"
}
