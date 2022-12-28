//  CommentVC.swift
//  RestApiApp
//  Created by Carolina on 28.12.22.

import UIKit

class CommentVC: UIViewController {

    @IBOutlet weak var bodyLabel: UILabel!
    var comment: Comment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyLabel.text = comment?.body?.description
    }
}
