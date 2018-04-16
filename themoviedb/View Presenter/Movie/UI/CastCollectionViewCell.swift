//
//  CastCollectionViewCell.swift
//  themoviedb
//
//  Created by William Alvelos on 23/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var castProfileImageView: UIImageView!
    @IBOutlet var castNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius()
        self.castProfileImageView.image = #imageLiteral(resourceName: "tmdbplaceholder")
        self.border(color: UIColor.tmdb.cgColor)
    }
    
    func configCell(cast: Cast){
        
        self.castProfileImageView.image = nil
        
        APIManager.downloadImage(url: "https://image.tmdb.org/t/p/w500" + (cast.profile_path ?? "")) { (result) in
            if let image = result as? UIImage {
                self.castProfileImageView.image = image
            }else {
                self.castProfileImageView.image = #imageLiteral(resourceName: "tmdbplaceholder")
            }
        }
        
        self.castNameLabel.text = cast.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        castProfileImageView.af_cancelImageRequest()
        castProfileImageView.layer.removeAllAnimations()
        castProfileImageView.image = nil
    }
}
