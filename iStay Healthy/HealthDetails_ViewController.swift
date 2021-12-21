//
//  HealthDetails_ViewController.swift
//  iStay Healthy
//
//  Created by admin on 12/14/21.
//

import UIKit
import HealthKit

class HealthDetails_ViewController: UIViewController {

    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBAction func authorizeHealthDetails(_ sender: Any) {
        self.authorizeHealthKit()
    }
    @IBOutlet weak var authorizeHealthDetails: UIButton!
   
    @IBOutlet weak var genderLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDateOfBirth()

        // Do any additional setup after loading the view.
    }
    func readDateOfBirth() -> DateComponents?
    {
        var birthDay: DateComponents?
        
        do {
             birthDay = try healthKitStore.dateOfBirthComponents()
            
        }
        catch { }
        return birthDay
    }
    func displayDateOfBirth()
    {
        let birthDay = readDateOfBirth()
       
        
        dateOfBirthLabel.text = String("\(birthDay!.day!)-\(birthDay!.month!)-\(birthDay!.year!)")
        
    }
    
    func authorizeHealthKit(){
        
        let healthkitTypesToRead : Set<HKObjectType> = [
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!,
            
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium)!
        ]
        let healthKitTypesToWrite : Set<HKSampleType> = [
        ]
        
        if !HKHealthStore.isHealthDataAvailable(){
            print("ERROR OCCURRED")
            return
        }
        
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthkitTypesToRead, completion: { (success, error) -> Void in
            print("Read Write Authorization succeeded!")
        })
    }

}
