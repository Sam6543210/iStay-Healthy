//
//  AllergyManager.swift
//  iStay Healthy
//
//  Created by admin on 12/23/21.
//

import Foundation

struct AllergyManager
{
    private let allergyData = AllergyDataRepository()
    
    func createAllergy(allergy:Allergy)
    {
        allergyData.create(allergy: allergy)
    }
    func fetchAllergy() -> [Allergy]?
    {
        return allergyData.getAll()
    }
    func updateAllergy(allergy : Allergy){
        let flag = allergyData.update(allergy: allergy)
    }
}
