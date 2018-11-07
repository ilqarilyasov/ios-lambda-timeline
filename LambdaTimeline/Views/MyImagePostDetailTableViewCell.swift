//
//  MyImagePostDetailTableViewCell.swift
//  LambdaTimeline
//
//  Created by Ilgar Ilyasov on 11/6/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

protocol MyImagePostDetailTableViewCellDelegate: class {
    func playButtonTapped(on cell: MyImagePostDetailTableViewCell)
}

class MyImagePostDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    weak var delegate: MyImagePostDetailTableViewCellDelegate?
    
    @IBAction func playButtonTapped(_ sender: Any) {
        delegate?.playButtonTapped(on: self)
    }
}
