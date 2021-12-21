//
//  editHealthDetails.swift
//  iStay Healthy
//
//  Created by admin on 12/21/21.
//

import UIKit
import  HealthKit

class editHealthDetails: UIViewController {

    @IBOutlet weak var bloodPressureField: UITextField!
    @IBOutlet weak var saveHealthData: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func saveHealthData(_ sender: Any) {
        writeToKit()
        bloodPressureField.text = ""
        
    }
    func writeToKit(){
        let today = NSDate()
        if (bloodPressureField.text != "" ){
            let bloodPressure = bloodPressureField.text
            if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic){
                let quantity = HKQuantity(unit: HKUnit.millimeterOfMercury(), doubleValue: Double(bloodPressure!)!)
                let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
                healthKitStore.save(sample, withCompletion: {(success, error) in
                    print("Saved \(success), error \(String(describing: error))")
                })
            }
        }
        
    }

}
