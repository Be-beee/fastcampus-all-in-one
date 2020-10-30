//
//  DetailViewController.swift
//  Onepiece_wanted
//
//  Created by 서보경 on 2020/10/30.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bountyLabel: UILabel!
    
    var bountyData: (name: String, bounty: Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let name = bountyData?.name, let bounty = bountyData?.bounty {
            imgView.image = UIImage(named: name)
            nameLabel.text = name
            bountyLabel.text = "\(bounty)"
        }
    }

    @IBAction func closeView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
