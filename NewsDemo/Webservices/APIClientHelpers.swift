//
//  APIClientHelpers.swift
//  CommonClasses
//
//  Created by Pooja Arora on 15/02/19.
//  Copyright © 2019 Pooja Arora. All rights reserved.
//

import Foundation
import Alamofire

enum ApiError: Error {
    case networkNotAvailable
    case serverError
    
    var localizedDescription: String {
        switch self {
        case .networkNotAvailable:
            return "networkNotAvailable"
        case .serverError:
            return "serverError"
        }
    }
}

typealias JsonDictionary = [String : Any]
typealias JsonArray = [JsonDictionary]

typealias APIResultBlock = (APIClientResult) -> Void

typealias ResponseBody = [String : Any]

let ResponseParseErrorMessage = "Sorry! we couldn't parse the server response."

// Result : will be returned to API caller
enum APIClientResult {
    case fail(APIError)
    case success(APIResponse)
}


// not using in current version
enum APIClientUploadDownloadResult {
    case fail(APIError)
    case success(Any)
    case progress(Float)
}

protocol EndPointProtocol {
    var path: String { get set }
    var method: HTTPMethod  { get set }
    var parameter: JsonDictionary?  { get set }
    var resultCompletion: APIResultBlock?  { get set }
}

struct APIError {
    var error: Error?
    var message = ""
    var code = 0
}
