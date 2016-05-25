//
//  SoundsOperation.swift
//  Calculator
//
//  Created by Clément DEUST on 25/05/16.
//  Copyright © 2016 cdeust. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class SoundsOperation: NSObject {
    
    var buttonSound: AVAudioPlayer!
    var soundPath: String!
    var soundUrl: NSURL!
    var activeSounds: Bool
    
    override init() {
        self.soundPath = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        self.soundUrl = NSURL.fileURLWithPath(self.soundPath)
        self.activeSounds = true
        
        do {
            try self.buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            self.buttonSound.prepareToPlay()
        } catch let e as NSError {
            print(e.debugDescription)
        }
    }
    
    func playSound() {
        if activeSounds == true {
            if buttonSound.playing {
                buttonSound.stop()
            }
            
            buttonSound.play()
        }
    }
}
