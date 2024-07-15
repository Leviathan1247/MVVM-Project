//
//  LoginViewModel.swift
//  WelcomePatternMVVM
//
//  Created by Левиафан on 2024-07-11.
//

import Foundation

final class LoginViewModel {
    
    @Published var error:String?
    
    
    private let loginService: LoginServiceProtocol
    
    init(loginService: LoginServiceProtocol = Network.shared) {
            self.loginService = loginService
        }
    
    func login(email: String, password: String) {
        Network.shared.login(email: email, password: password) { [weak self] success in
            DispatchQueue.main.async {
                self?.error = success ? nil : "Incorrect login or password"
            }
        }
        
    }
    
}
