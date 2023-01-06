//  NewPostVC.swift
//  RestApiApp
//  Created by Carolina on 28.12.22.

import UIKit
import SwiftyJSON
import Alamofire

final class NewPostVC: UIViewController, UITextViewDelegate {

    var user: User?
    
    @IBOutlet private weak var titleTF: UITextField!
    @IBOutlet private weak var bodyTV: UITextView!
    @IBOutlet private weak var postWithURL: UIButton!
    @IBOutlet private weak var postWithAlamofire: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bodyTV.delegate = self
        
        bodyTV.text = "Please enter new text"
        bodyTV.textColor = UIColor.lightGray

        bodyTV.becomeFirstResponder()

        bodyTV.selectedTextRange = bodyTV.textRange(from: bodyTV.beginningOfDocument, to: bodyTV.beginningOfDocument)
    }
    
    // to prevent the user from changing the position of the cursor while the placeholder's visible
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    internal func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to create the updated text string
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Please enter new text"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the length of the replacement string is greater than 0, set the text color to black then set its text to the replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
             textView.textColor = .init(red: 46, green: 7, blue: 84)
             textView.text = text
        }

        // For every other case, the text should change with the usual behavior...
        else {
            return true
        }
        // ...otherwise return false since the updates have already been made
        return false
    }
    
    
    @IBAction func postURLSession() {
        if let userID = user?.id,
           let title = titleTF.text,
           let text = bodyTV.text,
           let url = ApiConstants.postsPathURL
        {
            // SETUP request
            var request = URLRequest(url: url)
            
            // HEADER
            request.httpMethod = Requests.post.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // BODY
            let postBodyJson: [String: Any] = ["userId": userID,
                                               "title": title,
                                               "body": text]
            
            let httpBody = try? JSONSerialization.data(withJSONObject: postBodyJson, options: [])
            request.httpBody = httpBody
            
            // Create dataTask and post new request
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response ?? "")
                if let data {
                    print(data)
                    let json = JSON(data)
                    print(json)
                    let userID = json["userId"].int
                    let title = json["title"].string
                    let body = json["body"].string
                    
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                } else if let error {
                    print(error)
                }
            }.resume()
        }
    }

    @IBAction func postAlamofire() {
        if let userID = user?.id,
           let title = titleTF.text,
           let text = bodyTV.text,
           let url = ApiConstants.postsPathURL
        {
            let parameters: Parameters = ["userId": userID,
                                          "title": title,
                                          "body": text]

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in

//                    debugPrint(response)
//                    print(response.request)
//                    print(response.response)
//                    debugPrint(response.result)

                    switch response.result {
                    case .success(let data):
                        print(data)
                        print(JSON(data))
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
    
    private func setupUI() {
        postWithURL.layer.cornerRadius = postWithURL.frame.size.height / 2
        postWithAlamofire.layer.cornerRadius = postWithAlamofire.frame.size.height / 2
    }
}
