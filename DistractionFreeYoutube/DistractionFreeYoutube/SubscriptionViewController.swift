//
//  SubscriptionViewController.swift
//  DistractionFreeYoutube
//
//  Created by Katrina Liu on 11/28/21.
//

import GoogleAPIClientForREST
import GoogleSignIn
import UIKit
import AlamofireImage

class SubscriptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var user: GIDGoogleUser!
    var channelsIds = [String]()
    var videosNames = [String]()
    var channelNames = [String]()
    var thumbnailLinks = [String]()
    var videoIds = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 15.0, *) {
            Task {
                
                do {
                    channelsIds = try await getSubscriptions()
                    videosNames = try await getVideos()
                    
//                    for channelsId in channelsIds {
//                        print(channelsId)
//                    }
//                    
//                    for videosName in videosNames {
//                        print(videosName)
//                    }
                    
                    for thumbnailLinks in thumbnailLinks {
                        print(thumbnailLinks)
                    }
                    
                    self.tableView.reloadData()
                    
                } catch {
                    print("Request failed with error: \(error)")
                }
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as! VideoTableViewCell
        let videoName = videosNames[indexPath.row]
        cell.videoNameLabel.text = videoName
        
        let channelName = channelNames[indexPath.row]
        cell.channelNameLabel.text = channelName
        
        let thumbnailURL = URL(string: thumbnailLinks[indexPath.row])
        cell.thumbnailImageView.af.setImage(withURL: thumbnailURL!)
        
        tableView.rowHeight = 90
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        
        let indexPath = tableView.indexPath(for: cell)!
        
        let destinationViewController = segue.destination as! YoutubePlayerViewController
        destinationViewController.videoId = videoIds[indexPath.row]
        destinationViewController.videoName = videosNames[indexPath.row]
        destinationViewController.channelName = channelNames[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.videosNames.remove(at: indexPath.row)
            self.thumbnailLinks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @available(iOS 15.0.0, *)
    func getSubscriptions() async throws -> [String] {
        var returnChannelsId = [String]()

        let accessToken = user.authentication.accessToken
        guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/subscriptions?part=snippet&part=contentDetails&mine=true&key=AIzaSyCAnTNDn5B2y0PQTNi1OBYzzbHB_nGIC2s&access_token=\(accessToken ?? "")") else {
            throw SubscriptionsFetchError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
//        print(dataDictionary)
        
        let channels = dataDictionary["items"] as! [[String: Any]]

         for channel in channels {
             let channelsSnippet = channel["snippet"] as! [String:Any]
             let channelsResource = channelsSnippet["resourceId"] as! [String:Any]
             returnChannelsId.append(channelsResource["channelId"] as! String)
             
             let channelsTitle = channelsSnippet["title"] as! String
             for _ in 1...5 {
                 self.channelNames.append(channelsTitle);
             }
         }

        return returnChannelsId
    }
    
    @available(iOS 15.0.0, *)
    func getVideos() async throws -> [String] {
        var returnVideosName = [String]()
        
        for channelsId in channelsIds {
            guard let url = URL(string: "https://www.googleapis.com/youtube/v3/search?key=AIzaSyCAnTNDn5B2y0PQTNi1OBYzzbHB_nGIC2s&channelId=\(channelsId)&part=snippet,id&order=date&maxResults=5") else {
                throw VideoFetchError.invalidURL
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            let videosItems = dataDictionary["items"] as! [[String:Any]]
            for videosItem in videosItems {
                let videosSnippet = videosItem["snippet"] as! [String:Any]
                returnVideosName.append(videosSnippet["title"] as! String)
                
                let videosThumbnail = videosSnippet["thumbnails"] as! [String:Any]
                let videoThumbnailDefault = videosThumbnail["default"] as! [String:Any]
                thumbnailLinks.append(videoThumbnailDefault["url"] as! String)
                
                let id = videosItem["id"] as! [String:Any]
                videoIds.append(id["videoId"] as! String)
            }
        }
        return returnVideosName
    }
    
    // Restrict orientation change
    override var shouldAutorotate: Bool {
        return false
    }
    
    enum SubscriptionsFetchError: Error {
        case invalidURL
    }
    
    enum VideoFetchError: Error {
        case invalidURL
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
