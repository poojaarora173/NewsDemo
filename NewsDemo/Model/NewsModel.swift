//
//  UserModel.swift
//  NewsDemo
//
//  Created by Pooja Arora on 26/03/22.
//

import Foundation
import ObjectMapper

class NewsModel: Mappable {
    
    var title = ""
    var description = ""
    var url = ""
    var urlToImage = ""
    var publishedAt = ""
    var author = ""
    
    
    func mapping(map: Map) {
        title      <- map["title"]
        description      <- map["description"]
        url        <- map["url"]
        urlToImage        <- map["urlToImage"]
        publishedAt   <- map["publishedAt"]
        author    <- map["author"]
    }
    required init?(map: Map) {}
    func toJSONString(prettyPrint: Bool = false) -> String? {
        return Mapper().toJSONString(self, prettyPrint: prettyPrint)
    }
}
