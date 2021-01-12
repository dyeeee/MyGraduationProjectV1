//
//  WordItem+CoreDataProperties.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/10.
//
//

import Foundation
import CoreData


extension WordItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordItem> {
        return NSFetchRequest<WordItem>(entityName: "WordItem")
    }

    @NSManaged public var wordID: UUID?
    @NSManaged public var wordContent: String?
    @NSManaged public var phonetic_EN: String?
    @NSManaged public var phonetic_US: String?
    @NSManaged public var definition: String?
    @NSManaged public var translation: String?
    @NSManaged public var wordExchanges: String?
    @NSManaged public var wordTags: String?
    @NSManaged public var bncLevel: Int16
    @NSManaged public var frqLevel: Int16
    @NSManaged public var collinsLevel: Int16
    @NSManaged public var oxfordLevel: Int16
    @NSManaged public var exampleSentences: String?
    @NSManaged public var wordNote: String?
    @NSManaged public var otherAttr2: String?
    @NSManaged public var otherAttr3: Int16
    @NSManaged public var starLevel: Int16

}

extension WordItem : Identifiable {

}
