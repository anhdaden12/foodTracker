//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Apple on 11/22/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadSimpleMeals()
    }

    
    private func loadSimpleMeals() {
        let photo1 = UIImage(named: "1")
        let photo2 = UIImage(named: "2")
        let photo3 = UIImage(named: "3")
        let photo4 = UIImage(named: "4")
        let photo5 = UIImage(named: "5")
        
        
        guard let meal1 = Meal(name: "Capresalad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        guard let meal2 = Meal(name: "Guaguu beef", photo: photo2, rating: 3) else{
            fatalError("Unable to instantiate meal2")
        }
        guard let meal3 = Meal(name: "Potaotose", photo: photo3, rating: 5) else {
            fatalError("Unable to instantiate meal3")
        }
        guard let meal4 = Meal(name: "Pho VN", photo: photo4, rating: 4) else {
            fatalError("Unable to instantiate meal4")
        }
        guard let meal5 = Meal(name: "Young Buffalow", photo: photo5, rating: 3) else {
                fatalError("Unable to instantiate meal5")
        }
        
        meals += [meal1, meal2,meal3,meal4, meal5]
        
        
    }
    
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealTableViewCell
        cell.imageFood.image = meals[indexPath.row].photo
        cell.foodLabelName.text = meals[indexPath.row].name
        cell.ratingControl.rating = meals[indexPath.row].rating
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        addButton.isEnabled = !isEditing
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isEditing ? false : true
    }
    
    
    //mark; navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "addItem" :
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "showDetail" :
            guard let mealVC = segue.destination as? MealViewController else {
                fatalError("unecpected segue destination: \(segue.destination)")
            }
            if let index = tableView.indexPathForSelectedRow {
                mealVC.meal = meals[index.row]
            }
        default:
            break
        }
    }
    
    
    
//mark : action
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        if let soureVC = unwindSegue.source as? MealViewController, let meal = soureVC.meal {
            
            if let indexPat = tableView.indexPathForSelectedRow {
                meals[indexPat.row] = meal
            } else {
                let newindexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newindexPath], with: .automatic)
            }
            
            tableView.reloadData()
        } 
    }
   

}
