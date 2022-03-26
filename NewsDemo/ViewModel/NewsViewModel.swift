//
//  NewsViewModel.swift
//  NewsDemo
//
//  Created by Pooja Arora on 26/03/22.
//

import Foundation
import ObjectMapper

class NewsViewModel{
    //MARK:- ======== Variable Declaration ========
    static var instance: NewsViewModel = NewsViewModel()
    
    var aryNewsModel = [NewsModel]()
    
    //MARK:- Login API Call
    func getNewsList( completion: @escaping (Bool, String) -> Void) {
        Webservice.News.getNewsList.requestWith(parameter: [:]) { (result) in
            print("Response from News List is is",result)
            switch result {
            case .success(let response):
                if let body = response.body{
                    if let bodyData = body["articles"] as? [[String : Any]] {
                        self.aryNewsModel = Mapper<NewsModel>().mapArray(JSONArray: bodyData )
                    }
                    completion(true, body["message"] as? String ?? "")
                }
            case .fail(let error):
                completion(false, error.message)
            }
        }
    }
}




