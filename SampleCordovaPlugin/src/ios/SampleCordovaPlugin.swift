//
//  SampleCordovaPlugin.swift
//  
//
//  Created by Bharani Cherukuri on 5/17/20.
//

import Foundation

@objc(SampleCordovaPlugin) class SampleCordovaPlugin : CDVPlugin {
    
    private let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 120, width: 300, height: 40))
    private let sampleField =  UITextField(frame: CGRect(x: 20, y: 200, width: 300, height: 40))
    private var pluginResult = CDVPluginResult(
        status: CDVCommandStatus_ERROR,
        messageAs: ""
    )
    private var result = ""
    private var command: CDVInvokedUrlCommand?
    
    @objc(sampleMethod:)
    public func sampleMethod(_ command: CDVInvokedUrlCommand) {
        self.command = command
        
        let label = UILabel(frame: CGRect(x: 20, y: 80, width: 300, height: 40))
        label.textAlignment = .left
        label.text = "Check if a number is even/odd"
        self.viewController?.view.addSubview(label)
        
        let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 120, width: 300, height: 40))
        sampleTextField.placeholder = "Enter a number here"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.delegate = self
        sampleTextField.tag = 1
        self.viewController?.view.addSubview(sampleTextField)
        
        let palindromeLabel = UILabel(frame: CGRect(x: 20, y: 170, width: 300, height: 40))
        palindromeLabel.textAlignment = .left
        palindromeLabel.text = "Check if a number is palindrome"
        self.viewController?.view.addSubview(palindromeLabel)
        
        let sampleField =  UITextField(frame: CGRect(x: 20, y: 200, width: 300, height: 40))
        sampleField.placeholder = "Enter a number here"
        sampleField.font = UIFont.systemFont(ofSize: 15)
        sampleField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleField.autocorrectionType = UITextAutocorrectionType.no
        sampleField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleField.delegate = self
        sampleField.tag = 2
        self.viewController?.view.addSubview(sampleField)
    }
}

extension SampleCordovaPlugin {
    private func processingText(_ text: String) {
        let number = Int(text) ?? nil
        guard let tempNumber = number else { return }
        if (tempNumber % 2 == 0) {
            displayAlert("Even number")
        } else {
            displayAlert("Odd number")
        }
    }
    
    private func checkPalindrome(_ text: String) {
        if text.lowercased() == String(text.lowercased().reversed()) {
            displayAlert("String is palindrome")
        } else {
            displayAlert("String is not palindrome")
        }
    }
    
    private func displayAlert(_ text: String) {
        callback(result: text)
        let alertController = UIAlertController(title: text,
                                                message: "",
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.viewController?.present(alertController, animated: true, completion: nil)
    }
    
    private func callback(result: String) {
        pluginResult = CDVPluginResult(
          status: CDVCommandStatus_OK,
          messageAs: result
        )
        
        self.commandDelegate.send(
          pluginResult,
          callbackId: command?.callbackId
        )
    }
}

extension SampleCordovaPlugin: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        switch textField.tag {
        case 1:
            self.processingText(text)
            textField.resignFirstResponder()
        case 2:
            self.checkPalindrome(text)
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
