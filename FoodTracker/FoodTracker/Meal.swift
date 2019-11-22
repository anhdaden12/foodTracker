//
//  Meal.swift
//  FoodTracker
//
//  Created by Apple on 11/22/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit


class Meal {
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init?(name: String, photo: UIImage?, rating: Int) {
        //init will be fail if rating tieu cuc
//        if name.isEmpty || rating < 0 {
//            return nil
//        }
        //name khong duoc rong
        guard !name.isEmpty else { return nil}
        //rating phai tu 0 den 5
        guard (rating >= 0 && rating <= 5) else { return nil}
        //khoi tao cac bien luu tru
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
