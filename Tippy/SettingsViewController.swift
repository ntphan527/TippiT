//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Ngan Phan on 8/6/17.
//  Copyright © 2017 Ngan Phan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var defaultTipTextField1: UITextField!
    @IBOutlet weak var defaultTipTextField2: UITextField!
    @IBOutlet weak var defaultTipTextField3: UITextField!
    var previouslySelectedSegmentIndex = 0
    var defaultTipTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        defaultTipControl.selectedSegmentIndex = defaults.integer(forKey: "tip")
        previouslySelectedSegmentIndex = defaultTipControl.selectedSegmentIndex
        defaultTipTextFields = [defaultTipTextField1, defaultTipTextField2, defaultTipTextField3]
        for i in 0..<tipPercentages.count {
            defaultTipTextFields[i].alpha = 0
            defaultTipControl.setTitle(String(tipPercentages[i]) + "%", forSegmentAt: i)
        }
        showDefaultTipTextField()
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        defaultTipControl.selectedSegmentIndex = defaults.integer(forKey: "tip")
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showDefaultTipTextField() {
        if previouslySelectedSegmentIndex == defaultTipControl.selectedSegmentIndex {
            defaultTipTextFields[defaultTipControl.selectedSegmentIndex].alpha = 1
            defaultTipTextFields[defaultTipControl.selectedSegmentIndex].text = String(tipPercentages[defaultTipControl.selectedSegmentIndex])
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.defaultTipTextFields[self.previouslySelectedSegmentIndex].alpha = 0
                self.defaultTipTextFields[self.defaultTipControl.selectedSegmentIndex].alpha = 1
            })
            defaultTipTextFields[defaultTipControl.selectedSegmentIndex].text = String(tipPercentages[defaultTipControl.selectedSegmentIndex])
            previouslySelectedSegmentIndex = defaultTipControl.selectedSegmentIndex
        }
        defaultTipTextFields[defaultTipControl.selectedSegmentIndex].becomeFirstResponder()
    }
    
    @IBAction func editDefaultTip(_ sender: Any) {
        let defaultTipTextFields = [defaultTipTextField1, defaultTipTextField2, defaultTipTextField3]
        if let editDefaultTipString = defaultTipTextFields[defaultTipControl.selectedSegmentIndex]?.text {
            tipPercentages[defaultTipControl.selectedSegmentIndex] = Int(editDefaultTipString) ?? 0
            defaultTipControl.setTitle(editDefaultTipString + "%", forSegmentAt: defaultTipControl.selectedSegmentIndex)
            print("edit tip: \(tipPercentages[defaultTipControl.selectedSegmentIndex])")
        }
    }
    
    @IBAction func defaultTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: "tip")
        defaults.synchronize()
        showDefaultTipTextField()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
}
