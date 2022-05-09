

import Foundation
import UIKit


class HomeScreenViewController: UIViewController {
    
    var authManager: AuthManager! // should bepassed before navigation !
    let design = DesignSettings()
    var totalBalance: Double = 0
    var userInputAmount: Double = 0
    var message = ""
    var receiver = ""
    
    // MARK: - IBOutlet
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var receiverTextField: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var transferButtonView: UIButton!
    @IBOutlet weak var instantTopupButtonView: UIButton!
    @IBOutlet weak var logoutButtonView: UIButton!
    
    //MARK: - IBAction
    @IBAction func transferButtonTapped(_ sender: UIButton) {
        
        if receiverTextField.text == "" && amountTextfield.text == "" {
            displayAlert(title: "🤯 Oooops", message: "Enter receivers' name and amount")
        }
        if receiverTextField.text == "" {
            displayAlert(title: "🤦‍♀️ Oooops ", message: "Enter receivers'name")
        }
        let userValid = validateUser(receiver: receiverTextField.text!)
        if !userValid {
            displayAlert(title: "🙈 Oooops", message: "Looooks like no such user")
            return
        } else {
            cleanTextfieldInput(txt: receiverTextField)
            cleanTextfieldInput(txt: amountTextfield)
            print("Success! All good")
        }
    }
    
    @IBAction func instantTopup(_ sender: UIButton) {
        totalBalance = totalBalance + 100
        balanceLabel.text = "Your balance: \(totalBalance) EUR"
        //MARK: - bug with balance, in case money hass been transsfered to user
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.orange
        usernameLabel.text = " Hello, \(authManager.currentUser.username)"
        balanceLabel.text = "Your balance: \(totalBalance) EUR"
        instantTopupButtonView.titleLabel?.textColor = UIColor.orange
        design.buttonDisplayView(
            button: transferButtonView,
            lableTitle: "Transfer",
            roundByValue: 20,
            buttonColor: UIColor.orange,
            fontColor: UIColor.white)
        logoutButtonView.titleLabel?.textColor = UIColor.black
    }
    
    private func validateTransferAmount() -> Bool {
        userInputAmount = Double(amountTextfield.text!)!
        
        if String(userInputAmount) == "" {
            return false
        }
        if totalBalance <= userInputAmount {
            displayAlert(title: "🫥 Ooops", message: "You are trying to transfer more than you have")
            return false
        }
        return true
    }
    
    private func validateUser(receiver: String) -> Bool {
        let users = authManager.users
        
        for receiver in users {
            let exist = users.contains(where: {
                $0.username == receiver.username && $0.username != authManager.currentUser.username
            })
            if exist  {
                let amountValid = validateTransferAmount()
                if !amountValid {
                    displayAlert(title: " 🥴 Oooops", message: "Dont be a miser, pass some money, zero is not a money")
                    return true
                }
                totalBalance = totalBalance - userInputAmount
                receiver.accountBalance = receiver.accountBalance + userInputAmount
                balanceLabel.text = "Your balance: \(totalBalance)EUR"
                return true
            }
        }
        return false
    }
    
    private func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func cleanTextfieldInput(txt: UITextField) {
        txt.text = ""
    }
}

