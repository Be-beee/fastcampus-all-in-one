//
//  DetailViewController.swift
//  Onepiece_wanted
//
//  Created by 서보경 on 2020/10/30.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MVVM
    
    // Model
    // - BountyInfo
    
    // View
    // - imgView, nameLabel, bountyLabel
    
    // ViewModel
    // - DetailViewModel
    
    let viewModel = DetailViewModel()
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bountyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let bountyInfo = viewModel.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }

    @IBAction func closeView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - ViewModel
class DetailViewModel {
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?) {
        bountyInfo = model
    }
}
