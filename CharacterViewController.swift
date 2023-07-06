//
//  CharacterViewController.swift
//  Swift.cource.hw
//
//  Created by mirrindahh on 04.07.2023.
//

import UIKit

class CharacterViewController: UIViewController {

    var character: Character?
    var label = UILabel()
    var name = UILabel()
    var closeButton = UIButton(type: .system)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(name)
        view.addSubview(label)
        view.addSubview(closeButton)
                
        let width: CGFloat = UIScreen.main.bounds.width / 2
        let height: CGFloat = UIScreen.main.bounds.height / 2
        
        label.frame = CGRect(x: width / 2, y: height / 3, width: width, height: width)
        name.frame = CGRect(x: width / 2, y: height / 3 + width + 16, width: width, height: 30)
        closeButton.frame = CGRect(x: width - 50, y: 20, width: 30, height: 30)
        
        label.backgroundColor = UIColor.lightGray
        label.layer.masksToBounds = true
        label.layer.cornerRadius = width/2
        label.text = character?.image
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 96)
        
        name.text = character?.name
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }

    @objc func closeButtonTapped() {
        // Close the modal and show the updated data
        
        // Update the character data if any fields were changed
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
