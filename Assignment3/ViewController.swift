//
//  ViewController.swift
//  Assignment3
//
//  Created by Hronek Joseph on 1/18/23.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var liveClockLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateLiveClockLabel) , userInfo: nil, repeats: true)
    }

    @objc func updateLiveClockLabel() {
        liveClockLabel.text = dateFormatter.string(from: Date())
        if (Calendar.current.component(.hour, from: Date()) > 12) {
            backgroundImage.image = UIImage(named: "PM")
        } else {
            backgroundImage.image = UIImage(named: "AM")
        }
    }
}

