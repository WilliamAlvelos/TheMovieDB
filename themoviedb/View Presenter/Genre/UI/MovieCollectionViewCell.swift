//
//  MovieCollectionViewCell.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
    //MARK:- IBOutlets
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }
    
    
    func configureCell(with URLString: String) {
        movieImageView.af_setImage(
            withURL: URL(string: URLString)!,
            imageTransition: .curlUp(0.5)
        )
    
        activityIndicator.stopAnimating()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movieImageView.af_cancelImageRequest()
        movieImageView.layer.removeAllAnimations()
        movieImageView.image = nil
    }
}
