//
//  AddInfoViewController.swift
//  LightMigration
//
//  Created by Sushant on 12/07/18.
//  Copyright © 2018 Striker. All rights reserved.
//

import UIKit
import CoreData

class AddInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var firstNameTxtField: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let managedContext = Migration.shared().persistentContainer.viewContext
        let newItem =  Teacher(entity: Teacher.entity(), insertInto: managedContext)
        newItem.firstName = firstNameTxtField.text ?? "Default Text"
        newItem.lastName = lastNameTxtField.text ?? "Default Text"
        newItem.address = addressTxtField.text ?? ""
        newItem.teacherID = 0
        
        do {
            try managedContext.save()
            self.firstNameTxtField.text = ""
            self.lastNameTxtField.text = ""
            self.addressTxtField.text = ""
        } catch {
            print("Not able to save the data")
        }
    }
    
    
}
