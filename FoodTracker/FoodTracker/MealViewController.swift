//
//  ViewController.swift
//  FoodTracker
//
//  Created by Apple on 11/22/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import RealmSwift


class MealViewController: UIViewController{

    let realm = try! Realm()
   
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageFood: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControll!
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            if textView.text.isEmpty {
                textView.text = "Add description here"
                textView.textColor = .gray
            }
        }
    }
     @IBOutlet weak var saveButtonItem: UIBarButtonItem!
    
     var meal: Food?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        updateSaveButtonSate()
        
        
        if let meal = meal {
            navigationItem.title = meal.name
            textField.text = meal.name
            imageFood.image = UIImage(data: meal.photo)
            ratingControl.rating = meal.rating
            textView.text = meal.descrip
        }
        
       adjustUITextViewHeight(arg: textView)
        
    
    }
    
 func adjustUITextViewHeight(arg : UITextView)
 {
    // arg.translatesAutoresizingMaskIntoConstraints = true
     arg.sizeToFit()
     arg.isScrollEnabled = false
 }

    
    //mark: navigation
 
    @IBAction func onClickAdd(_ sender: Any) {
        let name = textField.text ?? ""
        guard let photo = imageFood.image else { return }
        let rating = ratingControl.rating
        let description = textView.text ?? ""
        let addfood = Food(name: name, photo: data(image: photo), rating: rating, descrip: description)
        if meal != nil {
            try! realm.write {
                realm.add(addfood, update: .modified)
            }
        } else {
            
            try! realm.write {
                realm.add(addfood)
            }
        }
        dismiss(animated: true, completion: nil)
    }
       
    
    
    func data(image: UIImage) -> Data {
        var imageData = image.pngData()
    // Resize the image if it exceeds the 2MB API limit
     if (imageData?.count)! > 2097152 {
        //let oldSize = image.size
        //let newSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
//        (width: 800, height: oldSize.height / oldSize.width *
//        800)
        guard let newImage = image.resize(withWidth: 800) else { return Data()}
        imageData = newImage.jpegData(compressionQuality: 0.7)
       }
       return imageData!
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


extension UIImage {

    func resize(withWidth newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
