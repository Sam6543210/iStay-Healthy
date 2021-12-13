//
//  Product.swift
//  HealthKit
//
//  Created by admin on 12/3/21.
//

import Foundation
struct Product
{
    var productName, productImage, brand, addedFlavour, allergenInformation1, allergenInformation2: String?
    var sugarContent, sodium, fatContent: NSDecimalNumber?
    var startingAge, endingAge, energy, productPrice: Int64
    var productDescription:
        String?
    let id: UUID
}
