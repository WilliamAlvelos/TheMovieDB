//
//  CrewCollectionViewCell.swift
//  FastShop
//
//  Created by William Alvelos on 22/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {
    @IBOutlet var crewImageView: UIImageView!
    @IBOutlet var crewNameLabel: UILabel!
    @IBOutlet var crewOfficeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(crew: Crew){
        
        self.crewImageView.image = nil
        
        APIManager.downloadImage(url: "https://image.tmdb.org/t/p/w500" + (crew.profile_path ?? "")) { (result) in
            if let image = result as? UIImage {
                self.crewImageView.image = image
            } else {
                self.crewImageView.image = #imageLiteral(resourceName: "tmdbplaceholder")
            }
        }
        
        self.crewNameLabel.text = crew.name
        self.crewOfficeLabel.text = crew.job
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        crewImageView.af_cancelImageRequest()
        crewImageView.layer.removeAllAnimations()
        crewImageView.image = nil
    }
}
