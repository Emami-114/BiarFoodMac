//
//  DashboardView.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI
struct Sale: Identifiable {
    var id: String = UUID().uuidString
    var sales: Int
    var time: String
}

struct DashboardView: View {
    var dailySales: [Sale] = [
    Sale(sales: 20, time: "11:00"),
    Sale(sales: 40, time: "12:00"),
    Sale(sales: 40, time: "1:00"),
    Sale(sales: 150, time: "2:00"),
    Sale(sales: 260, time: "3:00"),
    Sale(sales: 80, time: "4:00"),
    Sale(sales: 120, time: "5:00"),
    Sale(sales: 50, time: "6:00"),
    Sale(sales: 30, time: "7:00"),
    ]
    var annualSales: [Sale] = [
    Sale(sales: 20, time: "Januar"),
    Sale(sales: 40, time: "Februar"),
    Sale(sales: 140, time: "März"),
    Sale(sales: 250, time: "April"),
    Sale(sales: 160, time: "Mai"),
    Sale(sales: 80, time: "Juni"),
    Sale(sales: 130, time: "Juli"),
    Sale(sales: 150, time: "August"),
    Sale(sales: 10, time: "September"),
    Sale(sales: 10, time: "Oktober"),
    Sale(sales: 10, time: "November"),
    Sale(sales: 500, time: "Dezember"),
    ]
    
    var body: some View {
               VStack {
                   InfoCardsView()
                       .padding(.vertical)
                   Spacer()
                   HStack{
                       ChartsSalesView(dialySales: dailySales, title: "Täglicher Umsatz")
                       PieChartsView(text: "Täglicher Umsatz", incomeAmount: "2000€",totalIncome: CGSize(width: 0.25, height: 1),totalprofit: CGSize(width: 0, height: 0.25))
                           .frame(maxWidth: 500)
                   }
                   
                   HStack{
                       ChartsSalesView(dialySales: annualSales,title: "Jahresumsatz")
                       PieChartsView(text: "Jahresumsatz", incomeAmount: "30000€",totalIncome: CGSize(width: 0.4, height: 1),totalprofit: CGSize(width: 0, height: 0.4))
                           .frame(maxWidth: 500)
                   }
                   Spacer()
           
               }.padding()
             
           }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
