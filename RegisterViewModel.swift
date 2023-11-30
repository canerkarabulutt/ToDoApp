//
//  RegisterViewModel.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 15.09.2023.
//

import UIKit

struct RegisterViewModel {
    var emailText: String?
    var passwordText: String?
    var nameText: String?
    var usernameText: String?
    
    var status: Bool {
        return emailText?.isEmpty == false && passwordText?.isEmpty == false && nameText?.isEmpty == false && usernameText?.isEmpty == false
    }
}

