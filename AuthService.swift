//
//  AuthService.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 16.09.2023.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

struct AuthRegisterUserModel {
    let emailText: String
    let passwordText: String
    let usernameText: String
    let nameText: String
    let profileImage: UIImage
}

struct AuthService {
    
    static func login(emailText: String, passwordText: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: emailText, password: passwordText, completion: completion)
    }
    
    static func createUser(user: AuthRegisterUserModel, completion: @escaping(Error?) -> Void) {
        
        guard let profileImageData = user.profileImage.jpegData(compressionQuality: 0.5) else { return }
        let fileName = NSUUID().uuidString
        let reference = Storage.storage().reference(withPath: "images/profile_images/\(fileName)")
        reference.putData(profileImageData) { metaData, error in
            if let error = error {
                print("Error... \(error.localizedDescription)")
            }
            reference.downloadURL { url, error in
                if let error = error {
                    print("Error... \(error.localizedDescription)")
                    return
                }
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: user.emailText, password: user.passwordText) { result, error in
                    guard let uid = result?.user.uid else { return }
                    let data = [
                        "email": user.emailText,
                        "username": user.usernameText,
                        "name": user.nameText,
                        "profileImageUrl": profileImageUrl,
                        "uid": uid
                    ] as [String: Any]
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
        }
    }
}

