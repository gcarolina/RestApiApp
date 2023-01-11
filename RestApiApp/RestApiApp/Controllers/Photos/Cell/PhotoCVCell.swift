//
//  PhotoCVCell.swift
//  RestApiApp
//
//  Created by Carolina on 4.01.23.
//

import UIKit
import Alamofire
import AlamofireImage

final class PhotoCVCell: UICollectionViewCell {

    var thumbnailUrl: String? {
        didSet {
            getThumbnail()
        }
    }
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func getThumbnail() {
        guard let thumbnailUrl = thumbnailUrl else { return }
        NetworkService.getPhoto(imageURL: thumbnailUrl) { [weak self] image, error in
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        }
    }
}
