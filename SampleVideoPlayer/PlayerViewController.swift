//
//  PlayerViewController.swift
//  SampleVideoPlayer
//
//  Created by S@nchit on 30/08/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet var dismissButton: UIView!
    @IBOutlet weak var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appEnteredBackground), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appEnteredForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc func appEnteredBackground(){
        self.playerView.destroyLayer()
    }
    
    @objc func appEnteredForeground(){
        self.playerView.setupPlayerLayer()
    }
    
    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }

}
