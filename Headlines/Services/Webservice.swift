//
//  Webservice.swift
//  Headlines
//
//  Created by Mohammad Azam on 11/19/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:Any]

class Webservice {

    private let sourcesURL = URL(string: "https://newsapi.org/v2/sources?apiKey=0cf790498275413a9247f8b94b3843fd")!
    
    func loadHeadlinesByCourse(source :Source, completion :@escaping ([Headline]) -> ()) {
        
        print(source.id)
        
        let urlString = "https://newsapi.org/v2/top-headlines?sources=\((source.id)!)&apiKey=0cf790498275413a9247f8b94b3843fd"
        
        let articlesBySourceURL = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: articlesBySourceURL) { data, _, _ in
            
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let result = json as! JSONDictionary
                let dictionaries = result["articles"] as! [JSONDictionary]
                
                let headlines = dictionaries.flatMap(Headline.init)
                
                DispatchQueue.main.async {
                    completion(headlines)
                }
                
            }
            
        }.resume()
        
    }
    
    func loadSources(completion :@escaping ([Source]) -> ()) {
        
        URLSession.shared.dataTask(with: sourcesURL) { data, _, _ in
            
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let sourceDictionary = json as! JSONDictionary
                let dictionaries = sourceDictionary["sources"] as! [JSONDictionary]
                
                let sources = dictionaries.flatMap(Source.init)
                
                DispatchQueue.main.async {
                    completion(sources)
                }
            }
            
        }.resume()
        
    }
    
}
