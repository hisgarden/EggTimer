//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // set timers in minutes, changed to seconds
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var timer = Timer()
    var totalTime = 0
    var timeElapsed = 0
    var audioPlayer: AVAudioPlayer!


   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // reset timer every time different hardness is chosen
        timer.invalidate()
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        progressBar.progress = 0.0
        timeElapsed = 0
        titleLabel.text = hardness
        print(sender.currentTitle ?? "default value")
        
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if timeElapsed < totalTime {
            print("\(totalTime - timeElapsed) seconds.")
            timeElapsed += 1
            let percentageProgress = Float(timeElapsed) / Float(totalTime)
            print(percentageProgress)
            progressBar.progress = percentageProgress
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            progressBar.progress = 1.0
            playAlarm()
        }
    }
    
    func playAlarm() {
        let soundFileURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL!)
            audioPlayer?.prepareToPlay()
            audioPlayer.play()
        } catch {
            // Handle any errors that occur during audio setup
            print("Error setting up audio player: \(error)")
        }
    }

}
