//
//  AllergyDataRepository.swift
//  iStay Healthy
//
//  Created by admin on 12/23/21.
//

import Foundation
import CoreData
protocol AllergyRepository {
    func create(allergy: Allergy)
    //func getAll() -> [Allergy]?
}
struct AllergyDataRepository: AllergyRepository
{
    func create(allergy: Allergy) {
        let cdAllergy = CDAllergy(context: PersistentStorage.shared.context)
        cdAllergy.allergyName = allergy.allergyName
        cdAllergy.allergyStatus = allergy.allergyStatus
        cdAllergy.allergyId = allergy.allergyId
        PersistentStorage.shared.saveContext()
   
    
    }
}
