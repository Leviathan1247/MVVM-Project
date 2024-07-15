//
//  HomeViewController.swift
//  WelcomePatternMVVM
//
//  Created by Левиафан on 2024-07-11.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLbl: UILabel!
    
    private let viewModel = HomeViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinders()
        viewModel.getLogInUser()
        
    }
    
    
    private func setupBinders() {
        viewModel.$welcomeMessage.sink { [weak self] message in
            self?.welcomeLbl.text = message
        } .store(in: &cancellables)
    }

}
