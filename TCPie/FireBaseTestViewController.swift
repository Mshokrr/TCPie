//
//  FireBaseTestViewController.swift
//  TCPie
//
//  Created by Mohamed Shokr on 11/1/17.
//  Copyright © 2017 Mohamed Shokr. All rights reserved.
//

import UIKit
import Alamofire

class FireBaseTestViewController: UIViewController {
    
    var timer = Timer()
    var counter = 0
    
    @IBOutlet weak var statusLabel: UILabel!

    @IBAction func periodicSend(_ sender: Any) {
        self.timer = Timer.scheduledTimer(
            timeInterval: 5,
            target: self,
            selector: #selector(periodicSendTick),
            userInfo: nil,
            repeats: true
        )
        self.sendData(data: self.concatString(numberOfMBs: 5))
    }
    
    @objc public func periodicSendTick(){
        print("periodic sending")
        if (counter >= 4){
            self.timer.invalidate()
            counter = 0
        }
        else {
            self.sendData(data: self.concatString(numberOfMBs: 1.25))
            counter += 1
        }
    }
    
    @IBAction func burstSend(_ sender: Any) {
        self.sendData(data: self.concatString(numberOfMBs: 5))
    }
    
    func concatString(numberOfMBs: Double) -> String{
        let numberOfBytes = numberOfMBs * pow(2.0, 20.0)
        let s = String(repeating: "a", count: Int(numberOfBytes))
        print(s.utf8.count)
        return s
    }
    
    func sendData(data: String) -> Void{
        self.statusLabel.text = "Please wait.."
        var parameters = [String:String]()
        parameters["message"] = data
        let headers: HTTPHeaders = ["Accept" : "application/json", "Content-Type" : "application/json"]
        Alamofire.request("https://edison-gateway.firebaseio.com/saved-data.json", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            self.statusLabel.text = "Completed"
            self.statusLabel.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusLabel.text = "Ready"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
