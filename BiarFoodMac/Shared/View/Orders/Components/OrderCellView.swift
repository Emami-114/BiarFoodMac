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
                    Text("\(order.invoiceNum)")
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

            }.frame(maxWidth: .infinity,alignment: .leading)
            VStack(alignment: .leading){
                HStack{
                    Text("Liferung: ")
                    Text("\(order.deliveryDate!.formatted(.dateTime.day().month().year()))")
                        .font(.title2.bold())
                }
                HStack{
                    Text("Gesamtbetrag: ")
                    Text("\(priceReplacingWithComma(_: order.totalPrice))€")
                        .font(.title2.bold())
                }
                
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            
            Spacer()
            VStack(alignment: .leading){
                HStack{
                    Text("Zahlungsart: ")
                    Text(order.paymentType)
                        .font(.title2.bold())
                }
                HStack{
                    Text("Abgeschlossen")
                    Image(systemName: order.successful ? "checkmark.circle" : "xmark.circle")
                        .foregroundColor(order.successful ? .green : .red)
                        .font(.title2.bold())
                }
            }
            Spacer()
            Button{
                withAnimation(.spring()){
                    showDetail.toggle()
                }
            }label: {
                Image(systemName: showDetail ? "chevron.compact.up" : "chevron.compact.down")
                    .resizable()
                    .symbolEffect(.bounce, value: showDetail)
                    .frame(width: 30,height: 15)
                    .help("Rechnung Detail ansehen")
            }.buttonStyle(.plain)
                .font(.title3.bold())
                .foregroundColor(onHover ? Color.primary.opacity(0.9) : Color.primary.opacity(0.5))
                .onHover(perform: { hovering in
                    withAnimation(.spring()){
                        self.onHover = hovering
                    }
                })
        }.font(.title3)
            .padding()
            .animation(.spring(),value: showDetail)
    }
}

#Preview {
    OrderCellView(order: orderExammple, showDetail: .constant(false))
}
