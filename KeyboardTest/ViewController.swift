//
//  ViewController.swift
//  KeyboardTest
//
//  Created by 堀 洋輔 on 2017/11/02.
//  Copyright © 2017年 yosuke_hori. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KeyboardModule {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var test: () -> Void  = { () -> Void in
        print()
    }
    
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        setObserver()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}
