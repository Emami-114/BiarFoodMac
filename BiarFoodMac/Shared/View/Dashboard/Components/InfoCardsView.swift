//
//  InfoCardsView.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/10/2023.
//

import SwiftUI

struct InfoCardsView: View {
    var body: some View {
        VStack{
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing: 18){
                    ForEach(infosExample) { info in
                       InfoCartItem(info: info)
                    }
                }
            }
            
        }
    }
}

struct InfoCartItem: View {
    let info: Info
    @State  var hoveringg = false

    var body: some View {
        VStack(alignment: .leading,spacing: 18) {
            HStack(spacing: 15) {
                Text(info.title)
                    .font(.title3.bold())
                Spacer()
                
                HStack(spacing: 8) {
                    Image(systemName: info.loss ? "arrow.down" : "arrow.up")
                    Text("\(info.percentage)%")
                }
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(info.loss ? .red : .green)
            }
            
            HStack(spacing: 18) {
                Image(systemName: info.icon)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 45,height: 45)
                    .background{
                        Circle()
                        .fill(info.iconColor)}
                
                Text(info.amount)
                    .font(.title.bold())
            }
        }
        .onHover(perform: { hovering in
            withAnimation(.spring()){
                hoveringg = hovering
            }
        })
        .padding()
        .background{ RoundedRectangle(cornerRadius: 15,style: .continuous).fill( hoveringg ? Color.primary.opacity(0.4) : Color.primary.opacity(0.2)) }
    }
}

#Preview {
    InfoCardsView()
}
struct Info: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var amount: String
    var percentage: Int
    var loss: Bool = false
    var icon: String
    var iconColor: Color
}

    var infosExample = [
        Info(title: "Einkommen", amount: "2.047€", percentage: 10, loss: true,icon: "arrow.up.right", iconColor: Color.orange),
        Info(title: "Bestellungen", amount: "356", percentage: 20, loss: false,icon: "cart", iconColor: Color.green),
        Info(title: "Erfolgreiche Auslieferung", amount: "220", percentage: 10, loss: true,icon: "truck.box.badge.clock", iconColor: Color.red),
        Info(title: "Gesamtgewinn", amount: "620€", percentage: 5, loss: false,icon: "chart.bar", iconColor: Color.yellow.opacity(0.8)),
        Info(title: "Gesamtgewinn", amount: "620€", percentage: 5, loss: false,icon: "chart.bar", iconColor: Color.yellow.opacity(0.8)),
    ]
