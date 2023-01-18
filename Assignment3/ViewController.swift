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
    var countdownTimer = Timer()
    
    @IBOutlet weak var liveClockLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var userTimePicker: UIDatePicker!
    @IBOutlet weak var timerButton: UIButton!
    
    @IBAction func startTimer(_ sender: UIButton) {
        if (timerButton.titleLabel!.text == "Start Timer" && remainingTimeLabel.text == "Remaining Time") {
            remainingTimeLabel.text = "Time Remaining: /(userTimePicker.date)"
            
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startCountdown) , userInfo: nil, repeats: true)
        } else if (timerButton.titleLabel!.text == "Stop Music") {
            timerButton.titleLabel!.text = "Start Timer"
            remainingTimeLabel.text = "Remaining Time"
            
            //stop music
        }
    }
    
    @objc func startCountdown() {
        
    }
    
    
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

