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
        //         set calculateButtonAction to billAmountTextField object to a new closure
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
        print("reset button tapped")
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
}

