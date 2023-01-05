//  ImageVC.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import UIKit

final class ImageVC: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageView: UIImageView!
    
    private let imageURLstr = "https://mobimg.b-cdn.net/v3/fetch/4c/4c3361784e34e32404cbc5d1e183f5bb.jpeg"
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }

    private func fetchImage() {
        guard let url = URL(string: imageURLstr) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                
                self.activityIndicator.stopAnimating()
                
                if let error = error {
                    print(error.localizedDescription)
                    // добавить дефолтную картинку и отобразить ошибку
                    return
                }
                
                if let response {
                    print(response)
                }
                
                print("\n", data ?? "", "\n")
                
                if let data,
                   let image = UIImage(data: data) {
                    self.imageView.image = image
                } else {
                    // добавить дефолтную картинку
                }
                
            }
        }//.resume() // - старт запроса
        task.resume()
    }
}
