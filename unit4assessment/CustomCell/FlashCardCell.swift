//
//  FlashCardCell.swift
//  unit4assessment
//
//  Created by albert coelho oliveira on 10/24/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FlashCardCell: UICollectionViewCell {
    var check = true
    weak var delegate: ButtonFunction?
    lazy var title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        return title
    }()
    lazy var facts: UITextView = {
        let facts = UITextView ()
        facts.backgroundColor = .orange
        facts.isHidden = true
        facts.isSelectable = false
        return facts
    }()
    lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonAction(sender: )), for: .touchUpInside)
        button.setTitle("...", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    @IBAction func buttonAction(sender: UIButton){
        delegate?.showActionSheet(tag: sender.tag)
    }
    private func setUpTap(){
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(tapCell))
        self.addGestureRecognizer(gesture)
    }
    @IBAction func tapCell(sender: UIButton){
        if check {
            UIView.transition(with: self, duration: 1, options: .transitionFlipFromBottom, animations:{
                self.facts.isHidden = false
                self.check = false
            })}
        else{
            UIView.transition(with: self, duration: 1, options: .transitionFlipFromBottom, animations: {
                self.facts.isHidden = true
                self.check = true
            })
        }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        constrainTitle()
        constrainFacts()
        constrainButton()
        setUpTap()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func constrainTitle(){
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        [title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
         title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44),
         title.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.50),
         title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -44)
            ].forEach{$0.isActive = true}
    }
    
    private func constrainFacts(){
        contentView.addSubview(facts)
        facts.translatesAutoresizingMaskIntoConstraints = false
        [facts.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 11),
         facts.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
         facts.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.40),
         facts.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33)
            ].forEach{$0.isActive = true}
    }
    private func constrainButton(){
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        [
            button.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 10),
            button.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            
            ].forEach{$0.isActive = true}
    }
    
}
