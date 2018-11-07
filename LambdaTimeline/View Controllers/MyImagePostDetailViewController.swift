//
//  MyImagePostDetailViewController.swift
//  LambdaTimeline
//
//  Created by Ilgar Ilyasov on 11/6/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MyImagePostDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        recordAudioView.isHidden = true
        tableView.delegate = self
        updateViews()
    }
    
    func updateViews() {
        guard let imageData = imageData,
            let image = UIImage(data: imageData) else { return }
        
        title = post?.title
        
        imageView.image = image
        
        titleLabel.text = post.title
        authorLabel.text = post.author.displayName
    }
    
    @IBAction func audioCommentTapped(_ sender: Any) {
        
    }
    
    @IBAction func recordTapped(_ sender: Any) {
    }
    
    @IBAction func sendTapped(_ sender: Any) {
    }
    
    
    var post: Post!
    var postController: PostController!
    var imageData: Data?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageViewAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak var recordAudioView: UIView!
    @IBOutlet weak var audioCommentButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
}

extension MyImagePostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (post?.comments.count ?? 0) - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        
        let comment = post?.comments[indexPath.row + 1]
        
        cell.textLabel?.text = comment?.text
        cell.detailTextLabel?.text = comment?.author.displayName
        
        return cell
    }
}
