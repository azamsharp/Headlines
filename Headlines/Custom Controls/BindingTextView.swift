//
//  BindingTextView.swift
//  Headlines
//
//  Created by Mohammad Azam on 11/22/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class BindingTextView : UITextView, UITextViewDelegate {
    
    var numberOfCharactersEntered :(Int,Int) -> () = { _,_  in }
    var limit :Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
    func bind(callback: @escaping (Int,Int) -> ()) -> BindingTextView {
        self.numberOfCharactersEntered = callback
        return self
    }
    
    func limit(to limit:Int) {
        self.limit = limit
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.numberOfCharactersEntered(self.text.count,self.limit)
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= self.limit 
    }
    
}
