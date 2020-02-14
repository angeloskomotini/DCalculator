//
//  DCalculatorViewModel.swift
//  DCalculator
//
//  Created by Angelos Staboulis on 13/2/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol DCalculatorRatesDelegate{
    func showRates(completion:@escaping ((JSON))->())
}
class DCalculatorViewModel:DCalculatorRatesDelegate{
    
    private var calculator = DCalculatorModel()
    
    var currency:[String]{
        return calculator.currency
    }
    
    var rate:[String]{
           return calculator.rate
    }
    
    func updateCurrency(currency:[String]){
        calculator.currency = currency
    }
    
    func updateRate(rateValue:[String]){
        calculator.rate = rateValue
    }
    
    func showRates(completion:@escaping ((JSON))->() ) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=aedf1209f249eb12577809483a2db622")
        let request = URLRequest(url: url!)
        Alamofire.request(request as URLRequestConvertible).responseJSON { (response) in
            let json = JSON(response.result.value!)
            completion(json)
        }
    }
}
