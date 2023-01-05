//  CommentTVController.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import UIKit

final class CommentTVController: UITableViewController {

    var post: Post?
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchComments()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = comment.email
        cell.detailTextLabel?.text = comment.body
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = comments[indexPath.row]
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CommentVC") as? CommentVC else { return }
        vc.comment = comment
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchComments() {
        guard let postId = post?.id else { return }
        let pathUrl = "\(ApiConstants.commentsPath)?postId=\(postId)"
        
        guard let url = URL(string: pathUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: data)
                print(self.comments)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
