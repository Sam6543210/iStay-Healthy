//
//  MyCart.swift
//  iStay Healthy
//
//  Created by admin on 12/22/21.
//

import Foundation
class MyCart
{
    var productName:String
    var productImage,brand,addedFlavour,allergenInformation1,allergenInformation2:String
    var sugarContent, sodium , fatContent: NSDecimalNumber
    var price,startingAge,endingAge, energy:Int64
    var id:UUID
    init(pName:String,pImage:String,pBrand:String,pAddedFlavour:String,pAllergenInformation1:String,pAllergenInformation2:String,pSugarContent:NSDecimalNumber,pSodium:NSDecimalNumber,pFatContent:NSDecimalNumber,pPrice:Int64,pStartingAge:Int64,pEndingAge:Int64,pEnergy:Int64,id1:UUID)
    {
        productImage = pImage
        productName = pName
        brand = pBrand
        addedFlavour = pAddedFlavour
        allergenInformation1 = pAllergenInformation1
        allergenInformation2 = pAllergenInformation2
        sugarContent = pSugarContent
        sodium = pSodium
        fatContent = pFatContent
        
        price = pPrice
        startingAge = pStartingAge
        endingAge = pEndingAge
        energy = pEnergy
        
        id = id1
    }
}
