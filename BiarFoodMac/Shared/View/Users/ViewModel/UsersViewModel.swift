//
//  UsersViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/09/2023.
//

import Foundation
import Combine
class UsersViewModel: ObservableObject {
    @Published var users: [User]? = (nil)
    @Published var error: Error? = nil
    var cancellable = Set<AnyCancellable>()
    let userRepository = UsersRepository.shared
    
    init(){
        userRepository.users
            .sink { completion in
                switch completion{
                case .finished: break
                case .failure(let error) :
                    self.error = error
                }
            } receiveValue: { users in
                self.users = users
            }
            .store(in: &cancellable)
        fetchUsers()
        
    }
    
    
    
    
    func fetchUsers(){
        userRepository.fetchUsers()
    }

    func deleteUser(with id: String){
        userRepository.deleteUser(with: id)
    }
    
    
}
