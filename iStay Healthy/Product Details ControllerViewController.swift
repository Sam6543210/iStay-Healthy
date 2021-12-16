//
//  Product Details ControllerViewController.swift
//  HealthKit
//
//  Created by admin on 12/6/21.
//

import UIKit
import HealthKit

let healthKitStore: HKHealthStore = HKHealthStore()

class Product_Details_ControllerViewController: UIViewController {

    @IBOutlet weak var heartRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayHealthData()
        // Do any additional setup after loading the view.
    }
    
    func readCharacteristicHealthData() -> (Int?){
        var age : Int?
        
        //read age
        do{
            let birthDay = try healthKitStore.dateOfBirthComponents()
            let calender = Calendar.current
            let currentYear = calender.component(.year, from: Date())
            age = currentYear - birthDay.year!
        }
        catch{}
        
        return (age)
    }
    func readSampleHealthData(for sampleType : HKSampleType, completion : @escaping (HKQuantitySample?, Error?) -> Swift.Void){
        
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        let sortDiscriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDiscriptor]){
            (query, samples, error) in
            DispatchQueue.main.async {
                guard let samples = samples,
                      let mostRecentSample = samples.first as? HKQuantitySample else{
                        completion(nil,error)
                        return
                }
                completion(mostRecentSample,nil)
            }
        }
        HKHealthStore().execute(sampleQuery)
    }
    
    func displayHealthData(){
        guard let heartRateSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else{
        print("Heart rate sample is no longer available in healthkit")
        return
        }
        readSampleHealthData(for: heartRateSampleType){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            
            self.heartRateLabel.text = String(sample.quantity.doubleValue(for: HKUnit(from: "count/min")))
        }
    }
    private func dislayAlert(for error : Error){
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
