//
//  OrdersViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 26/09/2023.
//

import Foundation
import Combine
class OrdersViewModel: ObservableObject {
    @Published var orders = [Order]()
    let orderRepository = OrderRepository.shared
    var cancellables = Set<AnyCancellable>()
    
    
    init(){
        orderRepository.orders.sink{[weak self] orders in
            guard let self else {return}
            self.orders = orders
        }.store(in: &cancellables)
        
        fetchOrders()
    }
    
    
    func fetchOrders(){
        orderRepository.fetchOrders()
    }
}
