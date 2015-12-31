//
//  SettingViewController.swift
//  Tips
//
//  Created by Erica Lee on 12/29/15.
//  Copyright © 2015 EricaLee. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var TipSlider1: UISlider!
    @IBOutlet weak var TipSlider2: UISlider!
    @IBOutlet weak var TipSlider3: UISlider!
    @IBOutlet weak var TipPercentageLabel1: UILabel!
    @IBOutlet weak var TipPercentageLabel2: UILabel!
    @IBOutlet weak var TipPercentageLabel3: UILabel!
    @IBOutlet weak var TipControl: UISegmentedControl!
    var attr = NSDictionary(object: UIFont(name: "HelveticaNeue-Bold", size: 16.0)!, forKey: NSFontAttributeName) //font
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //load sliders and labels with default values
        if let percentage1 = defaults.stringForKey("Default_Percentage1"){
            TipSlider1.value = (NSString(string: percentage1).floatValue)
            TipPercentageLabel1.text = percentage1 + "%"
            TipControl.setTitle(percentage1 + "%", forSegmentAtIndex: 0)
        }
        
        if let percentage2 = defaults.stringForKey("Default_Percentage2"){
            TipSlider2.value = (NSString(string: percentage2).floatValue)
            TipPercentageLabel2.text = percentage2 + "%"
            TipControl.setTitle(percentage2 + "%", forSegmentAtIndex: 1)

        }
        
        if let percentage3 = defaults.stringForKey("Default_Percentage3"){
            TipSlider3.value = (NSString(string: percentage3).floatValue)
            TipPercentageLabel3.text = percentage3 + "%"
            TipControl.setTitle(percentage3 + "%", forSegmentAtIndex: 2)

        }
        
        
        //setting tip control slider
        let index = defaults.integerForKey("Default_Index")
        TipControl.selectedSegmentIndex = index
        TipControl.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //When the slider is edited for 1st option
    @IBAction func TipSlider1Slided(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //change the slider value
        let currVal1 = Int(TipSlider1.value)
        TipPercentageLabel1.text = "\(currVal1)%"
        
        defaults.setObject(currVal1, forKey: "Default_Percentage1")
        //defaults.synchronize() //not sure if this is needed?
        
        TipControl.setTitle(defaults.stringForKey("Default_Percentage1")! + "%", forSegmentAtIndex: 0)
    }
    
    @IBAction func TipSlider2Slided(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let currVal2 = Int(TipSlider2.value)
        TipPercentageLabel2.text = "\(currVal2)%"
        
        defaults.setObject(currVal2, forKey: "Default_Percentage2")
        
        TipControl.setTitle(defaults.stringForKey("Default_Percentage2")! + "%", forSegmentAtIndex: 1)
    }
    
    @IBAction func TipSlider3Slided(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let currVal3 = Int(TipSlider3.value)
        TipPercentageLabel3.text = "\(currVal3)%"
        
        defaults.setObject(currVal3, forKey: "Default_Percentage3")
        
        TipControl.setTitle(defaults.stringForKey("Default_Percentage3")! + "%", forSegmentAtIndex: 2)
    }
    
    
    //when user selects default tip percentage control
    @IBAction func TipControlTap(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let Default_idx = TipControl.selectedSegmentIndex
        defaults.setObject(Default_idx, forKey: "Default_Index")
        
    }
    
    @IBAction func onTap2(sender: AnyObject) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
