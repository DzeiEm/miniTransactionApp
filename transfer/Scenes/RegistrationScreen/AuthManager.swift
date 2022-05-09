

import Foundation
import UIKit


class AuthManager {
    
    var users: [User] = []
    var currentUser: User!
    var errorMessage = ""
    
    
    func register(username: String, password: String, confirmPassword: String) -> Bool {
        
        let isValid = validateRegistrationTextfields(username: username, password: password, confirmPassword: confirmPassword)
        
        if isValid {
            let user = User(username: username, password: password)
            currentUser = user
            users.append(currentUser)
            return true
        } else {
            return false
        }
    }
    
    func login(username: String, password: String) -> String {
        
        if !username.isEmpty || !password.isEmpty {
            for user in users {
                if user.username == username && user.password == password {
                    currentUser = user
                    return ""
                }
                if user.username != username || user.password != password {
                    return "Incorrect username or password"
                }
            }
        }
        return "Credentials not entered"
    }
    
    func validateRegistrationTextfields(username: String, password: String, confirmPassword: String) -> Bool {
        
        if username.isEmpty && password.isEmpty && confirmPassword.isEmpty {
            errorMessage = "Fields cannot be empty"
            return false
        }
        if username.isEmpty && (password.isEmpty || confirmPassword.isEmpty) {
            errorMessage = "Fields cannot be empty"
            return false
        }
        if password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Password cannot be empty"
            return false
        }
        if password != confirmPassword {
            errorMessage = "Password does not match"
            return false
        }
        if !isCredentionLengthValid(username: username, pass: password) {
            errorMessage = "Username and password should contain at least 8 characters"
            return false
        }
        if checkIfUserExist(username: username) {
            errorMessage = "User already exist"
            return false
        }
        return true
       
    }
    
    private func isCredentionLengthValid(username: String, pass: String) -> Bool {
        
        if username.count >= 3 && pass.count >= 3 {
            return true
        } else {
            return false
        }
    }
    
    private func checkIfUserExist(username: String) -> Bool {
    
        for user in users {
            if username == user.username{
                return true
            }
        }
        return false
    }
}
