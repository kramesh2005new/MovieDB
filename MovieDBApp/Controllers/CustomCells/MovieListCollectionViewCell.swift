//
//  MovieListCollectionViewCell.swift
//  MovieApp
//
//  Created by Ramesh on 04/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit
import Cosmos

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgMoviePoster: UIImageView!
    @IBOutlet var labMovieTitle: UILabel!
    @IBOutlet var labMovieRating: UILabel!
    @IBOutlet var ratingView: CosmosView!
    
    var movie: Movie?
    var selectedIndex: Int = 0
    
    override func prepareForReuse() {
        
        imgMoviePoster.contentMode = .scaleAspectFit
        imgMoviePoster.image = UIImage.gifImageWithName("loader")
        labMovieTitle.text = ""
        labMovieRating.text = ""
        ratingView.rating = 0.0
        selectedIndex = 0
    }
    
    
    
}
