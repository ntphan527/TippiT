//
//  ViewController.swift
//  Tippy
//
//  Created by Ngan Phan on 8/6/17.
//  Copyright © 2017 Ngan Phan. All rights reserved.
//

import UIKit

var tipPercentages = [18, 20, 25]

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitTextField: UITextField!
    @IBOutlet weak var splitAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("loading")
        willEnterForeground()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        if billField.text == "" {
            billField.placeholder = NSLocale.current.currencySymbol
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        billField.becomeFirstResponder()
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "tip")
        calculateTip(self)
        
        for i in 0..<tipControl.numberOfSegments {
            tipControl.setTitle(String(tipPercentages[i]) + "%", forSegmentAt: i)
        }
    }
    
    func willEnterForeground() {
        print("will enter foreground")
        billField.becomeFirstResponder()
        
        let endTime = Date()
        let defaults = UserDefaults.standard
        if let startTime = defaults.value(forKey: "billAmountTimer") {
            let startDate = startTime as! Date
            
            let timeInterval:Double = endTime.timeIntervalSince(startDate) / 60
            
            if timeInterval > 1 {
                defaults.removeObject(forKey: "billAmount")
                billField.text = ""
                billField.placeholder = NSLocale.current.currencySymbol
                tipLabel.text = ""
                totalLabel.text = ""
                splitAmountLabel.text = ""
                
                print("more than 10 mins: " + String(timeInterval))
            } else {
                billField.text = defaults.object(forKey: "billAmount") as? String
                print("less than 10 mins: " + String(timeInterval))
            }
            defaults.removeObject(forKey: "billAmountTimer")
        }
        
        if let tipPercentagesDefault = defaults.array(forKey: "tipPercentages") {
            tipPercentages = tipPercentagesDefault as! [Int]
            defaults.removeObject(forKey: "tipPercentages")
            print("foreground tipPercentages: \(tipPercentages)")
        }
        
        let split = defaults.string(forKey: "split")
        if split != nil {
            splitTextField.text = split
        }
    }
    
    func willResignActive() {
        let startTime = Date()
        let defaults = UserDefaults.standard
        defaults.set(startTime, forKey: "billAmountTimer")
        defaults.set(billField.text, forKey: "billAmount")
        defaults.set(tipPercentages, forKey:"tipPercentages")
        defaults.set(splitTextField.text, forKey:"split")
        defaults.synchronize()
        print("resign active")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * Double(tipPercentages[tipControl.selectedSegmentIndex]) / 100
        let total = bill + tip
        
        tipLabel.text = displayCurrency(amount: tip)
        totalLabel.text = displayCurrency(amount: total)
        
        calculateSplit(sender)
    }
    
    @IBAction func calculateSplit(_ sender: Any) {
        if let totalCurrency = totalLabel.text {
            if let totalNumber = stripCurrency(amount: totalCurrency) {
                let total = totalNumber.doubleValue
                let split = Double(splitTextField.text!) ?? 1
                let splitAmount = total / split
                splitAmountLabel.text = displayCurrency(amount: splitAmount)
                print("total: \(total)")
            }
        }
        
    }
    
    func displayCurrency(amount: Double) -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        // localize to your grouping and decimal separator
        
        currencyFormatter.locale = NSLocale.current
        let number = NSNumber(value: amount)
        
        return currencyFormatter.string(from: number)
    }
    
    func stripCurrency(amount: String) -> NSNumber? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        // localize to your grouping and decimal separator
        
        currencyFormatter.locale = NSLocale.current
        return currencyFormatter.number(from: amount)
    }
}

