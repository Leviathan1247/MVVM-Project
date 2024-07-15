//
//  Network.swift
//  WelcomePatternMVVM
//
//  Created by Левиафан on 2024-07-11.
//


import Foundation

protocol LoginServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Bool) -> Void)
}

protocol UserServiceProtocol {
    func getLogInUser() -> User?
}


final class Network: LoginServiceProtocol, UserServiceProtocol {
    
    static let shared = Network()
    
    private var user: User?
    
    private init() {}
    
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
           DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
               if email == "SteveJobs@apple.com" && password == "password" {
                   self?.user = User(firstname: "Steve", lastName: "Jobs", email: email, age: 40)
                   completion(true)
               } else {
                   self?.user = nil
                   completion(false)
               }
           }
       }
       
       func getLogInUser() -> User? {
           return user
       }
   }

