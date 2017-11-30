//
//  Headline.swift
//  Headlines
//
//  Created by Mohammad Azam on 11/19/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation

class Headline {
    
    var title :String!
    var description :String!
    
    init?(dictionary :JSONDictionary) {
        
        guard let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String else {
                return nil
        }
        
        self.title = title
        self.description = description
    }
}
