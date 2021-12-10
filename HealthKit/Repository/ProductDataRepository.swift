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
    func getAll() -> [Product]?
    func delete(id:UUID) ->Bool
}

struct ProductDataRepository: ProductRepository
{
    
    
    func create(product:Product)
    {
        
         let cdProduct =  CDProduct(context:PersistentStorage.shared.context)
         
         cdProduct.productName = product.productName
         cdProduct.productImage = product.productImage
         cdProduct.productDescription =
         product.productDescription
         cdProduct.productPrice = product.productPrice
         cdProduct.sugarContent = product.sugarContent
         cdProduct.sodium = product.sodium
         cdProduct.allergenInformation1 = product.allergenInformation1
         cdProduct.allergenInformation2 = product.allergenInformation2
         cdProduct.fatContent = product.fatContent
         cdProduct.startingAge = product.startingAge
         cdProduct.endingAge = product.endingAge
         cdProduct.energy = product.energy
         cdProduct.brand = product.brand
         cdProduct.addedFlavour = product.addedFlavour
         cdProduct.id = product.id
        
        PersistentStorage.shared.saveContext()
    
    }
   func getAll() -> [Product]?
   {
    let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDProduct.self)
    var products:[Product] = []
    result?.forEach( { (cdShop) in
        products.append(cdShop.convertToProduct())
    })
    return products
   }
    func delete(id: UUID) ->Bool{
       let cdProduct = getCDProduct(id:id)
        guard cdProduct != nil else
        {
            return false
        }
        PersistentStorage.shared.context.delete(cdProduct!)
        PersistentStorage.shared.saveContext()
 
        return true
    }
   private func getCDProduct(id:UUID) ->CDProduct?
    {
        let fetchRequest = NSFetchRequest<CDProduct>(entityName: "CDProduct")
        let predicate = NSPredicate(format:"id==%@",id as CVarArg)
     fetchRequest.predicate = predicate
     do
     {
     let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
     guard result != nil else
     {
        
     return nil
     }
        return result
     }
     catch let error
     {
     debugPrint(error)
     }
     return nil
    }
}
