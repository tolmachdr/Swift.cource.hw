//
//  CharacterCell.swift
//  Swift.cource.hw
//
//  Created by Kulbatchayev Timyr on 03.07.2023.
//

import UIKit

class CharacterCell: UITableViewCell {

    static let identifier = "Character"
    
    let characterLabel: UILabel = {
       var label = UILabel()
        
        label.textColor = UIColor.white
        label.layer.cornerRadius = 70
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.backgroundColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()

    let name: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CharacterCell.identifier)
        setupCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCell() {
        [characterLabel, name].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
        
            characterLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            characterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            characterLabel.heightAnchor.constraint(equalToConstant: 80),
            characterLabel.widthAnchor.constraint(equalToConstant: 80),
            
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            name.leadingAnchor.constraint(equalTo: characterLabel.leadingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(character: Character) {
        characterLabel.text = character.image
        name.text = character.name
    }
}
