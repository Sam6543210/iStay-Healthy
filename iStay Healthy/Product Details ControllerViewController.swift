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
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func infoAction(_ sender: Any) {
        let alert = UIAlertController(title: "", message: infoMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: { (action) in
            print("pressed O.K")
        }))
        present(alert,animated: true)
    }
    @IBOutlet weak var addToCartButton: UIButton!
    @IBAction func addToCartAction(_ sender: Any) {
        let productView = ProductViewController.init()
        let t = MyCart(pName: (selectedProduct?.productName)!, pImage: (selectedProduct?.productImage)!, pBrand: (selectedProduct?.brand)!, pAddedFlavour: (selectedProduct?.addedFlavour)!, pAllergenInformation1: (selectedProduct?.allergenInformation1)!, pAllergenInformation2: (selectedProduct?.allergenInformation2)!, pSugarContent: (selectedProduct?.sugarContent)!, pSodium: (selectedProduct?.sodium)!, pFatContent: (selectedProduct?.fatContent)!, pPrice: (selectedProduct?.productPrice)!, pStartingAge: (selectedProduct?.startingAge)!, pEndingAge: (selectedProduct?.endingAge)!, pEnergy: (selectedProduct?.energy)!, id1: selectedProduct!.id)
        cartProducts.append(t)
        productView.showToast(controller: self, message: "Added to cart", seconds: 2)
    }
    private let allergy_Manager : AllergyManager = AllergyManager()
    var allergies:[Allergy] = []
    var allergyYes:[String] = []
    var age:Int?
    var gender:String?
    var bloodPressure,weight,height,cholesterol,sugar,sodium:Double?
    var infoMessage:String = ""
    var selectedProduct: Product? = nil
    let healthDetails = HealthDetails_ViewController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProductDetail()
        getHealthData()
        getAllergyYes()
        let (rf,rm) = showResult(product2:selectedProduct!)
        setInfoLabel(resultFlag: rf)
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
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDiscriptor]){
            (query, samples, error) in
                guard let samples = samples,
                      let mostRecentSample = samples.first as? HKQuantitySample else{
                          completion(nil,error)
                          return
                          }
                completion(mostRecentSample,nil)
            
        }
        
        HKHealthStore().execute(sampleQuery)
    }
    func getHealthData(){
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
        self.readSampleHealthData(for: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)!){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.sugar = sample.quantity.doubleValue(for: HKUnit(from: "mg"))
        }
        self.readSampleHealthData(for: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium)!){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.sodium = sample.quantity.doubleValue(for: HKUnit(from: "mg"))
        }
    }
    /*func printingg(){
        let bmi = getBMI()
        print("age:\(String(describing: (age)!)), gender:\(gender!),")
        print("BP:\(String(describing: self.bloodPressure)), weight:\(String(describing: weight)), height:\(String(describing: height)), cholest:\(String(describing: cholesterol)), sugar:\(String(describing: sugar)), sodium:\(String(describing: sodium)), bmi:\(bmi)\nallergies:\(String(describing: allergyYes))")
    }*/
    func getAllergyYes(){
        allergies = allergy_Manager.fetchAllergy()!
        let count = allergies.count
        if(allergies.count != 0){
            for i in 0...count-1 {
                if(allergies[i].allergyStatus! == "Yes"){
                    allergyYes.append(allergies[i].allergyName!)
                }
            }
        }
    }
    func showResult(product2:Product) -> (Bool,String){
        selectedProduct = product2
        var flag = false
        var resultFlag:Bool = true
        var resultMessage:String = ""
        while(flag == false){
            if( bloodPressure != nil
                && weight != nil
                && height != nil
                && cholesterol != nil
                && sugar != nil
                && sodium != nil
            ){
                (resultFlag,resultMessage) = compareData()
                infoMessage = resultMessage
                flag = true
            }
        }
        return (resultFlag,resultMessage)
    }
    func compareData() -> (Bool,String){
        var resultFlag = false
        var resultMessage = ""
        if(age! < selectedProduct!.startingAge || age! > selectedProduct!.endingAge){
            resultFlag = true
            resultMessage.append("\n* not recommended for your age")
        }
        let bmi = getBMI()
        if(age! >= 20){
            /*if(bmi < 18.5){
            }
            else if(bmi >= 18.5 && bmi < 25){
            }*/
            let fat = selectedProduct?.fatContent
            if(bmi >= 25 && bmi < 30){
                if(fat as! Int >= 10){
                    resultFlag = true
                    resultMessage.append("\n* contains high fat content")
                }
            }
            else if(bmi >= 30){
                if(fat as! Int >= 5){
                    resultFlag = true
                    resultMessage.append("\n* contains high fat content")
                }
            }
            if(cholesterol! > 200 && fat as! Int > 15){
                resultFlag = true
                resultMessage.append("\n* high fat may increase your cholesterol")
            }
        }
        else if(age! >= 2 && age! < 20){
            /*if(bmi < 17.5){
            }
            else if(bmi >= 17.5 && bmi < 25){
            }*/
            let fat = selectedProduct?.fatContent
            if(bmi >= 25 && bmi < 28.4){
                if(fat as! Int >= 10){
                    resultFlag = true
                    resultMessage.append("\n* contains high fat content")
                }
            }
            else if(bmi >= 28.3){
                if(fat as! Int >= 5){
                    resultFlag = true
                    resultMessage.append("\n* contains high fat content")
                }
            }
            if(cholesterol! > 170 && fat as! Int > 15){
                resultFlag = true
                resultMessage.append("\n* high fat may increase your cholesterol")
            }
        }
        if(allergyYes.count != 0){
            let count = allergyYes.count
            for i in 0...count-1 {
                if(allergyYes[i] == selectedProduct?.allergenInformation1){
                    resultFlag = true
                    resultMessage.append("\n* contains ingredients allergic to you")
                    break
                }
                else if(allergyYes[i] == selectedProduct?.allergenInformation2){
                    resultFlag = true
                    resultMessage.append("\n* contains ingredients allergic to you")
                    break
                }
            }
        }
        if(bloodPressure! > 120){
            let sodium = selectedProduct?.sodium
            let fat = selectedProduct?.fatContent
            if(sodium as! Int > 500 && fat as! Int > 17){
                resultFlag = true
                resultMessage.append("\n* contains high salt,fat content")
            }
            else if(sodium as! Int > 500){
                resultFlag = true
                resultMessage.append("\n* contains high salt content")
            }
            else if(fat as! Int > 17){
                resultFlag = true
                resultMessage.append("\n* high fat may affect your BP")
            }
        }
        if(sugar! >= 100 && sugar! < 125){
            let productSugar = selectedProduct?.sugarContent
            if(productSugar as! Int > 10){
                resultFlag = true
                resultMessage.append("\n* contains high sugar content")
            }
        }
        else if(sugar! >= 125){
            let productSugar = selectedProduct?.sugarContent
            if(productSugar as! Int > 5){
                resultFlag = true
                resultMessage.append("\n* contains high sugar content")
            }
        }
        return (resultFlag,resultMessage)
    }
    func setInfoLabel(resultFlag:Bool){
        if(resultFlag == true){
            resultLabel.text = "        This product is not suitable for you"
            resultImage.image = UIImage(named: "disapproval2")
        }
    }
    func getBMI() -> Double{
        var bmiHeight = self.height
        bmiHeight = bmiHeight! * 0.3048
        bmiHeight = bmiHeight! * bmiHeight!
        let bmi = self.weight! / bmiHeight!
        return bmi
    }
}
