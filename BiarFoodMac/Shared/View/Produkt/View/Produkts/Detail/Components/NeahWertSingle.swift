//
//  NeahWertSingle.swift
//  BiarFoodMac
//
//  Created by Ecc on 24/08/2023.
//

import SwiftUI

@ViewBuilder
func neahWertSingle(title:String)-> some View{
        Text(title)
        Divider()
        
    
}


@ViewBuilder
func neahWert(product: Product) -> some View {

    VStack (alignment: .center){
        HStack{
            VStack(alignment: .leading,spacing: 10){
                Text("Nährwerte")
                    .padding(10)
                    .background(.gray.opacity(0.4))
                    .cornerRadius(10)
                
                neahWertSingle(title: "Brennwert kj")
                neahWertSingle(title: "Brennwert kcal")
                neahWertSingle(title: "Fett")
                neahWertSingle(title: "davon Fettsäuren")
                neahWertSingle(title: "Kohlenhydrate")
                neahWertSingle(title: "davon Zucker")
                neahWertSingle(title: "Eiweiß")
                neahWertSingle(title: "Salz")
            }
            Divider()
            VStack(alignment: .leading, spacing: 10){
                Text(!(product.referencePoint.isEmpty ) ? product.referencePoint : "")
                    .padding(10)
                    .background(.gray.opacity(0.4))
                    .cornerRadius(10)
                
                neahWertSingle(title: "\(product.calorificKJ ) KJ")
                neahWertSingle(title: "\(product.caloricValueKcal ) Kcal")
                neahWertSingle(title: "\(product.fat ) g")
                neahWertSingle(title: "\(product.fatFromSour ) g")
                neahWertSingle(title: "\(product.carbohydrates ) g")
                neahWertSingle(title: "\(product.CarbohydratesFromSugar ) g")
                neahWertSingle(title: "\(product.protein ) g")
                neahWertSingle(title: "\(product.salt ) g")
               
                
            }
        }
        .padding()
        .frame(width: 300,height: 350)
    .border(.white.opacity(0.4))
    }
    
    Text(product.additionallyWert )
    
    
}
