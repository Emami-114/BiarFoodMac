//
//  OrdersListView.swift
//  BiarFoodMac
//
//  Created by Ecc on 26/09/2023.
//

import SwiftUI

struct OrdersListView: View {
    @StateObject var viewModel = OrdersViewModel()
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack{
                    ForEach(viewModel.orders,id: \.id){order in
                        OrdersRowView(order: order)
                    }
                }
            }
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    OrdersListView()
}
