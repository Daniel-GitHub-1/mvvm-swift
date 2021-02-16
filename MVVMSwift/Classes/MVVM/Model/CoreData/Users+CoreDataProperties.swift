//
//  Users+CoreDataProperties.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/15.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var device: [String]?
    @NSManaged public var email: String?
    @NSManaged public var hp: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?

}
