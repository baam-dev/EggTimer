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
    
    @IBOutlet weak var progresBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var statusText: UILabel!
    
    // make a dictionary of in this order
    let eggTimes:[String: Int] = ["Soft": 10, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // happens with every click on the Soft, Medium or Hard btns
        
        // reset the timer
        timer.invalidate()
        // could be Soft, Medium or Hard depending on which btn was clicked!
        let hardness = sender.currentTitle!
        // get a certain value from the dictionary depending on passed key
        totalTime = eggTimes[hardness]!
        
        progresBar.progress = 0.0
        
        secondsPassed = 0
        titleLabel.text = hardness
        statusText.text = "Cooking..."
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progresBar.setProgress(Float(secondsPassed) / Float(totalTime), animated: true)
            
            
        }else{
            timer.invalidate()
            titleLabel.text = "Ready to go to hell!"
            statusText.text = ""
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
