//
//  OrderRepository.swift
//  BiarFoodMac
//
//  Created by Ecc on 26/09/2023.
//

import Foundation
import Combine
class OrderRepository {
    static let shared = OrderRepository()
    var orders = CurrentValueSubject<[Order],Never>([])
}

extension OrderRepository {
    func fetchOrders(){
        FirebaseManager.shared.database.collection("orders").addSnapshotListener { QuerySnapshot, error in
            if let error = error {
                print("fetch orders failed : \(error)")
                return
            }
            guard let documents = QuerySnapshot?.documents else {return}
            
            let orders = documents.compactMap { queryDocument -> Order? in
                return try? queryDocument.data(as: Order.self)
            }
            self.orders.send(orders)
        }
    }
}
