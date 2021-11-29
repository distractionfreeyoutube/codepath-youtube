//
//  SubscriptionViewController.swift
//  DistractionFreeYoutube
//
//  Created by Katrina Liu on 11/28/21.
//

import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class SubscriptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var user: GIDGoogleUser!
    var channels = [[String:Any]]()
    var channelsId = [String]()
    var videosName = [String]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        retriveSubscriptions()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as! VideoTableViewCell
        return cell
    }
    
    func retriveSubscriptions() {
        let accessToken = user.authentication.accessToken
        let url = URL(string: "https://youtube.googleapis.com/youtube/v3/subscriptions?part=snippet&part=contentDetails&mine=true&key=AIzaSyCAnTNDn5B2y0PQTNi1OBYzzbHB_nGIC2s&access_token=\(accessToken ?? "")")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                 print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                 self.channels = dataDictionary["items"] as! [[String:Any]]
                 
                 for channel in self.channels {
                     let channelsSnippet = channel["snippet"] as! [String:Any]
                     let channelsResource = channelsSnippet["resourceId"] as! [String:Any]
                     self.channelsId.append(channelsResource["channelId"] as! String)
                 }
             retrieveVideos()
             }
        }
        task.resume()
    }
    
    func retrieveVideos() {
        for channelsId in channelsId {
            let url = URL(string: "https://www.googleapis.com/youtube/v3/search?key=AIzaSyCAnTNDn5B2y0PQTNi1OBYzzbHB_nGIC2s&channelId=\(channelsId)&part=snippet,id&order=date&maxResults=5")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { [self] (data, response, error) in
                 // This will run when the network request returns
                 if let error = error {
                     print(error.localizedDescription)
                 } else if let data = data {
                     let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                     let videosItems = dataDictionary["items"] as! [[String:Any]]
                     for videosItem in videosItems {
                         let videosSnippet = videosItem["snippet"] as! [String:Any]
                         self.videosName.append(videosSnippet["title"] as! String)
                     }

                 }
                for videosName in videosName {
                    testLabel.text = (testLabel.text ?? "") + videosName + "\n"
                }
            }
            task.resume()
        }
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
