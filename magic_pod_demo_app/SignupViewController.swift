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
    fileprivate var nameError: UILabel = UILabel()
    fileprivate var sexField: UITextField!
    fileprivate var sexError: UILabel = UILabel()
    fileprivate var registerButton: UIButton!
    fileprivate var messageView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ユーザー登録"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 56 / 255.0, green: 142 / 255.0, blue: 60 / 255.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        view.backgroundColor = UIColor(red: 236 / 255.0, green: 240 / 255.0, blue: 241 / 255.0, alpha: 1.0)

        nameField = UITextField(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 56.0))
        nameField.clearButtonMode = UITextFieldViewMode.whileEditing
        nameField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        nameField.backgroundColor = UIColor.white
        nameField.returnKeyType = UIReturnKeyType.done
        nameField.delegate = self
        var leftView = UILabel()
        leftView.text = "    名前"
        leftView.sizeToFit()
        var frame = leftView.frame
        leftView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width + 24.0, height: frame.size.height)
        nameField.leftView = leftView
        nameField.leftViewMode = UITextFieldViewMode.always
        var topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: nameField.bounds.size.width, height: 0.5)
        topBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).cgColor
        nameField.layer.addSublayer(topBorder)
        var bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: nameField.bounds.size.height - 0.5, width: nameField.bounds.size.width, height: 0.5)
        bottomBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).cgColor
        nameField.layer.addSublayer(bottomBorder)
        view.addSubview(nameField)

        nameError.text = "入力してください"
        nameError.textColor = UIColor(red: 231 / 255.0, green: 76 / 255.0, blue: 60 / 255.0, alpha: 1.0)
        nameError.font = nameError.font.withSize(12.0)
        nameError.sizeToFit()
        nameError.frame = CGRect(x: 72, y: nameField.frame.origin.y + nameField.bounds.size.height + 8.0, width: nameError.bounds.size.width, height: nameError.bounds.size.height)
        nameError.alpha = 0
        view.addSubview(nameError)

        sexField = UITextField(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 56.0))
        sexField.clearButtonMode = UITextFieldViewMode.whileEditing
        sexField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        sexField.backgroundColor = UIColor.white
        sexField.returnKeyType = UIReturnKeyType.done
        sexField.delegate = self
        leftView = UILabel()
        leftView.text = "    性別"
        leftView.sizeToFit()
        frame = leftView.frame
        leftView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width + 24.0, height: frame.size.height)
        sexField.leftView = leftView
        sexField.leftViewMode = UITextFieldViewMode.always
        topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: sexField.bounds.size.width, height: 0.5)
        topBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).cgColor
        sexField.layer.addSublayer(topBorder)
        bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: sexField.bounds.size.height - 0.5, width: sexField.bounds.size.width, height: 0.5)
        bottomBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).cgColor
        sexField.layer.addSublayer(bottomBorder)
        view.addSubview(sexField)

        sexError.text = "入力してください"
        sexError.textColor = UIColor(red: 231 / 255.0, green: 76 / 255.0, blue: 60 / 255.0, alpha: 1.0)
        sexError.font = sexError.font.withSize(12.0)
        sexError.sizeToFit()
        sexError.frame = CGRect(x: 72, y: sexField.frame.origin.y + sexField.bounds.size.height + 8.0, width: sexError.bounds.size.width, height: sexError.bounds.size.height)
        sexError.alpha = 0
        view.addSubview(sexError)

        registerButton = UIButton(frame: CGRect(x: 30, y: 304, width: view.frame.width - 60, height: 56.0))
        registerButton.setTitle("登録", for: UIControlState())
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        registerButton.setBackgroundImage(UIImage(named: "ButtonBase"), for: UIControlState())
        registerButton.setBackgroundImage(UIImage(named: "ButtonBasePressed"), for: UIControlState.highlighted)
        registerButton.addTarget(self, action: #selector(SignupViewController.registerPressed(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(registerButton)

        messageView = UIView(frame: CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 64.0))
        messageView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        let label = UILabel()
        label.text = "登録しました！"
        label.textColor = UIColor.white
        label.sizeToFit()
        label.frame = CGRect(x: 15, y: (messageView.bounds.size.height - label.frame.height) / 2.0, width: label.bounds.size.width, height: label.bounds.size.height)
        messageView.addSubview(label)
        view.addSubview(messageView)

        let tgr = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.dismissKeyboard))
        view.addGestureRecognizer(tgr)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func registerPressed(_ sender: UIButton) {
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
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
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
            UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions(), animations: {
                let frame = self.messageView.frame
                self.messageView.frame = CGRect(x: frame.origin.x, y: frame.origin.y - frame.size.height, width: frame.size.width, height: frame.size.height)
                self.registerButton.alpha = 0
            }, completion: { (Bool) in

                self.registerButton.isHidden = true

                let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions(), animations: {
                        let frame = self.messageView.frame
                        self.messageView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.size.height, width: frame.size.width, height: frame.size.height)
                    }, completion: nil)
                }

            })
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
}

