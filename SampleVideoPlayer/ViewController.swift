//
//  ViewController.swift
//  SampleVideoPlayer
//
//  Created by S@nchit on 28/08/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    var playerLayer = AVPlayerLayer.init()
    var playerView = PlayerView.init(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showButtonPressed(_ sender: Any) {
        setUpPlayerLayer()
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        PlayerManager.sharedInstance.setUpPlayerForUrl(url: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8")
    }
    
    func setUpPlayerLayer(){
        let playerVC = PlayerViewController.init(nibName: "PlayerViewController", bundle: nil)
        self.present(playerVC, animated: true, completion: nil)
    }
    
    func destroyPlayerLayer(){
        self.playerLayer.removeFromSuperlayer()
        playerLayer = AVPlayerLayer.init()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : PlayerViewButtonActionsProtocol{
    
    func dismissButtonTapped(){
        self.playerView.removeFromSuperview()
    }
}

