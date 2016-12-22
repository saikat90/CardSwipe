//
//  ViewController.swift
//  CardSwipe
//
//  Created by Techjini on 25/11/16.
//  Copyright © 2016 Techjini. All rights reserved.
//

import UIKit
import Koloda

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cardView: KolodaView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestResponseHandler = RequestResponseHandler()
        cardView.delegate = self
        cardView.dataSource = self
        activityIndicator.startAnimating()
        requestResponseHandler.getCardRequest {[weak self] (books: [Book]?, error: Error?) in
            self?.loadingLabel.isHidden = true
            self?.activityIndicator.stopAnimating()
            self?.books = books ?? [Book]()
            self?.cardView.reloadData()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func undoAction(_ sender: Any) {
        loadingLabel.isHidden = true
        cardView.revertAction()
    }
}

extension ViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        loadingLabel.isHidden = false
        loadingLabel.text = "No Cards are available"
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        print("index \(index)")
    }
    
    
}

extension ViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> UInt {
        return UInt(books.count)
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let bookCardView =  Bundle.main.loadNibNamed("BookCardView", owner: self, options: nil)?.first as! BookCardView
        bookCardView.loadData(book: books[Int(index)])
        return bookCardView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?.first as! CustomOverlayView
    }
    
}
