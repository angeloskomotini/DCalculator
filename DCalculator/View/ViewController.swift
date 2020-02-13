//
//  ViewController.swift
//  DCalculator
//
//  Created by Angelos Staboulis on 12/2/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import UIKit

import iOSDropDown

protocol ResultsDelegate{
    func initReadout()
    func initResult()
    func createReadout(readout:String)
    func createResult(readout:String)
    func calculateResult(readout:String)->NSNumber?
    func populateDropDown(currencyArray:[String],ratesArray:[String])
    func showRates()
}

class ViewController: UIViewController {
    var result = String()
    var currency=[String]()
    var rates=[String]()
    var selectedRateFrom = Double()
    var selectedRateTo = Double()
    @IBOutlet weak var lblReadout: UILabel!
    @IBOutlet weak var lblConvertResult: UILabel!
    @IBOutlet weak var Cmd0: UIButton!
    @IBOutlet weak var Cmd8: UIButton!
    @IBOutlet weak var CmdConvert: UIButton!
    @IBOutlet weak var CmdPlus: UIButton!
    @IBOutlet weak var Cmd4: UIButton!
    @IBOutlet weak var CmdMinus: UIButton!
    @IBOutlet weak var Cmd1: UIButton!
    @IBOutlet weak var Cmd2: UIButton!
    @IBOutlet weak var Cmd3: UIButton!
    @IBOutlet weak var Cmd5: UIButton!
    @IBOutlet weak var Cmd6: UIButton!
    @IBOutlet weak var CmdDiv: UIButton!
    @IBOutlet weak var Cmd9: UIButton!
    @IBOutlet weak var Cmd7: UIButton!
    @IBOutlet weak var CmdDecimal: UIButton!
    @IBOutlet weak var CmdEqual: UIButton!
    @IBOutlet weak var CmdMultiply: UIButton!
    
    @IBOutlet weak var lblConvert: UILabel!
    let model = DCalculatorViewModel()
    
    @IBOutlet weak var dropDownFrom: DropDown!
    
    @IBOutlet weak var DropDownTo: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showRates()
        
    }
}
extension ViewController:ResultsDelegate{
    @IBAction func CmdClear(_ sender: Any) {
        lblReadout.text = ""
        lblConvert.text = ""
    }
    func convertReadoutToDouble()->Double{
        return Double(String(self.lblReadout.text!))!
    }
    func convertResult(result:Double)->String{
        return String(format:"%.2f",result)
    }
    func showRates() {
        model.showRates { (json) in
            self.model.updateBase(base: json["base"].stringValue)
            for rate in json["rates"]{
                self.currency.append(rate.0)
                self.rates.append(rate.1.stringValue)
            }
            self.populateDropDown(currencyArray:self.currency, ratesArray: self.rates)
            self.DropDownTo.didSelect { (text, getSelected, selected) in
                self.selectedRateTo = Double(self.rates[getSelected])!
                
            }
            self.dropDownFrom.didSelect { (text, getSelected, selected) in
                self.selectedRateFrom = Double(self.rates[getSelected])!
                let result = self.convertReadoutToDouble() / self.selectedRateFrom
                self.lblConvert.text = self.convertResult(result: result)
            }
        }
    }
    
    func populateDropDown(currencyArray:[String],ratesArray:[String]){
        self.model.updateCurrency(currency:currencyArray)
        self.model.updateRate(rateValue:ratesArray)
        self.dropDownFrom.optionArray = currencyArray
        self.DropDownTo.optionArray = currencyArray
    }
    
    func initResult() {
        result=lblReadout.text!
    }
    
    func initReadout() {
        lblReadout.text=""
    }
    
    @IBAction func CmdMultiply(_ sender: Any) {
        createResult(readout: CmdMultiply.titleLabel!.text! )
        initReadout()
    }
    
    func createResult(readout: String) {
        result = result + readout
    }
    
    func calculateResult(readout: String) -> NSNumber? {
        let expression = NSExpression(format:readout, argumentArray: [])
        let resultValue = expression.expressionValue(with: nil, context: nil) as! NSNumber
        return resultValue
    }
    
    func createReadout(readout:String){
        if ((lblReadout.text?.contains("0."))!) {
            lblReadout.text = ""
            lblReadout.text = (lblReadout.text ?? "")  + readout
        }
        else{
            lblReadout.text = (lblReadout.text ?? "")  + readout
        }
    }
    @IBAction func Cmd0(_ sender: Any) {
        createResult(readout: Cmd0.titleLabel!.text!)
        createReadout(readout: Cmd0.titleLabel!.text!)
        
    }
    
    @IBAction func CmdEqual(_ sender: Any) {
        lblReadout.text = calculateResult(readout: result)?.stringValue
        initResult()
    }
    @IBAction func CmdDecimal(_ sender: Any) {
        createResult(readout: CmdDecimal.titleLabel!.text!)
        createReadout(readout: CmdDecimal.titleLabel!.text!)
    }
    
    @IBAction func Cmd7(_ sender: Any) {
        createResult(readout: Cmd7.titleLabel!.text! )
        createReadout(readout: Cmd7.titleLabel!.text!)
    }
    
    @IBAction func Cmd8(_ sender: Any) {
        createResult(readout: Cmd8.titleLabel!.text! )
        createReadout(readout: Cmd8.titleLabel!.text!)
        
    }
    @IBAction func Cmd9(_ sender: Any) {
        createResult(readout: Cmd9.titleLabel!.text! )
        createReadout(readout: Cmd9.titleLabel!.text!)
        
    }
    @IBAction func CmdDiv(_ sender: Any) {
        createResult(readout: CmdDiv.titleLabel!.text! )
        initReadout()
        
    }
    @IBAction func Cmd6(_ sender: Any) {
        createResult(readout: Cmd6.titleLabel!.text! )
        createReadout(readout: Cmd6.titleLabel!.text!)
        
    }
    @IBAction func Cmd5(_ sender: Any) {
        createResult(readout: Cmd5.titleLabel!.text! )
        createReadout(readout: Cmd5.titleLabel!.text!)
        
    }
    @IBAction func Cmd3(_ sender: Any) {
        createResult(readout: Cmd3.titleLabel!.text! )
        createReadout(readout: Cmd3.titleLabel!.text!)
        
    }
    @IBAction func Cmd2(_ sender: Any) {
        createResult(readout: Cmd2.titleLabel!.text! )
        createReadout(readout: Cmd2.titleLabel!.text!)
        
    }
    @IBAction func Cmd1(_ sender: Any) {
        createResult(readout: Cmd1.titleLabel!.text! )
        createReadout(readout: Cmd1.titleLabel!.text!)
        
    }
    @IBAction func CmdMinus(_ sender: Any) {
        createResult(readout: CmdMinus.titleLabel!.text!)
        initReadout()
    }
    @IBAction func Cmd4(_ sender: Any) {
        createResult(readout: Cmd4.titleLabel!.text! )
        createReadout(readout: Cmd4.titleLabel!.text!)
        
    }
    
    @IBAction func CmdPlus(_ sender: Any) {
        createResult(readout: CmdPlus.titleLabel!.text! )
        initReadout()
    }
    
}
