//
//  PlayerView.swift
//  SampleVideoPlayer
//
//  Created by S@nchit on 29/08/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit
import AVKit

protocol PlayerViewButtonActionsProtocol {
    func dismissButtonTapped()
}

class PlayerView: UIView {
    var playerLayer = AVPlayerLayer.init()
    var delegate : PlayerViewButtonActionsProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        //fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.backgroundColor = .black
        setupPlayerLayer()
    }
    
    func setupPlayerLayer(){
        //self.playerLayer = AVPlayerLayer.init()
        self.playerLayer.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.playerLayer.player = PlayerManager.sharedInstance.player
        self.layer.insertSublayer(self.playerLayer, at: 0)
    }
    
    func destroyLayer(){
        self.playerLayer.removeFromSuperlayer()
        self.playerLayer = AVPlayerLayer.init()
    }
}
