//
//  ProfileViewModel.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 24.09.2023.
//

import Foundation

struct ProfileViewModel {
    var user: UserModel
    init(user: UserModel) {
        self.user = user
    }
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    var name: String? {
        return user.name
    }
    var username: String? {
        return user.username
    }
    var email: String? {
        return user.email
    }
}
