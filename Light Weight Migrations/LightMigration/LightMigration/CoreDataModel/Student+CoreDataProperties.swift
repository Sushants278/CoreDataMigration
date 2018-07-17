//
//  Student+CoreDataProperties.swift
//  LightMigration
//
//  Created by Sushant on 12/07/18.
//  Copyright © 2018 Striker. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var rollNo: Int32
    @NSManaged public var address: String?

}
