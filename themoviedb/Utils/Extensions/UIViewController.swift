//
//  UIViewController.swift
//  FastShop
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configTitle(title: String) {
        self.title = title
//        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 17)!, NSForegroundColorAttributeName: Colors.quinary]
//        self.navigationController?.navigationBar.barTintColor = Colors.primary
    }
    
    func hideBackButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
