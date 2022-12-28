//  AlbumsTVC.swift
//  RestApiApp
//  Created by Carolina on 28.12.22.

import UIKit
import SwiftyJSON
import Alamofire

class AlbumsTVC: UITableViewController {
    var user: User?
    var albums: [JSON] = []
    
    override func viewDidLoad() {
        getData()
    }

    private func getData() {

        guard let userId = user?.id else { return }
        
        guard let url = URL(string: "\(ApiConstants.albumsPath)?userId=\(userId)") else { return }

        AF.request(url).response { response in
            
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                self.albums = JSON(data).arrayValue
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = albums[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}
