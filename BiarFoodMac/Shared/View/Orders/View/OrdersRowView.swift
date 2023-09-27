//
//  OrdersRowView.swift
//  BiarFoodMac
//
//  Created by Ecc on 26/09/2023.
//

import SwiftUI

struct OrdersRowView: View {
    let order: Order
    @State var showDetail: Bool = false
    var body: some View {
        VStack{
            OrderCellView(order: order, showDetail: $showDetail)
            Divider()
            if showDetail{
                ScrollView(){
                    LazyVStack(alignment: .leading){
                        ForEach(order.products,id: \.id){product in
                        OrderProductCellView(orderProduct: product)
                            Divider()
                        }
                    }
                }.padding()
                    .scrollIndicators(.hidden)
                .background{
                    RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 0.5)
                        
                }
                .background(BlurView())
                .padding(.top,15)
            }
           
        }.padding()
            .animation(.spring(), value: showDetail)
    }
}

#Preview {
    OrdersRowView(order: .init(userId: "", successful: true, customerName: "Abdul Emami", customerAdress: "Stauffenbergstr.14", customerZip: "07747", customerCity: "Jena", deliveryDate: Date(), paymentType: "Paypal", paymentSuccess: true, products: [OrderProduct(id: "", name: "Bier", quantity: 2, netWeight: "330g", depositType: "Mehrweg", depositPrice: 3.30, imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/biarfood-77cad.appspot.com/o/product_images%2F141456CA-0873-4C75-BB12-BCED6D22E475?alt=media&token=9805d806-4299-4d47-a954-fb85c971e8bc", price: 13.90, tax: 19)]))
}
