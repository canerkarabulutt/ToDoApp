//
//  LogInViewModel.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 15.09.2023.
//

import UIKit

struct LogInViewModel {
    var emailText: String?
    var passwordText: String?
    
    var status: Bool {
        return emailText?.isEmpty == false && passwordText?.isEmpty == false
    }
}
