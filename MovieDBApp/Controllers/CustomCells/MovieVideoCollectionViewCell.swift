//
//  MovieVideoCollectionViewCell.swift
//  MovieApp
//
//  Created by Ramesh on 05/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class MovieVideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var youtubeCom: YoutubeComponent!
    @IBOutlet var labName: UILabel!
    
    override func prepareForReuse() {
        
        labName.text = ""
    }
    
}
