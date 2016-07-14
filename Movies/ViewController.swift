//
//  ViewController.swift
//  Movies
//
//  Created by Charles Swafford on 7/13/16.
//  Copyright © 2016 learn IOS 9. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moviesAPIManager = MoviesAPIManager()
        
        moviesAPIManager.loadData("https://itunes.apple.com/us/rss/topmovies/limit=10/json", completion: didLoadData)
        
    }

    
    func didLoadData(result: String) {
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            // do something if you want
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

