//
//  BaseViewController.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/8.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    
    
    var theProgress  = ProgressViewController()
    var theRingProgress = RingProgressViewController()
    
    var theViewOriginY : CGFloat = 0
    var moveViewFrameUpWhenKeyboardShow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.commonVCBkColor()
        
        self.theProgress.modalPresentationStyle = .overFullScreen
        self.theRingProgress.modalPresentationStyle = .overFullScreen
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        if !Setting.shared.hasInternet.value{
            self.showMessageInMainThread(title: "No internet connection!", message: "Please check the Wifi")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.theViewOriginY = self.view.frame.origin.y
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard moveViewFrameUpWhenKeyboardShow else{
            return
        }
        
        var keyboardHeight : CGFloat = 140
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        
        if self.view.frame.origin.y == self.theViewOriginY{
            
            self.view.frame.origin.y -= keyboardHeight
            
        }
        
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = self.theViewOriginY
    }
    
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
     }
    
    func showMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessageInMainThread(title: String, message: String){
        DispatchQueue.main.async {
            
           
            if self.theProgress.isBeingPresented{
                self.theProgress.dismiss(animated: true, completion: {() -> Void in
                    self.showMessage(title: title, message: message)
                })
            }else if self.theRingProgress.isBeingPresented{
                self.theRingProgress.dismiss(animated: true, completion: {() -> Void in
                    self.showMessage(title: title, message: message)
                })
                
            }else{
                self.showMessage(title: title, message: message)
            }
            
            
        }
    }
    

    
    func hideProgress(type:Int = 0){
    
        DispatchQueue.main.async {
            if type == 0{
                if self.theProgress.isBeingPresented{
                    self.theProgress.dismiss(animated: true, completion: nil)
                }
            }else{
                if self.theRingProgress.isBeingPresented{
                    self.theRingProgress.dismiss(animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
    func showProgress(info: String, type:Int = 0){
        
        DispatchQueue.main.async {
            self.theProgress.progressLabel.text = info
            
            if type == 0{
                self.present(self.theProgress, animated: true, completion: nil)
            }else{
                self.present(self.theRingProgress, animated: true, completion: nil)
            }
        }
    }
    
    
    func updateProgress(info: String, type:Int = 0){
        DispatchQueue.main.async {
            
            if type == 0{
                self.theProgress.progressLabel.text = info
            }else{
                
            }
        }
    }
    
 
}

