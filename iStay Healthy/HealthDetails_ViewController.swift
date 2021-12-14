//
//  HealthDetails_ViewController.swift
//  iStay Healthy
//
//  Created by admin on 12/14/21.
//

import UIKit
import HealthKit

class HealthDetails_ViewController: UIViewController {

    @IBAction func authorizeHealthDetails(_ sender: Any) {
        self.authorizeHealthKit()
    }
    @IBOutlet weak var authorizeHealthDetails: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func authorizeHealthKit(){
        
        let healthkitTypesToRead : Set<HKObjectType> = [
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
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
