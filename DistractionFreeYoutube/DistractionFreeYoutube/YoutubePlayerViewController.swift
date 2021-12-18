//
//  YoutubePlayerViewController.swift
//  DistractionFreeYoutube
//
//  Created by Katrina Liu on 12/16/21.
//

import youtube_ios_player_helper
import UIKit

class YoutubePlayerViewController: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    var videoId: String!
    var videoName: String!
    var channelName: String!

    // reference: https://www.youtube.com/watch?v=bsM1qdGAVbU
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        videoNameLabel.text = videoName
        channelNameLabel.text = channelName
        playerView.load(withVideoId: videoId)
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    // Restrict orientation change
    override var shouldAutorotate: Bool {
        return false
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
