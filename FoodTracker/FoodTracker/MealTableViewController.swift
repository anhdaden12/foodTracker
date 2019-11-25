//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Apple on 11/22/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import os.log
import RealmSwift

class MealTableViewController: UITableViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!

    let realm = try! Realm()
    var dataFood: Results<Food> {
        get {
            return realm.objects(Food.self)
        }
    }

   // var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    
    private func loadSimpleMeals() {
        guard let photo1 = UIImage(named: "1") else { return }
        guard let photo2 = UIImage(named: "2") else { return }
        guard let photo3 = UIImage(named: "3") else { return }
        guard let photo4 = UIImage(named: "4") else { return }
        guard let photo5 = UIImage(named: "5") else { return }


        let fake1 = Food(name: "Salad", photo: photo1.pngData()!, rating: 5, descrip: "A food that has been introduced to bacteria, yeast, or another microorganism to produce organic acids, alcohols, or gases. May result in a pungent, biting flavor.")

        let fake2 = Food(name: "Suhao", photo: photo2.pngData()!, rating: 4, descrip: "A food that was dipped in butter and coated with spices before being cooked in a hot pan, resulting in a blackened appearance.")

        let fake3 = Food(name: "Bapcai", photo: photo3.pngData()!, rating: 2, descrip: "A food cooked with intense radiant heat, as in an oven or on a grill. Often results in a darkened appearance and crispy texture.")

        let fake4 = Food(name: "HeoQUay", photo: photo4.pngData()!, rating: 3, descrip: "A food that has been introduced to bacteria, yeast, or another microorganism to produce organic acids, alcohols, or gases. May result in a pungent, biting flavor.")

        let fake5 = Food(name: "GaRan", photo: photo5.pngData()!, rating: 4, descrip: "A food that becomes moistened by having a flavorful coating dripped or brushed onto its surface. May result in a glossy appearance and thin, crisp outer layer.")

        let fake6 = Food(name: "Hotdog", photo: photo1.pngData()!, rating: 5, descrip: "Food that has been cooked with dry heat in an oven or over a fire. Often results in a browned exterior and crisp coating.")

        let dataA: [Food] = [fake1, fake2, fake3, fake4, fake5,fake6]


            try! realm.write {
                for item in dataA {
                    realm.add(item)
                }
            }


    }
    
    
    
    @IBAction func fakeData(_ sender: Any) {
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                self.loadSimpleMeals()
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func deleteAll(_ sender: Any) {
        try! realm.write {
            realm.deleteAll()
        }
        tableView.reloadData()
    }
    
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFood.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealTableViewCell
        let food = dataFood[indexPath.row]
        cell.imageFood.image = UIImage(data: food.photo)
        cell.foodLabelName.text = food.name
        cell.ratingControl.rating = food.rating
        cell.foodDescription.text = food.descrip
        
        cell.imageFood.layer.cornerRadius = 64.5
        cell.imageFood.layer.masksToBounds = true
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           try! realm.write {
            realm.delete(dataFood[indexPath.row])
            }
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
                mealVC.meal = dataFood[index.row]
            }
        default:
            break
        }
    }
    
    
    
//mark : action
    
//    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
//        if let soureVC = unwindSegue.source as? MealViewController, let meal = soureVC.meal {
//
//            if let _ = tableView.indexPathForSelectedRow {
//                //dataFood[indexPat.row] = meal
//                try! realm.write {
//                    realm.add(meal, update: .modified)
//                }
//            } else {
//              //  let newindexPath = IndexPath(row: meals.count, section: 0)
//                //dataFood.insert(meal, at: 0)
//                try! realm.write {
//                    realm.add(meal)
//                }
//               // tableView.insertRows(at: [newindexPath], with: .automatic)
//            }
//
//            tableView.reloadData()
//        }
//    }
   

}
