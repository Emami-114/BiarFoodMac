//
//  NutriComponent.swift
//  BiarFoodMac
//
//  Created by Ecc on 06/09/2023.
//

import Foundation
import SwiftUI
@ViewBuilder
func NutriComponent(product: Product) -> some View{
    switch product.nutriScore {
    case "A" : Image("nutriScore-A")
            .resizable()
            .scaledToFit()
            .frame(width: 80,height: 60)
            .padding(.horizontal)
    case "B" : Image("nutriScore-B")
            .resizable()
            .scaledToFit()
            .frame(width: 80,height: 60)
            .padding(.horizontal)

    case "C" : Image("nutriScore-C")
            .resizable()
            .scaledToFit()
            .frame(width: 80,height: 60)
            .padding(.horizontal)

    case "D" : Image("nutriScore-D")
            .resizable()
            .scaledToFit()
            .frame(width: 80,height: 60)
            .padding(.horizontal)

    case "E" : Image("nutriScore-E")
            .resizable()
            .scaledToFit()
            .frame(width: 80,height: 60)
            .padding(.horizontal)


    default:
        Text("")
    }
}
