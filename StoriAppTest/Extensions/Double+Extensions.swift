//
//  Double+Extension.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 05/11/24.
//

import Foundation

extension Double {
    var roundedToTwoDecimals: Double {
        return (self * 100).rounded() / 100
    }
    
    var toTwoDecimalString: String {
        return String(format: "%.2f", self)
    }
}
