//
//  ProductDataRepository.swift
//  HealthKit
//
//  Created by admin on 12/8/21.
//

import Foundation
import CoreData

protocol ProductRepository
{
    func create(product:Product)
   // func getAll() -> [Product]?
}

struct ProductDataRepository: ProductRepository
{
    func create(product:Product)
    {
        /*
         let cdProduct =  CDProduct(context:PersistentStorage.shared.context)
         
         cdProduct.productName = product.productName
         cdProduct.productImage = product.productImage
         cdProduct.productDescription=
         product.productDescription
         cdProduct.productPrice = product.productPrice
         cdProduct.sugarContent = product.sugarContent
         cdProduct.saltContent = product.saltContent
         cdProduct.ingrediant1 = product.ingrediant1
         cdProduct.ingrediant2 = product.ingrediant2
         cdProduct.bmi = product.bmi
         cdProduct.startingAge = product.startingAge
         cdProduct.endingAge = product.endingAge
         cdProduct.id = product.id
        
         Persistent Storage.shared.saveContext()
    */
    }
   
}
