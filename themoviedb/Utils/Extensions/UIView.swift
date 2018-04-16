//
//  UIView.swift
//  themoviedb
//
//  Created by William Alvelos on 22/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func cornerRadius(){
        self.layoutIfNeeded()
        self.layer.cornerRadius = 1
        self.layer.masksToBounds = true
    }
    
    func border(color: CGColor){
        self.layer.borderWidth = 1
        self.layer.borderColor = color
    }
    
}

