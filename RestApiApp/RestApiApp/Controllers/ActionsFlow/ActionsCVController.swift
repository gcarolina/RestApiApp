//  ActionsCVController.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import UIKit

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case users = "Users"
}

final class ActionsCVController: UICollectionViewController {

    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ActionCollectionVC else { return UICollectionViewCell() }
    
        cell.infoLbl.text = userActions[indexPath.row].rawValue
        return cell
    }

    // MARK: UICollectionViewDelegate
    // срабатывает в момент нажатия
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "downloadImageSegue", sender: nil)
        case .users: performSegue(withIdentifier: "usersSegue", sender: nil)
        }
    }
}

extension ActionsCVController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (UIScreen.main.bounds.width - 20), height: 80)
    }
}
