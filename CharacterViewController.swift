//
//  CharacterViewController.swift
//  Swift.cource.hw
//
//  Created by mirrindahh on 04.07.2023.
//

import UIKit

class CharacterViewController: UIViewController, UITextFieldDelegate {
    
    var character: RMCharacterModel?
    var label = UILabel()
    var nameLabel = UILabel()
    var statusLabel = UILabel()
    var speciesLabel = UILabel()
    var genderLabel = UILabel()
    var nameTextField = UILabel()
    var statusTextField = UILabel()
    var speciesTextField = UILabel()
    var genderTextField = UITextField()
    var statusSegmentedControl = UISegmentedControl(items: ["Alive", "Dead"])
    var locationLabel = UILabel()
    var locationTextField = UITextField()
//    var closeButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(nameLabel)
        view.addSubview(statusLabel)
        view.addSubview(speciesLabel)
        view.addSubview(genderLabel)
        view.addSubview(nameTextField)
        view.addSubview(statusTextField)
        view.addSubview(speciesTextField)
        view.addSubview(genderTextField)
        view.addSubview(statusSegmentedControl)
        view.addSubview(locationLabel)
        view.addSubview(locationTextField)
//        view.addSubview(closeButton)
        
        let width: CGFloat = UIScreen.main.bounds.width / 2
        let height: CGFloat = UIScreen.main.bounds.height / 2
        
        label.frame = CGRect(x: width / 2, y: height / 3, width: width, height: width)
        nameLabel.frame = CGRect(x: width / 2, y: height / 3 + width + 16, width: width, height: 30)
        statusLabel.frame = CGRect(x: width / 2, y: height / 3 + width + 16 + 40, width: width, height: 30)
        speciesLabel.frame = CGRect(x: width / 2, y: height / 3 + width + 16 + 80, width: width, height: 30)
        genderLabel.frame = CGRect(x: width / 2, y: height / 3 + width + 16 + 120, width: width, height: 30)
        nameTextField.frame = CGRect(x: width / 2 + 100, y: height / 3 + width + 16, width: width - 100, height: 30)
        statusTextField.frame = CGRect(x: width / 2 + 100, y: height / 3 + width + 16 + 40, width: width - 100, height: 30)
        speciesTextField.frame = CGRect(x: width / 2 + 100, y: height / 3 + width + 16 + 80, width: width - 100, height: 30)
        genderTextField.frame = CGRect(x: width / 2 + 100, y: height / 3 + width + 16 + 120, width: width - 100, height: 30)
        statusSegmentedControl.frame = CGRect(x: width / 2 + 100, y: height / 3 + width + 16 + 40, width: width - 100, height: 30)
        locationLabel.frame = CGRect(x: width / 2, y: height / 3 + width + 16 + 160, width: width, height: 30)
        locationTextField.frame = CGRect(x: width / 2 + 100, y: height / 3 + width + 16 + 160, width: width - 100, height: 30)
//        closeButton.frame = CGRect(x: width - 15, y: 20 + height / 3 + width + 16 + 200, width: 30, height: 30)
        
        label.backgroundColor = UIColor.lightGray
        label.layer.masksToBounds = true
        label.layer.cornerRadius = width / 2
        label.text = "Image"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 96)
        
        nameLabel.text = "Name"
        statusLabel.text = "Status"
        speciesLabel.text = "Species"
        genderLabel.text = "Gender"
        locationLabel.text = "Location"
        
        locationTextField.text = character?.location.name
        nameTextField.text = character?.name
        speciesTextField.text = character?.species
        genderTextField.text = character?.gender
        
        statusSegmentedControl.selectedSegmentIndex = character?.status == "Dead" ? 1 : 0
        
        genderTextField.delegate = self
        
//        closeButton.setTitle("Close", for: .normal)
//        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
//    }
//
//    @objc func closeButtonTapped() {
        if statusSegmentedControl.selectedSegmentIndex == 0 {
                    character?.status = "Alive"
        } else {
            character?.status = "Dead"
        }
        
        if let gender = genderTextField.text {
            character?.gender = gender
        }
        
        dismiss(animated: true) {
//            print(self.character)
        }
    }
    
    // MARK: - UITextFieldDelegate
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
}
