//
//  DayContentItem+CoreDataProperties.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/18.
//
//

import Foundation
import CoreData

extension DayContentItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayContentItem> {
        return NSFetchRequest<DayContentItem>(entityName: "DayContentItem")
    }

    @NSManaged public var dateString: String?
    @NSManaged public var monthString: String?
    @NSManaged public var date: Date?
    @NSManaged public var detail: String?
    @NSManaged public var done: Bool
    @NSManaged public var stats: Int16

}

extension DayContentItem : Identifiable {

}
