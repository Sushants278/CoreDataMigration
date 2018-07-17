//
//  StudentInfoCell.swift
//  LightMigration
//
//  Created by Sushant on 12/07/18.
//  Copyright © 2018 Striker. All rights reserved.
//

import UIKit

class StudentInfoCell: UITableViewCell {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var address: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    var student : Student? {
        didSet {
            guard let studentInfo = student else { return }
                self.updateCell(student: studentInfo)
        }
    }
    
    func updateCell(student: Student) {
        self.firstName.text = student.firstName
        self.lastName.text = student.lastName
        self.address.text = student.address
    }
}
