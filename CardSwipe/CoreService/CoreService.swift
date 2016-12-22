//
//  CoreService.swift
//  CardSwipe
//
//  Created by Techjini on 25/11/16.
//  Copyright © 2016 Techjini. All rights reserved.
//

//API https://www.googleapis.com/books/v1/volumes?q=quilting

import Foundation

typealias ResponseError = (_ data: Data?,_ error: Error?) -> Void

struct CoreService {
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    let request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
    
    func makeRequest(onCompletion: ResponseError?) {
        session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            print("response \((response as! HTTPURLResponse).statusCode)")
            guard let responseError = error else {
                onCompletion?(data,nil)
                return
            }
            onCompletion?(nil,responseError)
        }).resume()
    }
}
