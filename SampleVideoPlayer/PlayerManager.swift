//
//  PlayerManager.swift
//  SampleVideoPlayer
//
//  Created by S@nchit on 28/08/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class PlayerManager: NSObject {
    static let sharedInstance = PlayerManager()
    var player : AVPlayer?
    var isPlaying = false
    
    override init() {
        super.init()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        commonInit()
    }
    
    func commonInit(){
        self.setupRemoteCommands()
    }
    
    func setupRemoteCommands(){
        MPRemoteCommandCenter.shared().playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.player?.play()
            self.isPlaying = true
            return .success
        }
        MPRemoteCommandCenter.shared().pauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.player?.pause()
            self.isPlaying = false
            return .success
        }
    }
    
    func setUpPlayerForUrl (url : String){
        guard let videoUrl = URL.init(string: url) else {
            return
        }
        if let _ = player{
            
        }else{
            player = AVPlayer.init(url: videoUrl)
        }
        self.player?.play()
        self.isPlaying = true
    }
    
}
