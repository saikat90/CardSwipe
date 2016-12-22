//
//  BookCardView.swift
//  CardSwipe
//
//  Created by Techjini on 28/11/16.
//  Copyright © 2016 Techjini. All rights reserved.
//

import UIKit

class BookCardView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var bookImageView: UIImageView!

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func loadData(book: Book?) {
        titleLabel.text = book?.title ?? ""
        subtitleLabel.text = book?.subtitle ?? ""
        descriptionLabel.text = book?.decription
        authorLabel.text = book?.authors.joined(separator: ",")
        bookImageView.setImage(imageWith: book?.thumbnail)
    }
        
}

extension UIImageView {
    
    func setImage(imageWith url: URL?) {
        let request = URLRequest(url: url!)
        let coreService = CoreService(request: request)
        coreService.makeRequest {[weak self] (data: Data?, error: Error?) in
            if let imageData = data {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: imageData)
                }
                return
            }
        }
    }
    
}
