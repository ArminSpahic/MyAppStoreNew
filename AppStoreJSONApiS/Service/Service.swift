//
//  Service.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 08/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import Foundation

class Service {
    
    let searchResults = [SearchResult]()
    
    static let shared = Service()
    
    func fetchMusicContent(searchTerm: String, offset: Int, completion: @escaping (SearchResult?, Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(offset)&limit=20"
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
    }
    func fetchAppDetailsReviews(id: String, completion: @escaping(Reviews?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(id)/sortby=mostrecent/json?l=en&cc=us"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchAppDetails(id: String, completion: @escaping(SearchResult?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/lookup?id=\(id)"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchApps(searchString: String, completion: @escaping(SearchResult?, Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchString)&entity=software"
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
    }
    
    func fetchTopFree(completion: @escaping(AppGroup?, Error?) -> ()) {
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/non-explicit.json"
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func fetchGames(completion: @escaping(AppGroup?, Error?) -> ()) {
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/non-explicit.json"
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping(AppGroup?, Error?) -> ()) {
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/non-explicit.json"
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping([SocialApp]?, Error?) -> ()) {
        
        let url = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: url, completion: completion)
        
    }

    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T? ,Error?) -> ()) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error fetching social apps:", err)
                completion(nil, err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
                
            } catch let jsonErr {
                print("Error decoding social apps:", jsonErr)
                completion(nil, jsonErr)
            }
            
            }.resume()
    }
}

//GENERICS EXAMPLE
//class Stack<T> {
//    var items = [T]()
//    func pushItem(item: T) {items.append(item)}
//    func pop() -> T? {return items.last}
//}
//
//func dummyFunc() {
//    let stackOfStrings = Stack<String>()
//    stackOfStrings.pushItem(item: "string")
//
//    let stackOfInts = Stack<Int>()
//    stackOfInts.pushItem(item: 1)
//}
