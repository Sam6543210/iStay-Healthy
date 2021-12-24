//
//  CDAllergy+CoreDataProperties.swift
//  iStay Healthy
//
//  Created by admin on 12/23/21.
//
//

import Foundation
import CoreData


extension CDAllergy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAllergy> {
        return NSFetchRequest<CDAllergy>(entityName: "CDAllergy")
    }

    @NSManaged public var allergyName: String?
    @NSManaged public var allergyStatus: String?
    @NSManaged public var allergyId: UUID?

}

extension CDAllergy : Identifiable {

}
