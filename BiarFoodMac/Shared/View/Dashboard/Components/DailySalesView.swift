//
//  DailySalesView.swift
//  BiarFoodMac
//
//  Created by Ecc on 10/09/2023.
//

import SwiftUI
import Charts

struct DailySalesView: View {
    var dialySales : [Sale]
    let title : String
    var body: some View {
        VStack(alignment: .leading,spacing: 15){
            Text(title)
                .font(.title.bold())
            Chart{
                ForEach(dialySales) { sale in
                    AreaMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales))
                    .foregroundStyle(.linearGradient(colors: [
                        Color.green.opacity(0.6),
                        Color.green.opacity(0.5),
                        Color.green.opacity(0.3),
                        Color.green.opacity(0.1),
                        .clear
                    ], startPoint: .top, endPoint: .bottom))
                    .interpolationMethod(.catmullRom)
                    
                    LineMark(x: .value("Time", sale.time), y: .value("Sale", sale.sales))
                        .foregroundStyle(Color.green)
                        .interpolationMethod(.catmullRom)
                    
                    PointMark(x: .value("Time", sale.time), y: .value("Sale", sale.sales))
                        .foregroundStyle(Color.green)
                }
            }
            .frame(height: 300)
        }
        .padding(15)
        .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(Color.primary.opacity(0.15)))
        
    }
}

struct DailySalesView_Previews: PreviewProvider {
    static var previews: some View {
        DailySalesView(dialySales: [   Sale(sales: 20, time: "11:00"),
                                       Sale(sales: 40, time: "12:00"),
                                       Sale(sales: 40, time: "1:00"),
                                       Sale(sales: 150, time: "2:00"),
                                       Sale(sales: 260, time: "3:00"),
                                       Sale(sales: 80, time: "4:00"),
                                       Sale(sales: 120, time: "5:00"),
                                       Sale(sales: 50, time: "6:00"),
                                       Sale(sales: 30, time: "7:00"),], title: "Monatlicher Umsatz")
    }
}

