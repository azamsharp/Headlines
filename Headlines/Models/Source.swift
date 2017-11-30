//
//  Source.swift
//  Headlines
//
//  Created by Mohammad Azam on 11/19/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation

class Source {
    
    var id :String!
    var name :String!
    var description :String!
    
    init?(dictionary :JSONDictionary) {
        
        guard let id = dictionary["id"] as? String,
        let name = dictionary["name"] as? String,
            let description = dictionary["description"] as? String else {
                return nil
    }
        
        self.id = id
        self.name = name
        self.description = description
}
    
    init(viewModel :SourceViewModel) {
        
        self.id = viewModel.id
        self.name = viewModel.name
        self.description = viewModel.body
    }
    
}
