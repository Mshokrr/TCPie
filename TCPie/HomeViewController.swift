//
//  HomeViewController.swift
//  TCPie
//
//  Created by Mohamed Shokr on 10/12/17.
//  Copyright © 2017 Mohamed Shokr. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var timer = Timer()
    
    @IBAction func startTimer(_ sender: Any) {
//        print ("Timer started!")
//        self.timer = Timer.scheduledTimer(
//            timeInterval: 0.5,
//            target: self,
//            selector: #selector(Tick),
//            userInfo: nil,
//            repeats: true
//        )
    }
    
    @IBAction func stopTImer(_ sender: Any) {
//        print ("Timer stopped!")
//        self.timer.invalidate()
    }
    
    @IBOutlet weak var partOneButton: UIButton!
    @IBOutlet weak var partTwoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partOneButton.layer.cornerRadius = 20
        partTwoButton.layer.cornerRadius = 20
    }
    
    @objc public func Tick(){
        print("Tick")
    }


}
