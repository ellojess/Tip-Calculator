//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Input View
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var inputCardView: UIView!
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    
    // Output View
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // set calculateButtonAction to billAmountTextField object to a new closure
        billAmountTextField.calculateButtonAction = {
            self.calculate()
        }
    }
    
    @IBAction func themeToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("switch toggled on")
        } else {
            print("switch toggled off")
        }
    }
    
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
        calculate()
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        clear()
    }
    
    // helper function to calculate logic for tip and bill amounts
    func calculate() {
        billAmountTextField.calculateButtonAction = {
            // dismiss keyboard if it's displayed
            if self.billAmountTextField.isFirstResponder {
                self.billAmountTextField.resignFirstResponder()
            }
        
            // get bill amount from textfield / user input -- execute within closure
            guard let billAmountText = self.billAmountTextField.text,
                let billAmount = Double(billAmountText) else {
                    // reset calculator state when input is invalid
                    self.clear()
                    return
            }
            
            //round value to nearest two decimal places
            let roundedBillAmount = (100 * billAmount).rounded() / 100
            
            // use correct tip percent of the UISegmentedControl
            let tipPercent: Double
            switch self.tipPercentSegmentedControl.selectedSegmentIndex {
            case 0:
                tipPercent = 0.15
            case 1:
                tipPercent = 0.18
            case 2:
                tipPercent = 0.20
            default:
                preconditionFailure("Unexpected index.")
            }
            
            // calculate and sanitize the tip amount
            let tipAmount = roundedBillAmount * tipPercent
            let roundedTipAmount = (100 * tipAmount).rounded() / 100
            
            // calculate total amount
            let totalAmount = roundedBillAmount + roundedTipAmount
            
            // Update UI values
            self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount)
            self.tipAmountLabel.text = String(format: "%.2f", roundedTipAmount)
            self.totalAmountLabel.text = String(format: "%.2f", totalAmount)
        }
    }
    
    // helper function to implement reset button
    func clear() {
        billAmountTextField.text = nil
        tipPercentSegmentedControl.selectedSegmentIndex = 0
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
    }
    
    // helper function that initially configures each view's respective layer
    func setupViews() {
        
        // add shadow by configuring Header View's layser
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        // round corners of input card
        inputCardView.layer.cornerRadius = 8
        // masksToBounds prevent view's content from appearing outside of our rounded corner's boundary.
        inputCardView.layer.masksToBounds = true
        
        // round corners of output card
        outputCardView.layer.cornerRadius = 8
        outputCardView.layer.masksToBounds = true
        // set output card border
        outputCardView.layer.borderWidth = 1
        outputCardView.layer.borderColor = UIColor.tcHotPink.cgColor
        
        // set border for percent segments
        tipPercentSegmentedControl.layer.borderWidth = 1
        tipPercentSegmentedControl.layer.borderColor = UIColor.tcHotPink.cgColor
        
        // round corners of reset button
        resetButton.layer.cornerRadius = 8
        resetButton.layer.masksToBounds = true
    }
    
    // helper function to contain theme switching code
    func setTheme(isDark: Bool) {

    }
    
}

