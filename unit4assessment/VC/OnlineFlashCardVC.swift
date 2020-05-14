//
//  OnlineFlashCardVC.swift
//  unit4assessment
//
//  Created by albert coelho oliveira on 10/24/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class OnlineFlashCardVC: UIViewController {
    
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
        getCardsOnline()
        constrainCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getCardsOnline()
        
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
    
    private func getCardsOnline(){
        CardAPI.manager.getWeather { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let flashC):
                    self.cardArr = flashC
                }
            }
        }
    }
    
}

extension OnlineFlashCardVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(cardArr.count)
        return cardArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! FlashCardCell
        let cards = cardArr[indexPath.row]
        cell.title.text = cards.cardTitle
        cell.facts.text = "• \(cards.facts[0])\n \n• \(cards.facts[1])"
        cell.delegate = self
        cell.button.tag = indexPath.row
        cell.backgroundColor = .blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 400)
    }
}

extension OnlineFlashCardVC: ButtonFunction{
    func showActionSheet(tag: Int) {
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an Option",     preferredStyle: .actionSheet)
        
        
        
        let saveAction = UIAlertAction.init(title: "Save", style: .default) { (action) in
            let card = self.cardArr[tag]
            if card.checkCards()!{
                let alert = UIAlertController(title: "", message: "You have saved this card before", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel) { (alert) in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(cancel)
                self.present(alert,animated: true)
                
            }else {
                do{
                    try CardPersistence.manager.saveImage(info: card )
                }catch{
                    print(error)
                }
            }
            let alert = UIAlertController(title: "", message: "Saved", preferredStyle: .alert)
            self.present(alert,animated: true)
            alert.dismiss(animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        optionsMenu.addAction(saveAction)
        optionsMenu.addAction(cancelAction)
        present(optionsMenu, animated: true, completion: nil)
    }
}





