//
//  ViewController.swift
//  Tips
//
//  Created by Erica Lee on 12/27/15.
//  Copyright © 2015 EricaLee. All rights reserved.
//
//  TODO: add remembering last bill feature
// ADd local currency formatting

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var BillField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var InitialView: UIView!
    @IBOutlet weak var TypedView: UIView!
    var moved = false //for animation
    @IBOutlet weak var SplitPicker: UIPickerView!
    var pickerData = ["1","2","3","4","5","6","7","8","9","10"] //for splitting people
    var attr = NSDictionary(object: UIFont(name: "HelveticaNeue-Bold", size: 16.0)!, forKey: NSFontAttributeName) //font
    var split = 1.0 // default split
    var tipPercentages = [0.18, 0.2, 0.22] //default tip values
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        split = Double(row) + 1.0

        InitialView.bringSubviewToFront(InitialView)

        UpdateTotalBill()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
   // func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
       // return pickerData[row]
   // }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: 20.0)!,NSForegroundColorAttributeName:UIColor(red:0.10, green:0.00, blue:0.07, alpha:1.0)])
        return myTitle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tip Calculator"
        
        //Setting up the initial bill amount
        BillField.attributedPlaceholder = NSAttributedString(string:"$",
            attributes:[NSForegroundColorAttributeName: UIColor(red:0.10, green:0.00, blue:0.07, alpha:0.5)])
        
        //setting Split Picker
        self.SplitPicker.dataSource = self;
        self.SplitPicker.delegate = self;

        // Initialize tip labels and total labels
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        self.InitialView.alpha = 1
        self.TypedView.alpha = 0
        
        // Make keyboard pop up when user opens the app
        BillField.becomeFirstResponder()
        
        //setting TipControl
        tipControl.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)

        //get selected value from the split picker
        SplitPicker.selectRow(0, inComponent: 0, animated: true)

    }

    func UpdateTotalBill(){
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: BillField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = (billAmount + tip)/split
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        ///var formatter = NSNumberFormatter()
        //formatter.numberStyle = .CurrencyStyle
                
        //tipLabel.text = String(formatter.stringFromNumber(tip))
        //totalLabel.text = String(formatter.stringFromNumber(total)) // "$123.44"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //event for user typing in tip amount and selecting the tip control and when picker is tapped
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        //once user starts typing and it hasn't been moved, Typed View pops up
        if !BillField.text!.isEmpty && !moved  {
            UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: {
                var IntViewFrame = self.InitialView.frame
                IntViewFrame.origin.y -= IntViewFrame.size.height
                self.InitialView.frame = IntViewFrame
                }, completion: { finished in
            })
            moved = true
            self.TypedView.alpha = 1
        }
        
        if BillField.text!.isEmpty && moved {
            UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: {
                var IntViewFrame = self.InitialView.frame
                IntViewFrame.origin.y += IntViewFrame.size.height
                self.InitialView.frame = IntViewFrame
                }, completion: { finished in
            })
            moved = false
            self.TypedView.alpha = 0
        }
        
        UpdateTotalBill()

    }

    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        //Retrieve the Default Tip Percentages and set it to tipControl
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()


        if let percentage1 = defaults.stringForKey("Default_Percentage1")
        {
            //Update Segmented Control to stored default tip values
            tipControl.setTitle(percentage1 + "%", forSegmentAtIndex: 0)
            tipPercentages[0] = (NSString(string: percentage1).doubleValue)/100


        }
        
        if let percentage2 = defaults.stringForKey("Default_Percentage2")
        {
            
            tipControl.setTitle(percentage2 + "%", forSegmentAtIndex: 1)
            tipPercentages[1] = (NSString(string: percentage2).doubleValue)/100
            
        }
        
        if let percentage3 = defaults.stringForKey("Default_Percentage3")
        {
            
            tipControl.setTitle(percentage3 + "%", forSegmentAtIndex: 2)
            tipPercentages[2] = (NSString(string: percentage3).doubleValue)/100

        }
        
        //Update Segmented Control selection
        let index = defaults.integerForKey("Default_Index")
        tipControl.selectedSegmentIndex = index
        
        UpdateTotalBill()

        //let billAmount = NSString(string: BillField.text!).doubleValue
        //Save the Bill for restarting the app
        //defaults.setObject(billAmount, forKey: "Last_Bill")
        //let date = NSDate()
    }
    
    
}

