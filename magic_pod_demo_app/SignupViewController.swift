//
//  ViewController.swift
//  magic_pod_demo_app
//
//  Created by Hidenori Kojima on 2016/07/17.
//  Copyright © 2016年 TRIDENT. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    fileprivate var nameField: UITextField!
    fileprivate var nameError: UILabel!
    fileprivate var sexField: UITextField!
    fileprivate var sexError: UILabel!
    fileprivate var registerButton: UIButton!
    fileprivate var messageView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ユーザー登録"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 56 / 255.0, green: 142 / 255.0, blue: 60 / 255.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        view.backgroundColor = UIColor(red: 236 / 255.0, green: 240 / 255.0, blue: 241 / 255.0, alpha: 1.0)
        nameField = createInputField(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 56.0), text: "    名前")
        sexField = createInputField(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 56.0), text: "    性別")
        nameError = createErrorLabel(y: nameField.frame.origin.y + nameField.bounds.size.height + 8.0)
        sexError = createErrorLabel(y: sexField.frame.origin.y + sexField.bounds.size.height + 8.0)
        registerButton = self.createButton(title: "登録", target: self,selector: #selector(SignupViewController.registerPressed(_:)), event: UIControl.Event.touchUpInside)
        messageView = createMessageView()
        view.addSubview(nameField)
        view.addSubview(sexField)
        view.addSubview(nameError)
        view.addSubview(sexError)
        view.addSubview(registerButton)
        view.addSubview(messageView)

        let tgr = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.dismissKeyboard))
        view.addGestureRecognizer(tgr)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func registerPressed(_ sender: UIButton) {
        dismissKeyboard()

        nameError.alpha = 0
        sexError.alpha = 0

        var valid = true
        if (nameField.text == "") {
            UIView.animate(withDuration: 0.25, animations: { self.nameError.alpha = 1.0 })
            valid = false;
        }
        if (sexField.text == "") {
            UIView.animate(withDuration: 0.25, animations: { self.sexError.alpha = 1.0 })
            valid = false;
        }
        if (!valid) { return }

        let alert = UIAlertController(title: nil, message: "登録しています...", preferredStyle: .alert)

        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)

        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.dismiss(animated: false, completion: nil)
            self.nameField.isEnabled = false
            self.nameField.textColor = UIColor.gray
            self.sexField.isEnabled = false
            self.sexField.textColor = UIColor.gray
            UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions(), animations: {
                let frame = self.messageView.frame
                self.messageView.frame = CGRect(x: frame.origin.x, y: frame.origin.y - frame.size.height, width: frame.size.width, height: frame.size.height)
                self.registerButton.alpha = 0
            }, completion: { (Bool) in

                self.registerButton.isHidden = true

                let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions(), animations: {
                        let frame = self.messageView.frame
                        self.messageView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.size.height, width: frame.size.width, height: frame.size.height)
                    }, completion: nil)
                }

            })
        }
    }
    
    func createMessageView() -> UIView{
        messageView = UIView(frame: CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 64.0))
        messageView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        let label = UILabel()
        label.text = "登録しました！"
        label.textColor = UIColor.white
        label.sizeToFit()
        label.frame = CGRect(x: 15, y: (messageView.bounds.size.height - label.frame.height) / 2.0, width: label.bounds.size.width, height: label.bounds.size.height)
        messageView.addSubview(label)
        return messageView
    }
    
    func createButton(title: String, target: Any?, selector: Selector, event:UIControl.Event) -> (UIButton) {
        let button = UIButton(frame: CGRect(x: 30, y: 304, width: view.frame.width - 60, height: 56.0))
        button.setTitle(title, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.setBackgroundImage(UIImage(named: "ButtonBase"), for: UIControl.State())
        button.setBackgroundImage(UIImage(named: "ButtonBasePressed"), for: UIControl.State.highlighted)
        button.addTarget(target, action: selector, for: event)
        return button
    }
    
    func createErrorLabel(y: CGFloat) -> (UILabel) {
        let label = UILabel()
        label.text = "入力してください"
        label.textColor = UIColor(red: 231 / 255.0, green: 76 / 255.0, blue: 60 / 255.0, alpha: 1.0)
        label.font = label.font.withSize(12.0)
        label.sizeToFit()
        label.frame = CGRect(x: 72, y: y, width: label.bounds.size.width, height: label.bounds.size.height)
        label.alpha = 0
        return label
    }
    
    func createInputField(frame: CGRect, text: String) -> (UITextField) {
        let inputField = UITextField(frame: frame)
        inputField.clearButtonMode = UITextField.ViewMode.whileEditing
        inputField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        inputField.backgroundColor = UIColor.white
        inputField.returnKeyType = UIReturnKeyType.done
        inputField.delegate = self
        inputField.leftView = self.createLeftView(text: text)
        inputField.leftViewMode = UITextField.ViewMode.always
        inputField.layer.addSublayer(self.createTopBorder(width: inputField.bounds.size.width))
        inputField.layer.addSublayer(self.createBottomBorder(height: inputField.bounds.size.height, width: inputField.bounds.size.width))
        return inputField
    }
    
    func createLeftView(text: String) -> (UILabel) {
        let leftView = UILabel()
        leftView.text = text
        leftView.sizeToFit()
        let frame = leftView.frame
        leftView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width + 24.0, height: frame.size.height)
        return leftView
    }
    
    func createTopBorder(width: CGFloat) -> (CALayer) {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: width, height: 0.5)
        topBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).cgColor
        return topBorder
    }

    func createBottomBorder(height: CGFloat, width: CGFloat) -> (CALayer) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: height - 0.5, width: width, height: 0.5)
        bottomBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).cgColor
        return bottomBorder
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

