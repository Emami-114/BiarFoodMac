//
//  ProductListViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import Foundation
import Combine
class ProductListViewModel : ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    let productRepository = ProductRepository.shared
    let storageRepository = StorageRepository.shared
    @Published var products = [Product]()
    init() {
        
        productRepository.products
            .dropFirst()
            .sink{ [weak self] products in
                guard let self else { return }
                self.products = products                
            }
            .store(in: &cancellables)
        
        fetchProducts()

    }
    
    func fetchProducts(){
        
        productRepository.fetchProducts()
    }
    
    func deleteProduct(wit id: String,imageurl:String){
        productRepository.deleteProduct(with: id)
        if !imageurl.isEmpty{
            storageRepository.deleteImage(with: imageurl)
        }
        
    }
}
