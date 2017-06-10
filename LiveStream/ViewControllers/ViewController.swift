//
//  ViewController.swift
//  LiveStream
//
//  Created by Lamine Ndiaye on 10/06/2017.
//
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var launchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Actions
    
    @IBAction func didTouchUpLaunchButton(_ sender: Any) {
        presentPlayer()
    }
}

// MARK: - UI
extension ViewController {
    
    func initUI() {
        setButtonStyle()
        setNavTitle()
    }
    
    func setButtonStyle() {
        launchButton.setTitle(NSLocalizedString("Home.Launch", comment: ""), for: .normal)
    }
    
    func setNavTitle() {
        title = NSLocalizedString("Home.Title", comment: "")
    }
}

// MARK: - Player
extension ViewController {
    func presentPlayer() {
        guard let url = URL(string: Constants.liveStreamUrlString()) else {
            return
        }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
}
