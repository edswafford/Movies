//
//  MoviesManager.swift
//  Movies
//
//  Created by Charles Swafford on 7/14/16.
//  Copyright © 2016 learn IOS 9. All rights reserved.
//

import Foundation

struct MoviesAPIManager {
 
    func loadData(urlString: String, completion: (result: String) ->Void) {
        
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
                    completion(result: (error?.localizedDescription)!)
                }
                else {
                    // Parse JSON Data
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject]
                    
                        print(json)
                        
                        // High Priority Queue
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0), { 
                            dispatch_async(dispatch_get_main_queue(), { 
                                completion(result: "Sucess")
                            })
                        })
                        
                    }
                    catch {
                        dispatch_async(dispatch_get_main_queue(), { 
                            completion(result: "Error")
                        })
                    }
                }
            })
        }
        task.resume()
        
    }
}