//
//  PieChartsView.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/10/2023.
//

import SwiftUI

struct PieChartsView: View {
    let text: String
    let incomeAmount : String
    let totalIncome: CGSize
    let totalprofit: CGSize
    var body: some View {
        VStack(alignment: .leading,spacing: 15) {
            Text(text)
                .font(.title3.bold())
            ZStack{
                Circle()
                    .trim(from: totalIncome.width,to: totalIncome.height)
                    .stroke(.red,style: StrokeStyle(lineWidth: 25,lineCap: .round,lineJoin: .round))
//                Circle()
//                    .trim(from: 0.0,to: 0.5)
//                    .stroke(.yellow,style: StrokeStyle(lineWidth: 25,lineCap: .round,lineJoin: .round))
                Circle()
                    .trim(from: totalprofit.width,to: totalprofit.height)
                    .stroke(.green,style: StrokeStyle(lineWidth: 25,lineCap: .round,lineJoin: .round))
                
                Text(incomeAmount)
                    .font(.title)
                    .fontWeight(.heavy)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            
            HStack(spacing: 15) {
               
                Label {
                    Text("Einkommen")
                        .font(.caption)
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundColor(.red)
                }
                Label {
                    Text("Gewinn")
                        .font(.caption)
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
//                Label {
//                    Text("Other")
//                        .font(.caption)
//                        .foregroundColor(.black)
//                } icon: {
//                    Image(systemName: "circle.fill")
//                        .font(.caption2)
//                        .foregroundColor(.yellow)
//                }
                
            }
        }
        .padding(15)
        .background{ RoundedRectangle(cornerRadius: 15,style: .continuous).fill( Color.primary.opacity(0.2)) }
    }
}

#Preview {
    PieChartsView(text: "Total Income", incomeAmount: "300€",totalIncome: CGSize(width: 0.5, height: 1),totalprofit: CGSize(width: 0.2, height: 0.5))
}
