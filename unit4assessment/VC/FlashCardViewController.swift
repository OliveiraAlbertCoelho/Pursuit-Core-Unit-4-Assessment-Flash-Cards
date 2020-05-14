//
//  FlashCardViewController.swift
//  unit4assessment
//
//  Created by albert coelho oliveira on 10/24/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FlashCardViewController: UIViewController {
    
    var cardArr = [flashCard](){
        didSet{
            flashCardCollection.reloadData()
        }
    }
    lazy var flashCardCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemTeal
        cv.register(FlashCardCell.self, forCellWithReuseIdentifier: "cardCell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getCards()
        constrainCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getCards()
        
    }
    private func constrainCollection(){
        view.addSubview(flashCardCollection)
        flashCardCollection.translatesAutoresizingMaskIntoConstraints = false
        [flashCardCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
         flashCardCollection.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: 0),
         flashCardCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
         flashCardCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            ].forEach{$0.isActive = true}
    }
    
    
    
    private func setUpView(){
        view.backgroundColor = .white
    }
    private func getCards(){
        do {
            cardArr = try CardPersistence.manager.getImage()
        }catch{
            print(error)
        }}}

extension FlashCardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(cardArr.count)
        return cardArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! FlashCardCell
        let cards = cardArr[indexPath.row]
        cell.delegate = self
        cell.button.tag = indexPath.row
        cell.title.text = cards.cardTitle
        cell.facts.text = "• \(cards.facts[0])\n \n• \(cards.facts[1])"
        cell.backgroundColor = .blue
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 400)
    }
    
    
}


extension FlashCardViewController: ButtonFunction{
    func showActionSheet(tag: Int) {
        
        
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an Option", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            do{
                try CardPersistence.manager.deleteImage(Int: tag)
                self.getCards()
                
            }catch{
                print(error)
            }
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(cancelAction)
        present(optionsMenu, animated: true, completion: nil)
    }
    
}


