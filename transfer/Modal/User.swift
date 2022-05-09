
import Foundation

class User {
    let username: String
    let password: String
    var accountBalance: Double
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        accountBalance = 0
    }
    
}
