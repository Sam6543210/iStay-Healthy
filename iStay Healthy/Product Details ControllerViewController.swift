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

    @IBOutlet weak var passedProductImge: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var ageGrpLabel: UILabel!
    @IBOutlet weak var productDescriptionText: UITextView!
    @IBOutlet weak var textHC: NSLayoutConstraint!
    @IBOutlet weak var productEnergyLabel: UILabel!
    @IBOutlet weak var productFatLabel: UILabel!
    @IBOutlet weak var productSodiumLabel: UILabel!
    @IBOutlet weak var productSugarLabel: UILabel!
    @IBOutlet weak var allergenLabel: UILabel!
    @IBOutlet weak var artificialFlavoursLabel: UILabel!
    
    @IBOutlet weak var sampleLabel: UILabel!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBAction func addToCartAction(_ sender: Any) {
    }
    
    var age:Int?
    var gender:String?
    var bloodPressure:Double = 0.0
        var weight,height,cholesterol,sugar,sodium:Double?
    
    var selectedProduct: Product? = nil
    let healthDetails = HealthDetails_ViewController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProductDetail()
        compareData()
        // Do any additional setup after loading the view.
    }
    private let manager = ProductManager()
    @IBAction func deleteTap(_ sender: Any) {
        if(manager.deleteProduct(id: selectedProduct!.id))
        {
            print("deleted")
        }
        else
        {
            print("Not deleted")
        }
    }
    func setUpProductDetail()
    {
        self.passedProductImge.image = UIImage(named:(selectedProduct?.productImage)!)
        self.productNameLabel.text = selectedProduct?.productName
        self.productNameLabel.frame = CGRect(x: 20, y: 350, width: self.productNameLabel.intrinsicContentSize.width, height: self.productNameLabel.intrinsicContentSize.height)
        self.productPriceLabel.text?.append("\(String(selectedProduct!.productPrice))")
        self.ageGrpLabel.text?.append("\(String(selectedProduct!.startingAge))-\(String(selectedProduct!.endingAge)))")
        self.ageGrpLabel.frame = CGRect(x: 200, y: 380, width: self.ageGrpLabel.intrinsicContentSize.width, height: self.ageGrpLabel.intrinsicContentSize.height)
        self.productDescriptionText.text.append("\(String((selectedProduct?.productDescription)!))")
        self.textHC.constant = self.productDescriptionText.contentSize.height
        self.productEnergyLabel.text = "\(String(describing: (selectedProduct?.energy)!))"
        self.productFatLabel.text = "\(String(describing: (selectedProduct?.fatContent)!))"
        self.productSugarLabel.text = "\(String(describing: (selectedProduct?.sugarContent)!))"
        self.productSodiumLabel.text = "\(String(describing: (selectedProduct?.sodium)!))"
        self.allergenLabel.text = "\(String(describing: (selectedProduct?.allergenInformation1)!)), \(String(describing: (selectedProduct?.allergenInformation2)!))"
        if(selectedProduct?.addedFlavour == "Yes"){
            self.artificialFlavoursLabel.text = "Contains artificial flavours"
        }
        else{
            self.artificialFlavoursLabel.text = "Does not contain artificial flavours"
        }
    }
    
    private func dislayAlert(for error : Error){
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func readSampleHealthData(for sampleType : HKSampleType, completion : @escaping (HKQuantitySample?, Error?) -> Swift.Void){
        
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        let sortDiscriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1
        
       /* let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDiscriptor]){
            (query, samples, error) in
            DispatchQueue.main.async{
                guard let samples = samples,
                      let mostRecentSample = samples.first as? HKQuantitySample else{
                          completion(nil,error)
                          return
                          }
                completion(mostRecentSample,nil)
            }
        }*/
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDiscriptor]){
            (query, samples, error) in
            
            let samples = samples
            let mostRecentSample = samples?.first as? HKQuantitySample
                completion(mostRecentSample,nil)
            
        }
        
        HKHealthStore().execute(sampleQuery)
    }
    func getHealthData(completion :() -> Void){
        age = healthDetails.readCharacteristicHealthData().age
        gender = healthDetails.readCharacteristicHealthData().gender
        
        self.readSampleHealthData(for: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.sampleLabel.text = "\(sample.quantity.doubleValue(for: HKUnit(from: "mmHg")))"
            self.bloodPressure = sample.quantity.doubleValue(for: HKUnit(from: "mmHg"))
        }
        self.readSampleHealthData(for: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.weight = sample.quantity.doubleValue(for: HKUnit(from: "kg"))
        }
        self.readSampleHealthData(for: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.height = sample.quantity.doubleValue(for: HKUnit(from: "ft"))
        }
        self.readSampleHealthData(for: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)!){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.cholesterol = sample.quantity.doubleValue(for: HKUnit(from: "mg"))
        }
        healthDetails.readSampleHealthData(for: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)!){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.sugar = sample.quantity.doubleValue(for: HKUnit(from: "mg"))
        }
        healthDetails.readSampleHealthData(for: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium)!){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.sodium = sample.quantity.doubleValue(for: HKUnit(from: "mg"))
            print("inside sodium method")
        }
        completion()
    }
    func printingg(){
        print("age:\(String(describing: (age)!)), gender:\(gender!),")
        print("BP:\(String(describing: self.bloodPressure)), weight:\(String(describing: weight)), height:\(String(describing: height)), cholest:\(String(describing: cholesterol)), sugar:\(String(describing: sugar)), sodium:\(String(describing: sodium))")
    }
    func compareData(){
       
        self.getHealthData(completion: {
            self.printingg()
        })
        
    }
    
}
