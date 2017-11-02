//
//  TCPSocketViewController.swift
//  TCPie
//
//  Created by Mohamed Shokr on 11/2/17.
//  Copyright © 2017 Mohamed Shokr. All rights reserved.
//

import UIKit
import SwiftSocket

class TCPSocketViewController: UIViewController {
    
    var connected = true
    let client = TCPClient(address: "127.0.0.1", port: 6969)

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var connectionLabel: UILabel!
    
    @IBOutlet weak var connectionButton: UIButton!
    
    func concatString(numberOfMBs: Int) -> String{
        let numberOfBytes = numberOfMBs * Int(pow(2.0, 20.0))
        let s = String(repeating: "a", count: numberOfBytes)
        print(s.utf8.count)
        return s
    }
    
    func sendData(counter: Int, iterations: Int, delay: Double, size: Int){
        if iterations == 0 {
            statusLabel.text = "Completed"
            statusLabel.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1)
            return
        }
        statusLabel.text = "Sending packet number \(counter + 1)"
        let result = client.send(string: concatString(numberOfMBs: size))
                DispatchQueue.main.asyncAfter(deadline: .now() +
                    delay, execute: {
                        self.sendData(counter: counter + 1, iterations: iterations - 1, delay: delay, size: size)
        })
    }

    @IBAction func oneMBSending(_ sender: Any) {
        self.statusLabel.textColor = UIColor.black
        if self.connected {
            
            self.sendData(counter: 0, iterations: 1, delay: 2, size: 1)
        }
        else {
            self.statusLabel.text = "Please open the connection first"
            self.statusLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func twoMBSending(_ sender: Any) {
        self.statusLabel.textColor = UIColor.black
        if self.connected {
            self.sendData(counter: 0, iterations: 1, delay: 2, size: 2)
        }
        else {
            self.statusLabel.text = "Please open the connection first"
            self.statusLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func threeMBSending(_ sender: Any) {
        self.statusLabel.textColor = UIColor.black
        if self.connected {
            self.sendData(counter: 0, iterations: 1, delay: 2, size: 3)
        }
        else {
            self.statusLabel.text = "Please open the connection first"
            self.statusLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func fourMBSending(_ sender: Any) {
        self.statusLabel.textColor = UIColor.black
        if self.connected {
            self.sendData(counter: 0, iterations: 1, delay: 2, size: 4)
        }
        else {
            self.statusLabel.text = "Please open the connection first"
            self.statusLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func fiveMBSending(_ sender: Any) {
        self.statusLabel.textColor = UIColor.black
        if self.connected {
            self.sendData(counter: 0, iterations: 1, delay: 2, size: 5)
        }
        else {
            self.statusLabel.text = "Please open the connection first"
            self.statusLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func closeConnection(_ sender: Any) {
        if self.connected {
            self.client.close()
            self.connectionButton.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1)
            self.connectionButton.setTitle("Open Connection", for: .normal)
            self.connected = false
            self.connectionLabel.text = "Disconnected"
            self.connectionLabel.textColor = UIColor(red: 1, green: 0.22, blue: 0.13, alpha: 1)
        }
        else {
            switch self.client.connect(timeout: 10) {
            case .success:
                print("Connected to socket")
                self.connectionButton.backgroundColor = UIColor(red: 1, green: 0.22, blue: 0.13, alpha: 1)
                self.connectionButton.setTitle("Close Connection", for: .normal)
                self.connected = true
                self.connectionLabel.text = "Connected"
                self.connectionLabel.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1)
            case .failure(let error):
                self.connectionLabel.text = "Error"
                self.connectionLabel.textColor = UIColor(red: 1, green: 0.22, blue: 0.13, alpha: 1)
                print("Unable to connect")
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        switch self.client.connect(timeout: 10) {
        case .success:
            print("Connected to socket")
            self.connectionButton.backgroundColor = UIColor(red: 1, green: 0.22, blue: 0.13, alpha: 1)
            self.connectionButton.setTitle("Close Connection", for: .normal)
            self.connected = true
            self.connectionLabel.text = "Connected"
            self.connectionLabel.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1)
            self.statusLabel.text = "Ready"
        case .failure(let error):
            self.connectionLabel.text = "Error"
            self.connectionLabel.textColor = UIColor(red: 1, green: 0.22, blue: 0.13, alpha: 1)
            self.connected = false
            self.statusLabel.text = "Unable to connect"
            print("Unable to connect")
        }

    }


}
