//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Apple on 11/22/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    
    
    //meal class test
    func testMealInitialSuccess(){
        //zero rating
        let zeroRatingmeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingmeal)
        
        //highgest positiveRating
        let positiveRating = Meal.init(name: "positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRating)
    }
    
    //confirm that meal initialize return nil when passed negative rating and an empty name
     
    func testMealinitializedfail() {
        //negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        //emptyString
        
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        
        let largeRatingMeal = Meal.init(name: "LargRating", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
}
