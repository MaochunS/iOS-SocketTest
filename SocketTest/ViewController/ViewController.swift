//
//  ViewController.swift
//  SocketTest
//
//  Created by maochun on 2021/2/1.
//

import UIKit

import CocoaAsyncSocket

class ViewController: BaseViewController {
    
    
    
    lazy var titleView: UIView = {
        let theview = UIView()
        theview.translatesAutoresizingMaskIntoConstraints = false
        theview.backgroundColor = .black
        
        self.view.addSubview(theview)
        
        NSLayoutConstraint.activate([
            
            theview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            theview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            theview.topAnchor.constraint(equalTo: self.view.topAnchor, constant:0),
            theview.heightAnchor.constraint(equalToConstant: 80)
            
        ])
        
        return theview
    }()
    
    lazy var svrTextField : UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.text = self.serverAdr
        input.keyboardType = .decimalPad
        input.borderStyle = .line
        input.textColor = .gray
        input.delegate = self
        
        input.layer.cornerRadius = 3.0;
        input.layer.masksToBounds = true;
        input.layer.borderColor = UIColor.darkGray.cgColor
        input.layer.borderWidth = 1.0;
        
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        input.leftViewMode = .always
        
        self.view.addSubview(input)
        
        NSLayoutConstraint.activate([
            input.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10),
            input.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            input.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            input.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
        return input
        
    }()
    
    lazy var portTextField : UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.text = "\(self.serverPort)"
        input.keyboardType = .numberPad
        input.borderStyle = .line
        input.textColor = .gray
        input.delegate = self
        
        input.layer.cornerRadius = 3.0;
        input.layer.masksToBounds = true;
        input.layer.borderColor = UIColor.darkGray.cgColor
        input.layer.borderWidth = 1.0;
        
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        input.leftViewMode = .always
        
        self.view.addSubview(input)
        
        NSLayoutConstraint.activate([
            input.topAnchor.constraint(equalTo: self.svrTextField.bottomAnchor, constant: 10),
            input.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            input.widthAnchor.constraint(equalToConstant: 100),
            input.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
        return input
        
    }()
    
    lazy var connButton: UIButton = {
        let btn = GradientButton(gradientColors: [UIColor.commonButtonColor(), UIColor.commonButtonColor()])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont.buttonFont()
        btn.setTitle(NSLocalizedString("CONNECT", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(connAction), for: .touchUpInside)
        
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        self.view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            btn.topAnchor.constraint(equalTo: self.svrTextField.bottomAnchor, constant: 10),
            btn.leftAnchor.constraint(equalTo: self.portTextField.rightAnchor, constant: 10),
            btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            btn.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
        
        return btn
        
    }()
    
    
    lazy var statusTextView : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        self.view.addSubview(tv)
        tv.backgroundColor = .gray
        tv.font = UIFont.statusFont()
        
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: self.portTextField.bottomAnchor, constant: 10),
            tv.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            tv.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            tv.bottomAnchor.constraint(equalTo: self.dataTextField.topAnchor, constant: -10)
        
        ])
        
        return tv
    }()
    
    
    lazy var sendButton: GradientButton = {
        let btn = GradientButton(gradientColors: [UIColor.commonButtonColor(), UIColor.commonButtonColor()])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont.buttonFont()
        btn.setTitle(NSLocalizedString("SEND DATA", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        self.view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            btn.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
        
        return btn
        
    }()
    
    
    
    lazy var dataTextField : UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.text = ""
        input.placeholder = "Send data"
        input.keyboardType = .default
        input.borderStyle = .line
        input.textColor = .gray
        input.delegate = self
        
        input.layer.cornerRadius = 3.0;
        input.layer.masksToBounds = true;
        input.layer.borderColor = UIColor.darkGray.cgColor
        input.layer.borderWidth = 1.0;
        
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        input.leftViewMode = .always
        
        self.view.addSubview(input)
        
        NSLayoutConstraint.activate([
            input.bottomAnchor.constraint(equalTo: self.sendButton.topAnchor, constant: -10),
            input.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            input.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            input.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
        return input
        
    }()
    
    let serverPort:UInt16 = 5000
    let serverAdr = "172.20.10.7"
    var clientSocket:GCDAsyncSocket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        let _ = self.connButton
        let _ = self.statusTextView
        
        clientSocket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //ProcessInfo.processInfo.hostName
    }

    @objc func connAction(){
        self.dismissMyKeyboard()
        
        if clientSocket.isConnected{
            clientSocket.disconnect()
            return
        }
        
        guard let svrAddr = self.svrTextField.text, let port = self.portTextField.text, svrAddr.count > 0, port.count > 0, let portVal = UInt16(port) else {
            self.showMessage(title: "Invalid server / port info.", message: "Please input server & port!")
            return
        }
        
    
        self.showProgress(info: "Conn...")
        
        do {
        
            try clientSocket.connect(toHost: svrAddr, onPort: portVal, withTimeout: 10.0)
           
        }catch let error as NSError {
            print(error)
            self.showMessage(title: "Connect with server failed!", message: error.description)
        }
        
    }
    
    @objc func sendAction(){
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        self.dismissMyKeyboard()
        
        guard let msg = self.dataTextField.text, msg.count > 0 else{
            self.showMessage(title: "Please input text!", message: "Send abort")
            return
        }
        
        if clientSocket.isConnected{
            self.statusTextView.insertText("<-- SEND: \(msg)\n")
            //self.showProgress(info: "Sending...")
            clientSocket.write("\(msg)".data(using: .utf8), withTimeout: -1, tag: 0)
        }else{
            self.showMessage(title: "Not connect!", message: "Send abort")
        }
        
    }

}

extension ViewController: GCDAsyncSocketDelegate{
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
            
        //self.hideProgress()
        self.connButton.setTitle("Disconnect", for: .normal)
        print("Connect to server \(host)")
            
        self.showMessageInMainThread(title: "Connect with server successfully!", message: "")
        
        //clientSocket.write("test from client".data(using: .utf8), withTimeout: -1, tag: 0)
        self.clientSocket.readData(withTimeout: -1, tag: 0)
    }
    
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        if let text = String(data: data, encoding: .utf8){
            
            self.statusTextView.insertText("--> RECV: \(text)\n")
            
        }
        //clientSocket.write("test from client".data(using: .utf8), withTimeout: -1, tag: 0)
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        //self.hideProgress()
        self.connButton.setTitle("Connect", for: .normal)
        print("Disconnect")
        if let error = err{
            self.showMessageInMainThread(title: "Disconnect with error", message: error.localizedDescription)
        }else{
            self.showMessageInMainThread(title: "Disconnect with server!", message: "")
        }
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("didWriteDataWithTag \(tag)")
        
        //self.hideProgress()
        //clientSocket.readData(withTimeout: -1, tag: 0)
        
    }
    
    func socket(_ sock: GCDAsyncSocket, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        print("didReceive trust")
    }
    
    func socketDidCloseReadStream(_ sock: GCDAsyncSocket) {
        print("socketDidCloseReadStream")
    }
    
 
}

extension ViewController: UITextFieldDelegate{

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.dataTextField{
            self.moveViewFrameUpWhenKeyboardShow = true
        }else{
            self.moveViewFrameUpWhenKeyboardShow = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.dataTextField{
           
        }
    }
}
