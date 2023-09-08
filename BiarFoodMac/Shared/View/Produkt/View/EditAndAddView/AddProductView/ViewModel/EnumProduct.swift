//
//  EnumProduct.swift
//  BiarFoodMac
//
//  Created by Ecc on 05/09/2023.
//

import Foundation
enum Unit : String, CaseIterable {
    case kg
    case g
    case l
    case ml
    
    
    var title: String {
        switch self{
        case .g: return "g"
        case .kg: return "Kg"
        case .l: return "l"
        case .ml: return "ml"
        }
    }
}

enum Pfand: String,CaseIterable {
    case keine,mehrWeg,einWeg
    
    var title : String {
        switch self {
        case .keine : return ""
        case .einWeg: return "Einweg"
        case .mehrWeg: return "Mehrweg"
        }
    }
    
}


enum NutriScore: String, CaseIterable {
    case keine = ""
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
    case e = "E"
}
