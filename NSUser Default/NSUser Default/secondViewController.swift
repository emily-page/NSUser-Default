//
//  secondViewController.swift
//  NSUser Default
//
//  Created by apcs2 on 9/5/17.
//  Copyright © 2017 apcs2. All rights reserved.
//

import UIKit

class secondViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var textTwo: UITextField!
    @IBOutlet weak var textOne: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    func getAssignment() -> Dictionary<String,String>
    {
        return ["name":textOne.text!, "date": textTwo.text!]
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField)
    {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        textTwo.text = dateFormatter.string(from: sender.date)
    }
    
    func getDueDate() -> String
    {
        return (textTwo.text)!
    }
    
    @IBAction func buttonOne(_ sender: UIButton)
    {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let nvc = segue.destination as! ViewController
        UserDefaults.standard.set(textOne.text, forKey: "name")
        UserDefaults.standard.set(textTwo.text, forKey: "date")
        let assignment = ["name": textOne.text]
        nvc.notebook?.append(assignment as! [String : String])
    }
    
}
