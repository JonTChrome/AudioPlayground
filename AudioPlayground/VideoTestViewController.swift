//
//  VideoTestViewController.swift
//  FPExperience
//
//  Created by JTRACY9 on 3/22/17.
//  Copyright © 2017 Ford. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoTestViewController: UIViewController, VideoRecorderDelegate {
    
    var isRecording = false
    var filename = ""
    
    var videoRecorder: VideoRecorder?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func recordPressed(_ sender: UIButton) {
        if isRecording {
            stopRecording()
            sender.setTitle("Record", for: .normal)
            sender.setTitleColor(.green, for: .normal)
        } else {
            startRecording()
            sender.setTitle("Stop", for: .normal)
            sender.setTitleColor(.red, for: .normal)
        }
        isRecording = !isRecording
    }
    
    func startRecording() {
        filename = String(Date().timeIntervalSince1970)
        videoRecorder = VideoRecorder(fileName: filename, delegate: self)
        videoRecorder?.startRecording()
    }
    
    func stopRecording() {
        videoRecorder?.stopRecording()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! AVPlayerViewController
        
        let av = AVPlayer()
        av.replaceCurrentItem(with: AVPlayerItem(url: URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/" + filename + ".mov" )))
        destVC.player = av
    }
    
    //Delegate
    func startedRecording() {
        
    }
    
    func finishedRecording() {
        performSegue(withIdentifier: "toAVPlayer", sender: self)
    }
}
