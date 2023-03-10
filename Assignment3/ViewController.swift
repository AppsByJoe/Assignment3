//
//  ViewController.swift
//  Assignment3
//
//  Created by Hronek Joseph on 1/18/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var timer = Timer()
    let dateFormatter = DateFormatter()
    var countdownTimer = Timer()
    var secondsLeft : Int = 60
    var avPlayer : AVAudioPlayer!
    var timerFlag = "off"
    
    @IBOutlet weak var liveClockLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var userTimePicker: UIDatePicker!
    @IBOutlet weak var timerButton: UIButton!
    
    @IBAction func userTimePickerChanged(_ sender: UIDatePicker) {
        if (remainingTimeLabel.text == "Waiting...") {
            secondsLeft = Int(userTimePicker.countDownDuration)
        }
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        if (timerFlag == "off") {
            countdownTimer.invalidate()
            formatRemainingTimeLabel()
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateRemainingTimeLabel) , userInfo: nil, repeats: true)
            timerFlag = "running"
        } else if (timerFlag == "alarming") {
            avPlayer?.pause()
            remainingTimeLabel.text = "Waiting..."
            secondsLeft = 60
            timerFlag = "off"
        } else if (timerFlag == "running"){
            print("no u")
        }
    }
    
    @objc func updateRemainingTimeLabel() {
        if (secondsLeft > 0) {
            formatRemainingTimeLabel()
            secondsLeft -= 1
        } else {
            formatRemainingTimeLabel()
            timerButton.titleLabel!.text = "Stop Music"
            avPlayer?.play()
            countdownTimer.invalidate()
            timerFlag = "alarming"
        }
    }
    
    func formatRemainingTimeLabel() {
        var hoursRemaining = secondsLeft/3600 > 0 ? "\(secondsLeft/3600)" : "0"
        var minutesRemaining = (secondsLeft%3600)/60 > 0 ? "\((secondsLeft%3600)/60)" : "0"
        var secondsRemaining = (secondsLeft%3600)%60 > 0 ? "\((secondsLeft%3600)%60)" : "0"
        
        if (Int(hoursRemaining)! < 10) {
            hoursRemaining = "0" + hoursRemaining
        }
        if (Int(minutesRemaining)! < 10) {
            minutesRemaining = "0" + minutesRemaining
        }
        if (Int(secondsRemaining)! < 10) {
            secondsRemaining = "0" + secondsRemaining
        }
        remainingTimeLabel.text = "Time Remaining: \(hoursRemaining):\(minutesRemaining):\(secondsRemaining)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url = Bundle.main.url(forResource: "musicClip", withExtension: "mp3") else {
            return
        }
        do {
            avPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("error")
        }
        avPlayer.numberOfLoops = -1
    
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

