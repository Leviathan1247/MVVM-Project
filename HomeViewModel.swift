//
//  HomeViewModel.swift
//  WelcomePatternMVVM
//
//  Created by Левиафан on 2024-07-11.
//

import Foundation


final class HomeViewModel {
    
    @Published var welcomeMessage: String?
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = Network.shared) {
            self.userService = userService
        }
    
    
    func getLogInUser() {
        
        if let user = Network.shared.getLogInUser() {
        self.welcomeMessage = "Hello, \(user.firstname) \(user.lastName) !"
        
    } else {
        
        self.welcomeMessage = "User not found."
        
    }
     
    }
}


