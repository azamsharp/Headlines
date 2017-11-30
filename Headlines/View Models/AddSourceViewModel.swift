//
//  AddSourceViewModel.swift
//  Headlines
//
//  Created by Mohammad Azam on 11/21/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation

class AddSourceViewModel {
    
    var title :String!
    var description :String!
    
    func remainingNumberOfAllowedCharacters(numberOfCharactersEntered :Int, limit :Int) -> Int {
       
        let count = limit - numberOfCharactersEntered
       
        if count < 0 {
            return 0
        }
        
        return count
    }
}


