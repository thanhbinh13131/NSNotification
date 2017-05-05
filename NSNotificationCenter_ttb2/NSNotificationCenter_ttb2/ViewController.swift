﻿//
//  ViewController.swift
//  NSNotificationCenter_ttb2

//
//  Created by admin25 on 5/5/17.

//  Copyright © 2017 admin25. All rights reserved.

//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() 
{
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))

        view.addGestureRecognizer(dismiss)

        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)),

                                               name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)),

                                               name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)

    }


    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.

    }
    func DismissKeyboard(){
        view.endEditing(true)

    }
    
    func keyboardWillShow(_ sender: NSNotification) {

        // 1
       
        let userInfo: [AnyHashable : Any] = sender.userInfo!

         // 2
        let keyboardSize: CGSize = ((userInfo[UIKeyboardFrameBeginUserInfoKey]!) as AnyObject).cgRectValue.size

        let offset: CGSize = ((userInfo[UIKeyboardFrameEndUserInfoKey]!) as AnyObject).cgRectValue.size

        // 3
        if keyboardSize.height == offset.height {

            UIView.animate(withDuration: 0.1, animations: { () -> Void in

                self.view.frame.origin.y -= keyboardSize.height

            })

        } else {

            UIView.animate(withDuration: 0.1, animations: { () -> Void in

                self.view.frame.origin.y += keyboardSize.height - offset.height

            })
        }
    }

    
    func keyboardWillHide(_ sender: NSNotification) {

        let userInfo: [AnyHashable : Any] = sender.userInfo!

        let keyboardSize: CGSize = ((userInfo[UIKeyboardFrameBeginUserInfoKey]!) as AnyObject).cgRectValue.size

        
        self.view.frame.origin.y += keyboardSize.height
    }

    
    override func viewWillDisappear(_ animated: Bool) {

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }


}

