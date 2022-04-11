//
//  codeValidation.swift
//  E4 Patient
//
//  Created by mohab on 26/02/2021.
//

import  UIKit
extension ConfirmAccountVC: UITextFieldDelegate {
    func SetUpTextShadow(txt: UITextField){
        txt.layer.cornerRadius = 10
        txt.layer.shadowColor = UIColor.black.cgColor
        txt.layer.shadowOpacity = 0.5
        txt.layer.shadowOffset = CGSize.zero
        txt.layer.shadowRadius = 4
        txt.backgroundColor = UIColor.white
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // On inputing value to textfield
        if ((textField.text?.count)! < 1  && string.count > 0){
            if(textField == code1Txt)
            {
                code2Txt.becomeFirstResponder()
            }
            if(textField == code2Txt)
            {
                code3Txt.becomeFirstResponder()
            }
            if(textField == code3Txt)
            {
                code4Txt.becomeFirstResponder()
            }
            if(textField == code4Txt)
            {
                code5Txt.becomeFirstResponder()
            }
            if(textField == code5Txt)
            {
                code6Txt.becomeFirstResponder()
            }

            textField.text = string
            return false
        }
        else if ((textField.text?.count)! >= 1  && string.count == 0){
            // on deleting value from Textfield
            if(textField == code2Txt)
            {
                code1Txt.becomeFirstResponder()
            }
            if(textField == code3Txt)
            {
                code2Txt.becomeFirstResponder()
            }
            if(textField == code4Txt)
            {
                code3Txt.becomeFirstResponder()
            }
            if(textField == code5Txt)
            {
                code4Txt.becomeFirstResponder()
            }
            if(textField == code6Txt)
            {
                code5Txt.becomeFirstResponder()
            }
            textField.text = ""
            return false
        }
        else if ((textField.text?.count)! >= 1  )
        {
            textField.text = string
            return false
        }
        return true
    }

}
