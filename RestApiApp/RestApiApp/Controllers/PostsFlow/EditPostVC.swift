//  EditPostVC.swift
//  RestApiApp
//  Created by Carolina on 4.01.23.

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

final class EditPostVC: UIViewController {
    var post: Post?
    var user: User?
    
    @IBOutlet private weak var titleTF: UITextField!
    @IBOutlet private weak var bodyTV: UITextView!
    @IBOutlet private weak var editBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func editWithAlamofire() {
        let urlPost = ApiConstants.postsPath
        if let userID = user?.id,
           let postID = post?.id,
           let title = titleTF.text,
           let text = bodyTV.text
        {
            let url = urlPost + "/" + "\(postID)"
            guard let postsPathURL = URL(string: url) else { return }
            
            let parameters: Parameters = ["userId": userID,
                                          "id": postID,
                                          "title": title,
                                          "body": text]
            Alamofire.AF.request(postsPathURL, method: .put, parameters: parameters).response { response in
                
                switch response.result {
                case .success(let data):
                    print(JSON(data))
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setupUI() {
        titleTF.text = post?.title
        bodyTV.text = post?.body
        editBtn.layer.cornerRadius = editBtn.frame.size.height / 2
    }
}
