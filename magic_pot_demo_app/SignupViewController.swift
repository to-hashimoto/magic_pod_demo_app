//
//  ViewController.swift
//  magic_pot_demo_app
//
//  Created by Hidenori Kojima on 2016/07/17.
//  Copyright © 2016年 TRIDENT. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    private var nameField: UITextField!
    private var nameError: UILabel = UILabel()
    private var sexField: UITextField!
    private var sexPicker: UIPickerView!
    private var sexError: UILabel = UILabel()
    private var registerButton: UIButton!
    private var messageView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ユーザー登録"
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor(red: 56 / 255.0, green: 142 / 255.0, blue: 60 / 255.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        view.backgroundColor = UIColor(red: 236 / 255.0, green: 240 / 255.0, blue: 241 / 255.0, alpha: 1.0)

        nameField = UITextField(frame: CGRectMake(0, 100, view.frame.width, 56.0))
        nameField.clearButtonMode = UITextFieldViewMode.WhileEditing
        nameField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        nameField.backgroundColor = UIColor.whiteColor()
        nameField.returnKeyType = UIReturnKeyType.Done
        nameField.delegate = self
        var leftView = UILabel()
        leftView.text = "    名前"
        leftView.sizeToFit()
        var frame = leftView.frame
        leftView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width + 24.0, frame.size.height)
        nameField.leftView = leftView
        nameField.leftViewMode = UITextFieldViewMode.Always
        var topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, nameField.bounds.size.width, 0.5)
        topBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).CGColor
        nameField.layer.addSublayer(topBorder)
        var bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0, nameField.bounds.size.height - 0.5, nameField.bounds.size.width, 0.5)
        bottomBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).CGColor
        nameField.layer.addSublayer(bottomBorder)
        view.addSubview(nameField)

        nameError.text = "入力してください"
        nameError.textColor = UIColor(red: 231 / 255.0, green: 76 / 255.0, blue: 60 / 255.0, alpha: 1.0)
        nameError.font = nameError.font.fontWithSize(12.0)
        nameError.sizeToFit()
        nameError.frame = CGRectMake(72, nameField.frame.origin.y + nameField.bounds.size.height + 8.0, nameError.bounds.size.width, nameError.bounds.size.height)
        nameError.alpha = 0
        view.addSubview(nameError)

        sexField = UITextField(frame: CGRectMake(0, 200, view.frame.width, 56.0))
        sexField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        sexField.backgroundColor = UIColor.whiteColor()
        leftView = UILabel()
        leftView.text = "    性別"
        leftView.sizeToFit()
        frame = leftView.frame
        leftView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width + 24.0, frame.size.height)
        sexField.leftView = leftView
        sexField.leftViewMode = UITextFieldViewMode.Always
        topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, sexField.bounds.size.width, 0.5)
        topBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).CGColor
        sexField.layer.addSublayer(topBorder)
        bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0, sexField.bounds.size.height - 0.5, sexField.bounds.size.width, 0.5)
        bottomBorder.backgroundColor = UIColor(red: 149 / 255.0, green: 165 / 255.0, blue: 166 / 255.0, alpha: 1.0).CGColor
        sexField.layer.addSublayer(bottomBorder)
        view.addSubview(sexField)

        sexError.text = "入力してください"
        sexError.textColor = UIColor(red: 231 / 255.0, green: 76 / 255.0, blue: 60 / 255.0, alpha: 1.0)
        sexError.font = sexError.font.fontWithSize(12.0)
        sexError.sizeToFit()
        sexError.frame = CGRectMake(72, sexField.frame.origin.y + sexField.bounds.size.height + 8.0, sexError.bounds.size.width, sexError.bounds.size.height)
        sexError.alpha = 0
        view.addSubview(sexError)

        sexPicker = UIPickerView()
        sexPicker.delegate = self
        sexPicker.dataSource = self
        sexField.inputView = sexPicker

        registerButton = UIButton(frame: CGRectMake(30, 324, view.frame.width - 60, 56.0))
        registerButton.setTitle("登録", forState: UIControlState.Normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFontOfSize(20.0)
        registerButton.setBackgroundImage(UIImage(named: "ButtonBase"), forState: UIControlState.Normal)
        registerButton.setBackgroundImage(UIImage(named: "ButtonBasePressed"), forState: UIControlState.Highlighted)
        registerButton.addTarget(self, action: #selector(SignupViewController.registerPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(registerButton)

        messageView = UIView(frame: CGRectMake(0, view.bounds.height, view.bounds.width, 64.0))
        messageView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        let label = UILabel()
        label.text = "登録しました！"
        label.textColor = UIColor.whiteColor()
        label.sizeToFit()
        label.frame = CGRectMake(15, (messageView.bounds.size.height - label.frame.height) / 2.0, label.bounds.size.width, label.bounds.size.height)
        messageView.addSubview(label)
        view.addSubview(messageView)

        let tgr = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.dismissKeyboard))
        view.addGestureRecognizer(tgr)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return ""
        } else if row == 1 {
            return "男性"
        } else {
            return "女性"
        }
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            sexField.text = ""
        } else if row == 1 {
            sexField.text = "男性"
        } else {
            sexField.text = "女性"
        }
    }

    func registerPressed(sender: UIButton) {
        dismissKeyboard()

        nameError.alpha = 0
        sexError.alpha = 0

        var valid = true
        if (nameField.text == "") {
            UIView.animateWithDuration(0.25, animations: { self.nameError.alpha = 1.0 })
            valid = false;
        }
        if (sexField.text == "") {
            UIView.animateWithDuration(0.25, animations: { self.sexError.alpha = 1.0 })
            valid = false;
        }
        if (!valid) { return }

        let alert = UIAlertController(title: nil, message: "登録しています...", preferredStyle: .Alert)

        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        presentViewController(alert, animated: true, completion: nil)

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(false, completion: nil)
            self.nameField.enabled = false
            self.nameField.textColor = UIColor.grayColor()
            self.sexField.enabled = false
            self.sexField.textColor = UIColor.grayColor()
            UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                let frame = self.messageView.frame
                self.messageView.frame = CGRectMake(frame.origin.x, frame.origin.y - frame.size.height, frame.size.width, frame.size.height)
                self.registerButton.alpha = 0
            }, completion: { (Bool) in

                self.registerButton.hidden = true

                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                        let frame = self.messageView.frame
                        self.messageView.frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height)
                    }, completion: nil)
                }

            })
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
}

