//
//  VideoRecorder.swift
//  AudioPlayground
//
//  Created by JTRACY9 on 5/21/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit
import AVKit

protocol VideoRecorderDelegate {
    func startedRecording()
    func finishedRecording()
}

class VideoRecorder: NSObject, AVCaptureFileOutputRecordingDelegate {

    var fileName: String?
    let output = AVCaptureMovieFileOutput()
    let session = AVCaptureSession()
    var delegate: VideoRecorderDelegate?
    
    init(fileName: String, delegate: VideoRecorderDelegate) {
        super.init()
        self.fileName = fileName
        self.delegate = delegate
        initSession()
    }
    
    func initSession() {
        if session.canSetSessionPreset(AVCaptureSession.Preset.hd1280x720) {
            session.sessionPreset = AVCaptureSession.Preset.hd1280x720
        }
        session.automaticallyConfiguresApplicationAudioSession = false
        session.usesApplicationAudioSession = true
        
        //Video
        var defaultDevice: AVCaptureDevice?
        do {
            if let backDevice = AVCaptureDevice.default(for: AVMediaType.video) {
                defaultDevice = backDevice
            }
            
            let inputDevice = try AVCaptureDeviceInput(device: defaultDevice!)
            
            if session.canAddInput(inputDevice) {
                session.addInput(inputDevice)
            } else {
                print("couldnt add input")
            }
        } catch {
            print("error")
        }
        
        //Audio
        do {
            let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
            let audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice!)
            
            if session.canAddInput(audioDeviceInput) {
                session.addInput(audioDeviceInput)
            }
            else {
                print("Could not add audio device input to the session")
            }
        }
        catch {
            print("Could not create audio device input: \(error)")
        }
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        delegate?.finishedRecording()
    }
    
    func startRecording() {
        audioManager?.startAudioSession()
        let url = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/" + fileName! + ".mov")
        session.startRunning()
        output.startRecording(to: url, recordingDelegate: self)
    }
    
    func stopRecording() {
        output.stopRecording()
    }
}
