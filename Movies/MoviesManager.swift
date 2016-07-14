//
//  MoviesManager.swift
//  Movies
//
//  Created by Charles Swafford on 7/14/16.
//  Copyright © 2016 learn IOS 9. All rights reserved.
//

import Foundation

struct MoviesAPIManager {
    
    func loadData(urlString: String, completion: (movies: [Movies]) ->Void) {
        
        // set up for no caches
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        guard let url = NSURL(string: urlString) else {
            NSLog("Failed to create URL from '\(urlString)'")
            return
        }
        
        // create task to run on another thread
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                if error != nil {
                    NSLog(error!.localizedDescription)
                }
                else {
                    // Parse JSON Data
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                            feed = json["feed"] as? JSONDictionary,
                            entries = feed["entry"] as? JSONArray {
                            
                            var movies = [Movies]()
                            for entry in entries {
                                let next = Movies(data: entry as! JSONDictionary)
                                movies.append(next)
                            }
                            print("iTunesApiManager - total count --> \(movies.count)\n")

                            // High Priority Queue
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0), {
                                dispatch_async(dispatch_get_main_queue(), {
                                    completion(movies: movies)
                                })
                            })
                        }
                    }
                    catch {
                      NSLog("Error NSJSONSerialization")
                    }
                }
            })
        }
        task.resume()
        
    }
}