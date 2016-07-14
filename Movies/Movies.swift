//
//  Movies.swift
//  Movies
//
//  Created by Charles Swafford on 7/14/16.
//  Copyright © 2016 learn IOS 9. All rights reserved.
//

import Foundation

struct Movies {
    
    private var _mName: String
    private var _mRights: String
    private var _mPrice: String
    private var _mRentalPrice: String
    private var _mImageUrl: String
    private var _mSummary: String
    private var _mPreviewUrl: String
    private var _mImid: String
    private var _mGenre: String
    private var _mLinkToiTunes: String
    private var _mReleaseDate: String

    
    // This variable get created from the UI
    var mImageData: NSData?
    
    
    var mName: String {
        return _mName
    }
    var mRights: String {
        return _mRights
    }
    
    var mPrice: String {
        return _mPrice
    }
    
    var mRentalPrice: String {
        return _mRentalPrice
    }
    
    var mSummary: String {
        return _mSummary
    }
    
    var mImageUrl: String {
        return _mImageUrl
    }
    
    
    var mPreviewUrl: String {
        return _mPreviewUrl
    }
    
    var mImid: String {
        return _mImid
    }
    
    var mGenre: String {
        return _mGenre
    }
    
    var mLinkToiTunes: String {
        return _mLinkToiTunes
    }
    
    var mReleaseDate: String {
        return _mReleaseDate
    }
    
    
    init(data: JSONDictionary) {
        
        // If we do not initialize all properties we will get error messages
        // Return from initializer without initializing all stored properties
        
        // Video Name
        if let name = data["im:name"] as? JSONDictionary,
            mName = name["label"] as? String {
            _mName = mName
        }
        else {
            _mName = ""
        }
        
        // Rights
        if let rights = data["rights"] as? JSONDictionary,
            mRights = rights["label"] as? String {
            _mRights = mRights
        }
        else {
            _mRights = ""
        }
        
        // Price
        if let price = data["im:price"] as? JSONDictionary,
            mPrice = price["label"] as? String {
            _mPrice = mPrice
        }
        else {
            _mPrice = ""
        }
        
        // Rental Price
        if let rentalPrice = data["im:rentalPrice"] as? JSONDictionary,
            mRentalPrice = rentalPrice["label"] as? String {
            _mRentalPrice = mRentalPrice
        }
        else {
            _mRentalPrice = ""
        }
        
        // Summary
        if let summary = data["summary"] as? JSONDictionary,
            mSummary = summary["label"] as? String {
            _mSummary = mSummary
        }
        else {
            _mSummary = ""
        }
        
        // Video Image
        if let imageArray = data["im:image"] as? JSONArray,
            imageDict = imageArray[2] as? JSONDictionary,
            image = imageDict["label"] as? String {
            _mImageUrl = image.stringByReplacingOccurrencesOfString("170x170", withString: "600x600")
        }
        else {
            _mImageUrl = ""
        }
        

        // Preview Url
        if let videoLink = data["link"] as? JSONArray,
            videoDict = videoLink[1] as? JSONDictionary,
            videoHref = videoDict["attributes"] as? JSONDictionary,
            videoUrl = videoHref["href"] as? String {
            _mPreviewUrl = videoUrl
        }
        else {
            _mPreviewUrl = ""
        }
        
        // ID & iTunes Link
        _mImid = ""
        _mLinkToiTunes = ""
        if let id = data["id"] as? JSONDictionary {
            // ID
            if let mId = id["attributes"] as? JSONDictionary,
                mImid = mId["im:id"] as? String {
                _mImid = mImid
            }
            // iTunes Link
            if let mLinkToiTunes = id["label"] as? String {
                _mLinkToiTunes = mLinkToiTunes
            }
        }
        
        
        // Genre
        if let category = data["category"] as? JSONDictionary,
            attrib = category["attributes"] as? JSONDictionary,
            mGenre = attrib["term"] as? String {
            _mGenre = mGenre
        }
        else {
            _mGenre = ""
        }
        
        // Release Date
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary,
            attrib = releaseDate["attributes"] as? JSONDictionary,
            mReleaseDate = attrib["label"] as? String {
            _mReleaseDate = mReleaseDate
        }
        else {
            _mReleaseDate = ""
        }
    }

    
}