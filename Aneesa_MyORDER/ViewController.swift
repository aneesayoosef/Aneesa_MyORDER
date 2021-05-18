//
//  ViewController.swift
//  Aneesa_MyORDER
//
//  Created by user195932 on 5/18/21.
//

import UIKit

class ViewController: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate{
    private let dbHelper = CoreDBHelper.getInstance()
    
    @IBOutlet weak var numberOfCoffee: UITextField!
    
    
    @IBOutlet weak var typePicker: UIPickerView!
    
    
    @IBOutlet weak var sizePicker: UIPickerView!
    
    
    var arrayOfTypes = ["Dark Roast","Original Blend", "Vanilla"]
    var arrayOfSizes = ["Small","Medium", "Large"]
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == typePicker{
            return String(arrayOfTypes[row])
                
        }
        else{
            return arrayOfSizes[row]
        }
    }
    
    var typeSelected = ""
    var sizeSelected = ""
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
            
            if pickerView == typePicker{
                typeSelected = arrayOfTypes[row]
            }
            else{
                sizeSelected = arrayOfSizes[row]
            }
    }
    
    
    
    @IBAction func confirmOrderPressed(_ sender: Any) {
        
        var numOfCoffee_ = 0
        if let numOfCoffee = numberOfCoffee.text
        {
            numOfCoffee_ = Int(numOfCoffee) ?? 0
        }
        
        let coffeeType = typeSelected
        let coffeSize = sizeSelected
        
        dbHelper.insertCoffee(type: coffeeType, size: coffeSize, q: numOfCoffee_)
        
        print(coffeSize)
        print(coffeeType)
        print(numOfCoffee_)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typePicker.delegate = self
        sizePicker.delegate = self
        
        typeSelected = arrayOfTypes[0]
        sizeSelected = arrayOfSizes[0]
        
        typePicker.delegate?.pickerView?(typePicker, didSelectRow: 0, inComponent: 0)
        
        let btnAddTask = UIBarButtonItem(title: "View Orders", style: .plain, target: self, action: #selector(addNewTask))
        
        self.navigationItem.setRightBarButton(btnAddTask, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @objc
        func addNewTask() {
            //ask for title and detail of the task
           print("pressed")
            let vc = MyOrderTableViewController()
            navigationController?.show(vc, sender: nil)
            //add to the list of tasks
        }


}

