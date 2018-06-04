//
//  AudioManager.swift
//  AudioPlayground
//
//  Created by JTRACY9 on 5/3/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit
import AVFoundation

class AudioManager: NSObject {

    let session = AVAudioSession.sharedInstance()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(handleAudioInterruption), name: .AVAudioSessionInterruption, object: session)
    }
    
    
    @objc func handleAudioInterruption(_ notification: Notification) {
        guard let info = notification.userInfo, let typeValue = info[AVAudioSessionInterruptionTypeKey] as? UInt, let type = AVAudioSessionInterruptionType(rawValue: typeValue) else {
            return
        }
        
        if type == .began {
            print("audio notification began")
        } else if type == .ended {
            guard let optionsValue =
                notification.userInfo![AVAudioSessionInterruptionOptionKey] as? UInt else {
                    print("audion notification ended")
                    return
            }
            let options = AVAudioSessionInterruptionOptions(rawValue: optionsValue)
            if options.contains(.shouldResume) {
                // Interruption Ended - playback should resume
                print("audio notification should resume")
            }
        }
    }
    
    func startAudioSession() {
        do {
//            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .mixWithOthers)
            try session.setActive(true)
        } catch {
            print("failed starting audio Session")
        }
    }
    
    func startAudioSessionPlayback() {
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
            try session.setActive(true)
        } catch {
            print("failed starting playback session")
        }
    }
    
    func endAudioSession() {
        do {
            try session.setActive(false)
            print("session ended")
        } catch {
            print("failed ending audio session")
        }
    }
    
}
