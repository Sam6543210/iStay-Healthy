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
    func getAll() -> [Allergy]?
    func update(allergy : Allergy) -> Bool
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
    func getAll() -> [Allergy]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDAllergy.self)
        var allergies:[Allergy] = []
        result?.forEach({ (cdAllergy) in
            allergies.append(cdAllergy.convertToAllergy())
        })
        return allergies
    }
    func update(allergy : Allergy) -> Bool{
        let cdAllergy = getCDAllergy(byIdentifier: allergy.allergyId)
        guard cdAllergy != nil else{return false}
        //cdAllergy?.allergyName = allergy.allergyName
        cdAllergy?.allergyStatus = allergy.allergyStatus
        PersistentStorage.shared.saveContext()
        return true
    }
    private func getCDAllergy(byIdentifier id : UUID) -> CDAllergy?
    {
        let fetchRequest = NSFetchRequest<CDAllergy>(entityName: "CDAllergy")
        let predicate = NSPredicate(format: "allergyId==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do{
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else{return nil}
            return result
        }
        catch let error{
            debugPrint(error)
            return nil
        }
        //return nil
    }
    
}
