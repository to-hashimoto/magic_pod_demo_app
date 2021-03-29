//
//  ViewController.swift
//  magic_pod_demo_app
//
//  Created by mwakizaka on 2021/03/29.
//  Copyright © 2021年 TRIDENT. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Ref: https://note.com/yajima_tohshu/n/n7ca65834e89f
        let storyboard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() {
            self.present(vc, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

