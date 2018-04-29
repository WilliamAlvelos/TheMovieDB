//
//  UIImageView+Alamo.swift
//  themoviedb
//
//  Created by William Alvelos on 29/04/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation
import AlamofireImage

// MARK: - Download Image
extension UIImageView {
    
    public func downloadImage(fromStringURL stringURL: String) {
        
        guard let url = URL(string: stringURL) else { return }
        
        self.af_setImage(withURL: url,
                         placeholderImage: #imageLiteral(resourceName: "tmdbplaceholder"),
                         filter: nil,
                         progress: nil,
                         progressQueue: DispatchQueue.main,
                         imageTransition: .crossDissolve(0.2),
                         runImageTransitionIfCached: false,
                         completion: nil)
    }
}
