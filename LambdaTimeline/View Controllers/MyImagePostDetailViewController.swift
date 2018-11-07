//
//  MyImagePostDetailViewController.swift
//  LambdaTimeline
//
//  Created by Ilgar Ilyasov on 11/6/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import AVFoundation

class MyImagePostDetailViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        recordAudioView.isHidden = true
        
        updateViews()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 // Default value
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        
        if recordAudioView.isHidden {
            tableViewBottomConstraint = NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: recordAudioView, attribute: .top, multiplier: 1, constant: 8)
            recordAudioView.isHidden = false
        } else {
            tableViewBottomConstraint = NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: sendCommentView, attribute: .top, multiplier: 1, constant: 8)
            recordAudioView.isHidden = true
        }
    }
    
    @IBAction func commentTextFieldAction(_ sender: Any) {
        let image: UIImage = commentTextField.text != nil ? #imageLiteral(resourceName: "send") : #imageLiteral(resourceName: "microphone")
        audioCommentButton.setImage(image, for: .normal)
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
        requestRecordPermission()
        
        guard !isRecording else {
            recorder?.stop()
            return
        }
        
        do {
            let format = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2)!
            recorder = try AVAudioRecorder(url: newRecordingURL(), format: format)
            recorder?.delegate = self
            recorder?.record()
        } catch {
            NSLog("Unable to start recording: \(error.localizedDescription)")
        }
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        guard let audioURL = recordingURL else { return }
        
        guard !isPlaying else {
            player?.pause()
            return
        }
        
        if player != nil && !isPlaying {
            player?.play()
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.delegate = self
            player?.play()
        } catch {
            NSLog("Unable to play audio: \(error.localizedDescription)")
        }
    }
    
    // Delegate funcs
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.recorder = nil
        updateButton()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.player = nil
        updateButton()
    }
    
    @IBAction func sendAudioTapped(_ sender: Any) {
        
    }
    
    @IBAction func sendTextTapped(_ sender: Any) {
        guard let commentText = commentTextField?.text, !commentText.isEmpty else { return }
        self.postController.addComment(with: commentText, to: &self.post!)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.commentTextField.text = ""
        }
    }
    
    func requestRecordPermission() {
        let session = AVAudioSession.sharedInstance()
        
        session.requestRecordPermission { (granted) in
            guard granted else {
                NSLog("Please give the application permission to record in Settings")
                return
            }
            
            do {
                try session.setCategory(.playAndRecord, mode: .default, options: [])
                try session.setActive(true, options: [])
            } catch {
                NSLog("Error setting AVAudioSession: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateCellButton(for button: UIButton) {
        let playingImage: UIImage = (isPlaying ? UIImage(named: "record-64") : UIImage(named: "stop-64"))!
        button.setImage(playingImage, for: .normal)
    }
    
    private func updateButton() {
        let recordingImage: UIImage = (isPlaying ? UIImage(named: "record-64") : UIImage(named: "stop-64"))!
        recordButton.setImage(recordingImage, for: .normal)
        
        let playingImage: UIImage = (isPlaying ? UIImage(named: "play") : UIImage(named: "stop"))!
        playButton.setImage(playingImage, for: .normal)
    }
    
    private func newRecordingURL() -> URL {
        let documentDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return documentDir.appendingPathComponent(UUID().uuidString).appendingPathExtension("caf")
    }
    
    var post: Post!
    var postController: PostController!
    var imageData: Data?
    
    private var bottomConstraint: NSLayoutConstraint!
    private var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    private var recordingURL: URL?
    
    private var isRecording: Bool {
        return recorder?.isRecording ?? false
    }
    
    private var isPlaying: Bool {
        return player?.isPlaying ?? false
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var recordAudioView: UIView!
    @IBOutlet weak var sendCommentView: UIView!
    @IBOutlet weak var audioCommentButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
}

extension MyImagePostDetailViewController: UITableViewDelegate, UITableViewDataSource, MyImagePostDetailTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (post?.comments.count ?? 0) - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? MyImagePostDetailTableViewCell else {
            fatalError("MyImagePostDetailTableViewCell couln't be found")
        }
        
        let comment = post?.comments[indexPath.row + 1]
        
        cell.delegate = self
        cell.commentLabel.numberOfLines = 0
        cell.commentLabel.text = comment?.text
        cell.authorLabel.text = comment?.author.displayName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func playButtonTapped(on cell: MyImagePostDetailTableViewCell) {
        cell.playButton.isHidden = false
        updateCellButton(for: cell.playButton)
    }
}
