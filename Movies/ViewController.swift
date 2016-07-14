//
//  ViewController.swift
//  Movies
//
//  Created by Charles Swafford on 7/13/16.
//  Copyright © 2016 learn IOS 9. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var movies = [Movies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moviesAPIManager = MoviesAPIManager()
        
        moviesAPIManager.loadData("https://itunes.apple.com/us/rss/topmovies/limit=10/json", completion: didLoadData)
        
    }

    
    func didLoadData(movies: [Movies]) {
        self.movies = movies
        
        for (index, item) in movies.enumerate() {
            var price = "Rent $\(item.mRentalPrice)"
            
            if item.mRentalPrice.isEmpty {
                price = "Buy $\(item.mPrice)"
            }
            else {
                price += " Buy $\(item.mPrice)"
            }
            print("\(index) name = \(item.mName) \(price)")
        }
    }

}

