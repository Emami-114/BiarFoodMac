//
//  PriceReplacing.swift
//  BiarFoodMac
//
//  Created by Ecc on 26/09/2023.
//

import Foundation
func priceReplacingWithPoint(_ price: String) -> Double{
    Double(price.replacingOccurrences(of: ",", with: ".")) ?? 0.0
}

func priceReplacingWithComma(_ price: Double) -> String {
    let priceString = String(format: "%.2f", price)
    return priceString.replacingOccurrences(of: ".", with: ",")
}
