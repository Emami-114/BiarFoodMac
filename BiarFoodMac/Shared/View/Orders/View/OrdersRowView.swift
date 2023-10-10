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
    OrdersRowView(order: orderExammple)
}
