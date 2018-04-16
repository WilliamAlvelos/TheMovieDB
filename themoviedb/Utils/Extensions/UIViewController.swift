//
//  UIViewController.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configTitle(title: String) {
        self.title = title
    }
    
    func hideBackButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
