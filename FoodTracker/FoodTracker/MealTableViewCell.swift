//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Apple on 11/22/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var foodLabelName: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
    @IBOutlet weak var ratingControl: RatingControll!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
