//
//  NSAttributedString.swift
//  themoviedb
//
//  Created by William Alvelos on 23/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func normalWhite(_ text:String) -> NSMutableAttributedString {
        let attrs = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        self.append(NSMutableAttributedString(string:"\(text)", attributes:attrs))
        return self
    }
    
    func normalGray(_ text:String)->NSMutableAttributedString {
        let attrs = [NSAttributedStringKey.foregroundColor : UIColor.gray]

        self.append(NSMutableAttributedString(string:"\(text)", attributes:attrs))
        return self
    }
    
}
