//
//  Teacher+CoreDataProperties.swift
//  LightMigration
//
//  Created by sushant on 7/16/18.
//  Copyright © 2018 Striker. All rights reserved.
//
//

import Foundation
import CoreData


extension Teacher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teacher> {
        return NSFetchRequest<Teacher>(entityName: "Teacher")
    }

    @NSManaged public var address: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var teacherID: Int32

}
