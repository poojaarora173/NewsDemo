//
//  APIRequest.swift
//  CommonClasses
//
//  Created by Pooja Arora on 15/02/19.
//  Copyright © 2019 Pooja Arora. All rights reserved.
//

import Foundation
import Alamofire

struct  APIRequest: EndPointProtocol {
    var path: String
    var method: HTTPMethod
    var parameter: JsonDictionary?
    var resultCompletion: APIResultBlock?
    var authorizedToken: String?
  
    init(path: String,
         method: HTTPMethod = .get,
         parameter: JsonDictionary? = nil,
         authToken: String? = nil,
         completion: @escaping APIResultBlock) {
        
        self.path = path
        self.method = method
        self.parameter = parameter
        self.authorizedToken = authToken
        self.resultCompletion = completion
    }
    
    func execute() {
        print("\n============================\nAPI Name: \(path) \n Parameters: \(parameter ?? [:])\n===========================")
        APIClient.shared.performTask(with: self)
    }
    
}

protocol RequestExecuter {
    var apiName: String { get }
    var method: HTTPMethod { get }
    
    func requestWith(parameter: JsonDictionary, completion: @escaping APIResultBlock)
}

extension RequestExecuter {
    
    func requestWith(parameter: JsonDictionary, completion: @escaping APIResultBlock) {
        
        let url = self.apiName
        let token = Webservice.authorizationToken
        let request = APIRequest(path: url, method: self.method, parameter: parameter, authToken: token ,completion: completion)
        
        request.execute()
    }
}
