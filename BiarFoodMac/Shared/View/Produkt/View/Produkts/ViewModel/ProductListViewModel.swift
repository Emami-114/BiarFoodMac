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
    @Published var categories = [Category]()
    @Published var selectedCategory = ""
    let productRepository = ProductRepository.shared
    let storageRepository = StorageRepository.shared
    let categoriesRepository = CategorieRepository.shared
    @Published var products = [Product]()
    init() {
        productRepository.products
            .dropFirst()
            .sink{ [weak self] products in
                guard let self else { return }
                self.products = products                
            }
            .store(in: &cancellables)
        
        categoriesRepository.categories.sink{[weak self] categories in
            guard let self else {return}
            self.categories = categories.filter({ category in
                category.type == "Main"
            })
        }.store(in: &cancellables)
        
        fetchCategories()
        selectFirstCategory()

    }
    
    func selectFirstCategory(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
            self.selectedCategory = self.categories.first?.id ?? ""
        }
    }
    
    func fetchProducts(with catId: String){
        productRepository.fetchProducts(with: catId)
    }
    func fetchCategories(){
        categoriesRepository.fetchCatrgories()
    }
    
    func deleteProduct(wit id: String,imageurl:String){
        productRepository.deleteProduct(with: id)
        if !imageurl.isEmpty{
            storageRepository.deleteImage(with: imageurl)
        }
        
    }
}
