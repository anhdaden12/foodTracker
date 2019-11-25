//
//  Meal.swift
//  FoodTracker
//
//  Created by Apple on 11/22/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class Meal {
    var name: String
    var photo: UIImage?
    var rating: Int
    var description: String
    init?(name: String, photo: UIImage?, rating: Int, description: String) {
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
        self.description = description
    }
}

class Food: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var photo = Data()
    @objc dynamic var rating: Int = 0
    @objc dynamic var descrip: String = ""
    
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    convenience init(name: String, photo: Data, rating: Int, descrip: String) {
        self.init()
        self.name = name
        self.photo = photo
        self.rating = rating
        self.descrip = descrip
    }
    
    //    init(name: String, photo: UIImage?, rating: Int, descrip: String) {
    //        self.name = name
    //        self.photo = photo
    //        self.rating = rating
    //        self.descrip = descrip
    //    }
    
    //    required init(coder:  NSCoder) {
    //        super.init(value: coder)
    //    }
}

