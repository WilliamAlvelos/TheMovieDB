//
//  Alert.swift
//  FastShop
//
//  Created by William Alvelos on 23/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    static func show(error: Errors) -> UIAlertController {
        let alert = UIAlertController(title: "Ops..." , message: error.message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
}
