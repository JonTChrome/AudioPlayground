//
//  ViewController.swift
//  AudioPlayground
//
//  Created by JTRACY9 on 5/2/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlaybackViewController: UIViewController {
    
    @IBOutlet weak var playButton: PlayPause!
    var audioPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playPause)))
        if let sound = NSDataAsset(name: "SampleAudio_07mb") {
            do {
                audioPlayer = try AVAudioPlayer(data: sound.data, fileTypeHint: AVFileType.mp3.rawValue)
                audioPlayer?.volume = 0.5
                
            } catch {
                print("audio player failed")
            }
        }
    }

    @objc func playPause() {
        if !playButton.play {
            audioPlayer?.play()
        } else {
            audioPlayer?.pause()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

