//
//  ViewController.swift
//  LightMigration
//
//  Created by Sushant on 12/07/18.
//  Copyright © 2018 Striker. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var infoTableView: UITableView!
    var teacherInfo: [Teacher]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStudentInfo()
    }
    
    func getStudentInfo() {
        let managedContext = Migration.shared().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Teacher")
        if  let resultData = try? managedContext.fetch(fetchRequest) as? [Teacher] {
            self.teacherInfo = resultData
            self.infoTableView.reloadData()
        }else {
            print("No result Found")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacherInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? StudentInfoCell , let teacherInfo = self.teacherInfo?[indexPath.row] {
            cell.teacher = teacherInfo
            return cell
        }
        return StudentInfoCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

