//
//  HeadlineListViewModel.swift
//  Headlines
//
//  Created by Mohammad Azam on 11/20/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation

class HeadlineListViewModel {
    
    var selectedSource :SourceViewModel!
    public private(set) var headlines :[HeadlineViewModel] = [HeadlineViewModel]()
    
    init(source :SourceViewModel) {
        self.selectedSource = source
    }
    
    func populateHeadlines(completion :@escaping () -> ()) {
        
        let source = Source(viewModel :self.selectedSource)
        
        Webservice().loadHeadlinesByCourse(source: source) { headlines in
            
            self.headlines = headlines.flatMap(HeadlineViewModel.init)
            DispatchQueue.main.async {
                completion() 
            }
        }
    }
    
    func headline(at index:Int) -> HeadlineViewModel {
        return self.headlines[index]
    }
    
}

class HeadlineViewModel {
    
    var title :String!
    var description :String!
    
    init(headline :Headline) {
        self.title = headline.title
        self.description = headline.description
    }
}
