//  CommentVC.swift
//  RestApiApp
//  Created by Carolina on 28.12.22.

import UIKit

final class CommentVC: UIViewController {

    var comment: Comment?
    @IBOutlet private weak var bodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyLabel.text = comment?.body?.description
    }
}
