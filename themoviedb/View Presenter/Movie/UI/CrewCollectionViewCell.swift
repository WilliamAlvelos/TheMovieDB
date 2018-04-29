//
//  CrewCollectionViewCell.swift
//  themoviedb
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
        
        self.crewImageView.downloadImage(fromStringURL: "https://image.tmdb.org/t/p/w500" + (crew.profile_path ?? ""))
        
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
