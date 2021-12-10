//
//  CDProduct+CoreDataProperties.swift
//  HealthKit
//
//  Created by admin on 12/10/21.
//
//

import Foundation
import CoreData


extension CDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var productName: String?
    @NSManaged public var productImage: String?
    @NSManaged public var sugarContent: NSDecimalNumber?
    @NSManaged public var sodium: NSDecimalNumber?
    @NSManaged public var productDescription: String?
    @NSManaged public var fatContent: NSDecimalNumber?
    @NSManaged public var startingAge: Int64
    @NSManaged public var endingAge: Int64
    @NSManaged public var allergenInformation1: String?
    @NSManaged public var allergenInformation2: String?
    @NSManaged public var productPrice: Int64
    @NSManaged public var brand: String?
    @NSManaged public var energy: Int64
    @NSManaged public var addedFlavour: String?
    
    func convertToProduct() -> Product
    {
        return Product(productName: self.productName,
                       
                       productImage: self.productImage,
                       brand: self.brand,
                       addedFlavour: self.addedFlavour, allergenInformation1: self.allergenInformation1, allergenInformation2: self.allergenInformation2, sugarContent: self.sugarContent, sodium: self.sodium, fatContent: self.fatContent, startingAge: self.startingAge, endingAge: self.endingAge,
                           energy: self.energy,productPrice: self.productPrice, productDescription: self.productDescription, id: self.id!)
        
    }

}

extension CDProduct : Identifiable {

}
