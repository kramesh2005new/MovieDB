//
//  MovieCreditsCollectionViewCell.swift
//  MovieApp
//
//  Created by Ramesh on 05/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class MovieCreditsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgCrew: UIImageView!
    @IBOutlet var labName: UILabel!
    
    override func prepareForReuse() {
        
        imgCrew.contentMode = .scaleAspectFit
        imgCrew.image = UIImage.gifImageWithName("loader")
        labName.text = ""
    }
    
}
