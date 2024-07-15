//
//  LoginViewController.swift
//  WelcomePatternMVVM
//
//  Created by Левиафан on 2024-07-11.
//


import UIKit
import Combine

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private let viewModel = LoginViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinders()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupBinders() {
        viewModel.$error.sink { [weak self] error in
            if let error = error {
                self?.showErrorAlert(message: error)
            } else {
                self?.goToHomePage()
            }
        }.store(in: &cancellables)
        
    }
    
    private func showErrorAlert(message: String) {
           let alert = UIAlertController(title: "Incorrect login or password", message: "Check your data and try again", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
    
    
    private func goToHomePage() {
            guard let controller = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else {
                return
            }
            present(controller, animated: true, completion: nil)
        }
    
        
        
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        guard let email = emailField.text,
              let password = passwordField.text, !email.isEmpty, !password.isEmpty  else {
            showErrorAlert(message: "Please enter email or password")
            return
        }
        
        viewModel.login(email: email, password: password)
               
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        dismissKeyboard()
    }
   
}
