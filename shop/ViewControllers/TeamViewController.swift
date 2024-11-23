//
//  TeamViewController.swift
//  shop
//
//  Created by Perejro on 23/11/2024.
//

import UIKit

final class TeamViewController: UIViewController {
    @IBOutlet var nameLabels: [UILabel]!
    @IBOutlet var positionLabels: [UILabel]!
    @IBOutlet var imageViews: [UIImageView]!
    
    private let team = [
        Member(name: "Perejro", position: "IOS Developer", image: "developer"),
        Member(name: "Dima", position: "Designer", image: "designer"),
        Member(name: "Дмитрий", position: "Manager", image: "manager"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        Мне кажется, так читабельней
//        team.enumerated().forEach { index, member in
//            nameLabels[index].text = member.name
//            positionLabels[index].text = member.position
//            imageViews[index].image = UIImage(named: member.image)
//        }
        
        for ((name, position), (image, member)) in zip(zip(nameLabels, positionLabels), zip(imageViews, team)) {
            name.text = member.name
            position.text = member.position
            image.image = UIImage(named: member.image)
            
            image.layer.cornerRadius = 20
        }

    }
    
}
