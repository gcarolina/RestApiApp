//  AlbumsTVC.swift
//  RestApiApp
//  Created by Carolina on 28.12.22.

import UIKit
import SwiftyJSON
import Alamofire

final class AlbumsTVC: UITableViewController {
    var user: User?
    var albums: [JSON] = []
    
    override func viewDidLoad() {
        getData()
    }

    private func getData() {
        guard let userId = user?.id else { return }
        NetworkService.getData(userID: userId) { [weak self] result, error in
            guard let albums = result else { return }
            self?.albums = albums
            self?.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = albums[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: album)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
           let photosCollectionVC = segue.destination as? PhotosCVC,
           let album = sender as? JSON {
            photosCollectionVC.user = user
            photosCollectionVC.album = album
        }
    }
}
