//  DetailUserVC.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import UIKit

class DetailUserVC: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var albumsBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var toDoBtn: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func addressAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MapVC") as? MapVC else { return }
        vc.address = user?.address
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func postsAction() {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as? PostsTVC else { return }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func albumsAction() {
        let storyboard = UIStoryboard(name: "AlbumsAndFotos", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlbumsTVC") as! AlbumsTVC
       // vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func todosAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ToDosTVC") as? ToDosTVC else { return }
        vc.userId = user?.id
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupUI() {
        name.text = user?.name
        username.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
        website.text = user?.website
        
        albumsBtn.layer.cornerRadius = albumsBtn.frame.size.height / 2
        postBtn.layer.cornerRadius = postBtn.frame.size.height / 2
        toDoBtn.layer.cornerRadius = toDoBtn.frame.size.height / 2
    }
}
