//
//  SubscriptionViewController.swift
//  DistractionFreeYoutube
//
//  Created by Katrina Liu on 11/28/21.
//

import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class SubscriptionViewController: UIViewController {
    
    var user: GIDGoogleUser!

    override func viewDidLoad() {
        super.viewDidLoad()
        retriveSubscription()
    }
    
    // Perform network request
    func retriveSubscription() {
        let accessToken = user.authentication.accessToken
        let url = URL(string: "https://youtube.googleapis.com/youtube/v3/subscriptions?part=contentDetails&part=id&part=snippet&mine=true&key=AIzaSyCAnTNDn5B2y0PQTNi1OBYzzbHB_nGIC2s&access_token=\(accessToken ?? "")")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(dataDictionary)

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
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
