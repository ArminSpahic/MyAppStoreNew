//
//  GameSearchResult.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 18/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed?
}

struct Feed: Decodable {
    let title: String?
    let results: [AppResult]
}

struct AppResult: Decodable {
    let id, artistName, name, artworkUrl100: String?
}

