//
//  Webservice.swift
//  CommonClasses
//
//  Created by Pooja Arora on 01/11/18.
//  Copyright © 2018 Pooja Arora. All rights reserved.
//

import Foundation
import Alamofire

enum Webservice {

    static var authorizationToken : String {
        return ""  // - If Required.
    }
    
    //Test Url
    static let apiKey = "c11d7ec16ba4462ba5a04e696d3c4622"
    static let baseUrl = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=" + apiKey
    
    enum News: RequestExecuter {
        
        case getNewsList
        
        var method: HTTPMethod {
            switch self {
            case .getNewsList :
                return .post
            }
        }
        
        var apiName: String {
            switch self {
            case .getNewsList:
                return baseUrl
            }
        }
    }
  
}











