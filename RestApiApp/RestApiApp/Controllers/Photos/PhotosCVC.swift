//  PhotosCVC.swift
//  RestApiApp
//  Created by Carolina on 4.01.23.

import UIKit
import SwiftyJSON

final class PhotosCVC: UICollectionViewController {
    var user: User?
    var album: JSON?
    var photos: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        collectionView.register(UINib(nibName: "PhotoCVCell", bundle: .main), forCellWithReuseIdentifier: "PhotoCVCell")
        title = album?["title"].string
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        let sizeWH = (UIScreen.main.bounds.width / 2) - 5
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVCell", for: indexPath) as! PhotoCVCell
        let thumbnailUrl = photos[indexPath.row]["thumbnailUrl"].string
        cell.thumbnailUrl = thumbnailUrl
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPhoto", sender: photos[indexPath.row])
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imageVC = segue.destination as? PhotoVC,
           let photo = sender as? JSON {
            imageVC.photo = photo
        }
    }
    
    private func getData() {
        guard let album = album,
              let albumId = album["id"].int else { return }
        NetworkService.getPhotos(albumID: albumId) { [weak self] result, error in
            guard let photos = result else { return }
            self?.photos = photos
            self?.collectionView.reloadData()
        }
    }

}
