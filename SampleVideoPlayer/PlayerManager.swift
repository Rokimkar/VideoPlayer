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
    var playerQueue = ["http://content.jwplatform.com/manifests/vM7nH0Kl.m3u8","https://vodhls-vh.akamaihd.net/i/songs/48/2214148/24126370/24126370_,16,128,96,64,192,.mp4.csmil/master.m3u8?set-akamai-hls-revision=5&hdnts=st=1535696355~exp=1535714355~acl=/i/songs/48/2214148/24126370/24126370_,16,128,96,64,192,.mp4*~hmac=d9491ca6779380f4e29d538d9c7cda40d4612e8fd27624c9dd6b8aef64f4e110","http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"]
    var currentPosition = 48
    
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
        MPRemoteCommandCenter.shared().nextTrackCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.currentPosition += 1
            self.cleanPlayer()
            self.setUpPlayerForUrl(url: self.playerQueue[(self.currentPosition%self.playerQueue.count)])
            NotificationCenter.default.post(name: .playerItemChanged, object: nil)
            return .success
        }
        MPRemoteCommandCenter.shared().previousTrackCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.currentPosition -= 1
            self.cleanPlayer()
            self.setUpPlayerForUrl(url: self.playerQueue[(self.currentPosition%self.playerQueue.count)])
            NotificationCenter.default.post(name: .playerItemChanged, object: nil)
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
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle:"SampleVideoPlayer"]
        self.player?.play()
        self.isPlaying = true
    }
    
    func cleanPlayer(){
        self.player?.pause()
        self.player = nil
    }
    
}

extension Notification.Name{
    static let playerItemChanged = Notification.Name("playerItemChanged")
}
