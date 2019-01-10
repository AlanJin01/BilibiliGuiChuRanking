//
//  User+CoreDataProperties.swift
//  BilibiliGuiChuRanking2
//
//  Created by J K on 2019/1/9.
//  Copyright © 2019 Kims. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var aid: String?
    @NSManaged public var author: String?
    @NSManaged public var play: Double
    @NSManaged public var videoImage: String?
    @NSManaged public var videoTitle: String?

}
