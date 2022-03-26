//
//  APIClient.swift
//  CommonClasses
//
//  Created by Pooja Arora on 27/11/18.
//  Copyright © 2018 Pooja Arora. All rights reserved.
//

import Foundation
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

class APIClient: NSObject {
    
    static let shared = APIClient()
    
    let session = Alamofire.Session.default
    
    
    // General request
    func performTask(with request: APIRequest) {
        
        let headers = APIClient.httpsHeaders(with: request.authorizedToken)
        
        session.sessionConfiguration.timeoutIntervalForRequest = 600
        if #available(iOS 11, *) {
            session.sessionConfiguration.waitsForConnectivity = true
        }
        
        
        session.request(request.path, method: request.method,
                        parameters: request.parameter,
                        encoding: URLEncoding.default,
                        headers: headers)
            .responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    if Connectivity.isConnectedToInternet != true{
                        let apiError = APIError(error: error, message: kNO_CONNECTION_MESSAGE, code: error.responseCode ?? 0)
                        request.resultCompletion?(.fail(apiError))
                        return
                    }
                    if  error.responseCode == 403 || error.responseCode == 400{
                        let apiError = APIError(error: error, message: error.localizedDescription, code: error.responseCode ?? 0)
                        request.resultCompletion?(.fail(apiError))
                        return
                    }else{
                    }
                    
                    let apiError = APIError(error: error, message: error.localizedDescription, code: error.responseCode ?? 0)
                    
                    print("\n\n===========Error===========")
                    print("Error Code: \(error._code)")
                    print("Error Messsage: \(error.localizedDescription)")
                    if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                        print("Server Error: " + str)
                    }
                    debugPrint(error as Any)
                    print("===========================\n\n")
                    
                    request.resultCompletion?(.fail(apiError))
                    
                case .success(let value):
                    if let json = value as? ResponseBody {
                        print(json)
                        var responseObj = APIResponse(json)
                        
                        // handle your status code base response
                        if responseObj.isSuccess {
                            
                            responseObj.headers = response.response?.allHeaderFields
                            request.resultCompletion?(.success(responseObj))
                            
                        } else {
                            request.resultCompletion?(.fail(APIError(error: nil, message: responseObj.message, code: responseObj.statusCode)))
                        }
                    } else {
                        request.resultCompletion?(.fail(APIError(error: nil, message: ResponseParseErrorMessage, code: 0)))
                    }
                }
            }
        
    }
    // class methods
    class func httpsHeaders(with token: String?) -> HTTPHeaders {
        var defaultHeaders = HTTPHeaders.default
        if let token = token {
            defaultHeaders["Authorization"] = "\(token)"
        }
        return defaultHeaders
    }
    
}


// MARK: - Helper Classes

struct APIResponse {
    var statusCode: Int = -1
    var body: ResponseBody?
    var message: String = ""
    var headers : [AnyHashable : Any]?
    
    var isSuccess: Bool {
        return statusCode == 1 || statusCode == 2
    }
    
    init() {
        //
    }
    
    init(_ json: ResponseBody) {
        // handle response code and message
        // it may be different as per API development.
        
        var code = json["status"] as? Int
        
        // custom status can be handle here as per server response.
        //example
        if code == nil {
            let status = json["status"] as? String
            code = status?.lowercased() == "OK".lowercased() ? 1 : 0
        }
        
        let msg = json["message"] as? String
        
        statusCode = code!
        body =  json
        message = msg ?? ""
        
    }
}
