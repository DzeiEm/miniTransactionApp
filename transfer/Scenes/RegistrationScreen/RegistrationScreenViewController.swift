

import Foundation
import UIKit


class RegistrationScreenViewController: UIViewController {
    
    var authManager = AuthManager()
    let design = DesignSettings()
   
    // MARK: - IBoutlets
    @IBOutlet private weak var usernameTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var confirmPasswordTextfield: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var registrationTypeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var buttonView: UIButton!
        
    // MARK: - IBactions
    @IBAction func segmentControllerSwitched(_ sender: UISegmentedControl) {
        errorLabel.isHidden = true
        
        if sender.selectedSegmentIndex == 0 {
            registrationTypeSegmentedControl.backgroundColor = UIColor.systemPurple
            confirmPasswordTextfield.isHidden = false
            design.buttonDisplayView(
                button: buttonView,
                lableTitle: "Register",
                roundByValue: 22,
                buttonColor: UIColor.systemPurple,
                fontColor: UIColor.white)
            
        } else {
            registrationTypeSegmentedControl.backgroundColor = UIColor.systemPurple
            confirmPasswordTextfield.isHidden = true
            design.buttonDisplayView(
                button: buttonView,
                lableTitle: "Login",
                roundByValue: 22,
                buttonColor: UIColor.systemPurple,
                fontColor: UIColor.white)
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if registrationTypeSegmentedControl.selectedSegmentIndex == 0 {
            let success = authManager.register(username: usernameTextfield.text!, password: passwordTextfield.text!, confirmPassword: confirmPasswordTextfield.text!)
            
            if !success {
                let message = authManager.errorMessage
                errorLabel.isHidden = false
                errorLabel.text = message
                errorLabel.textColor = UIColor.red
                return
            }
            design.cleanTextfieldInput(txt: usernameTextfield)
            design.cleanTextfieldInput(txt: passwordTextfield)
            design.cleanTextfieldInput(txt: confirmPasswordTextfield)
            errorLabel.text = ""
            let homeViewController = HomeScreenViewController()
            homeViewController.authManager = authManager
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            let message = authManager.login(username: usernameTextfield.text!, password: passwordTextfield.text!)
            
            if message != "" {
                errorLabel.isHidden = false
                errorLabel.text = message
                errorLabel.textColor = UIColor.red
                // MARK: - Bug with button label title
                return
            }
            design.cleanTextfieldInput(txt: usernameTextfield)
            design.cleanTextfieldInput(txt: passwordTextfield)
            design.cleanTextfieldInput(txt: confirmPasswordTextfield)
            errorLabel.text = ""
            let homeViewController = HomeScreenViewController()
            homeViewController.authManager = authManager
            navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    override func viewDidLoad() {
        errorLabel.isHidden = true
        // MARK: - dont like written logic here. Also, bug appears :/
        buttonView.titleLabel?.text = "Register"
        buttonView.titleLabel?.textColor = UIColor.black
        design.buttonDisplayView(
            button: buttonView,
            lableTitle: "Register",
            roundByValue: 22,
            buttonColor: UIColor.systemPurple,
            fontColor: UIColor.white)
        registrationTypeSegmentedControl.backgroundColor = UIColor.systemPurple
    }
}
