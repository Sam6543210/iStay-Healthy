//
//  AllergyViewController.swift
//  iStay Healthy
//
//  Created by admin on 12/27/21.
//

import UIKit

class AllergyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let manager: AllergyManager = AllergyManager()
    let allergyNameArray: [String] = ["Peanut", "Soy", "Gluten", "Cashew", "Milk", "Wheat", "Almond","Hazelnuts","Guava", "Papaya"]
    var selectArr = [String]()
    let allergyStatusArray: [String] = ["Yes", "No", "Yes", "Yes", "No", "No", "No", "No", "No", "No"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //fillData()
       
        self.tableView.isEditing = true
        self.tableView.allowsSelectionDuringEditing = true
    }
    func fillData(){
        for i in 0...(allergyNameArray.count-1) {
        let allergy1 = Allergy(allergyName: allergyNameArray[i], allergyStatus: allergyStatusArray[i], allergyId: UUID())
            manager.createAllergy(allergy: allergy1)
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AllergyViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allergyNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allergycell = tableView.dequeueReusableCell(withIdentifier: "allergycell", for: indexPath)
        allergycell.textLabel?.text = allergyNameArray[indexPath.row]
        return allergycell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
    }
    
}
extension AllergyViewController{
    func selectDeselectCell(tableView: UITableView, indexPath: IndexPath){
        self.selectArr.removeAll()
        if let arr = tableView.indexPathsForSelectedRows{
            for index in arr{
                selectArr.append(allergyNameArray[index.row])
            }
        }
        print(selectArr)
    }
}
