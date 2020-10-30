//
//  BountyViewController.swift
//  Onepiece_wanted
//
//  Created by 서보경 on 2020/10/30.
//

import UIKit

class BountyViewController: UIViewController {

    let bountyList: [(name: String, bounty: Int)] = [
        ("brook", 33000000),
        ("chopper", 50),
        ("franky", 44000000),
        ("luffy", 300000000),
        ("nami", 16000000),
        ("robin", 80000000),
        ("sanji", 77000000),
        ("zoro", 120000000)
    ]
    @IBOutlet var bountyTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                detailVC?.bountyData = (name: bountyList[index].name, bounty: bountyList[index].bounty)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension BountyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bountyTableView.dequeueReusableCell(withIdentifier: "bountyCell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        cell.imgView.image = UIImage(named: bountyList[indexPath.row].name)
        cell.nameLabel.text = bountyList[indexPath.row].name
        cell.bountyLabel.text = String(bountyList[indexPath.row].bounty)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }

}

class ListCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bountyLabel: UILabel!
    
}
