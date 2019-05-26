//
//  SearchResult.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 08/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
    

}

struct Result: Decodable {
    let trackName, primaryGenreName, artworkUrl100, formattedPrice, description, artistName, collectionName, releaseNotes: String?
    let trackId: Int?
    let averageUserRating: Float?
    let screenshotUrls: [String]?
}
