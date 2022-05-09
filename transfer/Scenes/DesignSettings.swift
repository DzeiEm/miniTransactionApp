

import Foundation
import UIKit


class DesignSettings {
    

    func buttonDisplayView(button: UIButton, lableTitle: String, roundByValue: Int, buttonColor: UIColor, fontColor: UIColor) {
        button.layer.cornerRadius = CGFloat(roundByValue)
        button.titleLabel?.text = lableTitle
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = buttonColor
        button.titleLabel?.textColor = fontColor
    }
    
     func cleanTextfieldInput(txt: UITextField) {
        txt.text = ""
    }
}
