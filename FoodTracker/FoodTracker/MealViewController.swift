//
//  ViewController.swift
//  FoodTracker
//
//  Created by Apple on 11/22/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import os.log


class MealViewController: UIViewController{

   
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageFood: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControll!
    
     @IBOutlet weak var saveButtonItem: UIBarButtonItem!
    
     var meal: Meal?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        updateSaveButtonSate()
        
        
        if let meal = meal {
            navigationItem.title = meal.name
            textField.text = meal.name
            imageFood.image = meal.photo
            ratingControl.rating = meal.rating
        }
    }

    
    //mark: navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButtonItem else {
              os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
              return
        }
        
        let name = textField.text ?? ""
        let photo = imageFood.image
        let rating = ratingControl.rating
        
        meal = Meal(name: name, photo: photo, rating: rating)
    }
  
    
    @IBAction func onClickImage(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder() // hide keyboard
        
        //uiimagepicker controller is a viewcontroller that let user pick media from their photo library
         let imagePicker = UIImagePickerController()
        
        let actionSheet = UIAlertController(title: "", message: "Library / Camera", preferredStyle: .actionSheet)
        let libaryAction = UIAlertAction(title: "Library", style: .default) { (_) in
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        let cameraaction = UIAlertAction(title: "Camera", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                 imagePicker.sourceType = .camera
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                let uialert =  UIAlertController(title: "Error", message: "Camera is not supported", preferredStyle: .alert)
                uialert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(uialert, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(libaryAction)
        actionSheet.addAction(cameraaction)
        present(actionSheet, animated: true, completion: nil)
        
        //make sure viewcontroller notified when pick image
        
    }
    
    
    //mark priavte method
    
    private func updateSaveButtonSate() {
        //disable the save button if textFieald is empty
        
        let text = textField.text ?? ""
        saveButtonItem.isEnabled = !text.isEmpty
    }

    @IBAction func canCelACtion(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        let isInpresentingadMode = presentingViewController is UINavigationController
        if isInpresentingadMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}

// mark: text field delegate
extension MealViewController: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
      func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonSate()
        navigationItem.title = textField.text
      }
}

// mark imagepicker controller

extension MealViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("ecpect a dictionary containing an image but was not provide the following : \(info)")
        }
        //image slected assign it to image display
        imageFood.image = selectedImage
        //dismis vc
        dismiss(animated: true, completion: nil)
    }
}
