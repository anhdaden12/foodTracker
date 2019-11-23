//
//  RatingControll.swift
//  FoodTracker
//
//  Created by Apple on 11/22/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

@IBDesignable
class RatingControll: UIStackView {
    
    
    private var ratingButtons = [UIButton]()
       
    var rating: Int = 0 {
        didSet {
            updateButtonSelectedSate()
        }
    }

    //mark properties
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    
    //private method
    
    
    private func setupButtons() {
        
        
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        
        //mark: load button Image
            let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let hightlightStar = UIImage(named: "hightlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        
        for index in 0..<starCount {
            let button = UIButton()
            button.backgroundColor = .white
            
            
            //acessbility label
            
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            //set button image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(hightlightStar, for: .highlighted)
            button.setImage(hightlightStar, for: [.highlighted, .selected])
            //constraint
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            
            //add action
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            //addsubview
            
            addArrangedSubview(button)
            
            //add newbutton to button array
            
            ratingButtons.append(button)
        }
        updateButtonSelectedSate()
    }
    
    //mark: button action
    
    @objc func ratingButtonTapped(button: UIButton) {
       
        guard let index = ratingButtons.index(of: button) else {
            fatalError(" the button : \(button) is not in the rating button array: \(ratingButtons)")
        }
        
        //caculate raing button
       let selectedRating = index + 1
        
        
        if selectedRating == rating {
            //neu selected star bang voi current rating thi rating tro ve bang 0
            rating = 0
        } else {
            rating = selectedRating
        }
        
    }
    
    
    private func updateButtonSelectedSate() {
        
      //  let hingString: String?
        
        for (index, button) in ratingButtons.enumerated() {
            // neu index cua button nho hon rating thi button nen duoc chon
            button.isSelected = index < rating
            
            
            //set hintString for currently selected star
            
            let hinstring: String?
            
            if rating == index + 1{
                hinstring = "tap to reset the rating to zero"
            } else {
                hinstring = nil
            }
            
            //caculate the value string
            
            let valuestring: String
            switch rating {
            case 0:
                valuestring = "no rating set"
            case 1:
                valuestring = "1 star set"
            default:
                valuestring = "\(rating) star set"
            }
            
            //assign hinstring and valuestring
            
            button.accessibilityHint = hinstring
            button.accessibilityValue = valuestring
        }
    }
}


