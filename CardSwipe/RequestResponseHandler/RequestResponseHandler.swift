//
//  RequestResponseHandler.swift
//  CardSwipe
//
//  Created by Techjini on 28/11/16.
//  Copyright © 2016 Techjini. All rights reserved.
//

import Foundation

let bookApi = "https://www.googleapis.com/books/v1/volumes?q=quilting"

typealias BookResponseError = (_ books: [Book]?, _ error: Error?) -> Void

struct RequestResponseHandler {
    
    func getCardRequest(onCompletion: BookResponseError?) {
        let request = URLRequest(url: URL(string: bookApi)!)
        let coreService = CoreService(request: request)
        coreService.makeRequest { (data: Data?, error: Error?) in
            
            guard let responseError = error else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                    let items = json?["items"] as! [[String: Any]]
                    let books = items.map({ (item: [String: Any])  -> Book in
                        let volumeInfo = item["volumeInfo"] as? [String: Any]
                        let title = volumeInfo?["title"] as? String ?? ""
                        let subTitle = volumeInfo?["subtitle"] as? String ?? ""
                        let description = volumeInfo?["description"] as? String ?? ""
                        let authors = volumeInfo?["authors"] as? [String] ?? ["No Author"]
                        let imageLinks = volumeInfo?["imageLinks"] as? [String: String]
                        let thumbnail = imageLinks?["thumbnail"] ?? ""
                        return Book(title: title, subtitle: subTitle, decription: description, authors: authors, thumbnail: URL(string: thumbnail)!)
                    })
                    
                    //To update UI
                    DispatchQueue.main.async {
                        onCompletion?(books,nil)
                    }
                    
                } catch let error as NSError {
                    print("\(error)")
                }
                return
            }
            onCompletion?(nil,responseError)
        }
    }
    
}


