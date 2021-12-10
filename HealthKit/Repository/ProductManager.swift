//
//  ProductManager.swift
//  HealthKit
//
//  Created by admin on 12/8/21.
//

import Foundation

struct ProductManager
{
    private let productData = ProductDataRepository()
    
    func createProduct(product:Product)
    {
        productData.create(product: product)
    }
    func fetchProduct() -> [Product]?
    {
        return productData.getAll()
    }
    func deleteProduct(id:UUID) -> Bool
    {
        return productData.delete(id:id)
    }
}
