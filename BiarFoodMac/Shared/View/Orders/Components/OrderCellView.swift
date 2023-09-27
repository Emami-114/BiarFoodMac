//
//  OrderCellView.swift
//  BiarFoodMac
//
//  Created by Ecc on 26/09/2023.
//

import SwiftUI

struct OrderCellView: View {
    let order : Order
    @Binding var showDetail : Bool
    @State var onHover = false
    var body: some View {
        HStack (spacing: 30){
            VStack(alignment: .leading){
                HStack{
                    Text("RechnungNR:")
                    Text("13546")
                        .font(.title2.bold())
                }
                HStack{
                    Text("Name:")
                    Text(order.customerName)
                        .font(.title2.bold())

                }
            }
            VStack(alignment: .leading){
                HStack{
                    Text("Adresse:")
                    Text(order.customerAdress)
                        .font(.title2.bold())

                }
                HStack(spacing: 3){
                    Text(order.customerZip)
                    Text(order.customerCity)
                }.font(.title2.bold())

            }
            VStack(alignment: .leading){
                HStack{
                    Text("Liferung: ")
                    Text("\(order.deliveryDate!.formatted(date: .abbreviated, time: .standard))")
                }
                
                HStack{
                    Text("BezahlungArt: ")
                    Text(order.paymentType)
                }
            }
            Spacer()
            VStack(alignment: .leading){
                HStack{
                    Text("Bezahlt")
                    Image(systemName: order.paymentSuccess ? "checkmark.circle" : "xmark.circle")
                        .foregroundColor(order.paymentSuccess ? .green : .red)
                }
                HStack{
                    Text("Abgeschlossen")
                    Image(systemName: order.successful ? "checkmark.circle" : "xmark.circle")
                        .foregroundColor(order.successful ? .green : .red)
                }
            }.font(.title2.bold())
            Spacer()
            Button{
                withAnimation(.spring()){
                    showDetail.toggle()
                }
            }label: {
                Image(systemName: showDetail ? "arrow.up.circle" : "arrow.down.circle")
                    .resizable()
                    .frame(width: 40,height: 40)
                    .help("Rechnung Detail ansehen")
            }.buttonStyle(.plain)
                .font(.title.bold())
                .foregroundColor(onHover ? Color.primary.opacity(0.9) : Color.primary.opacity(0.5))
                .onHover(perform: { hovering in
                    withAnimation(.spring()){
                        self.onHover = hovering
                    }
                })
        }.font(.title3)
            .padding()
    }
}

#Preview {
    OrderCellView(order: .init(userId: "", successful: true, customerName: "Abdul Emami", customerAdress: "Stauffenbergstr.14", customerZip: "07747", customerCity: "Jena", deliveryDate: Date(), paymentType: "Paypal", paymentSuccess: true, products: []), showDetail: .constant(false))
}
