//
//  AppDelegate.swift
//  AudioPlayground
//
//  Created by JTRACY9 on 5/2/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit
import AVKit

var audioManager: AudioManager?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        audioManager = AudioManager()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
//        if let vc = window?.rootViewController as? AVPlayerViewController? {
//            vc?.player?.isMuted = true
//            audioManager?.endAudioSession()
//        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

//        if let vc = window?.rootViewController as? AVPlayerViewController? {
//            vc?.player?.isMuted = false
//            audioManager?.startAudioSessionPlayback()
//        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}

