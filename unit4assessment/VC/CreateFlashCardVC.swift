//
//  CreateFlashCardVC.swift
//  unit4assessment
//
//  Created by albert coelho oliveira on 10/24/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class CreateFlashCardVC: UIViewController {
    
    lazy var saveButton: UIButton = {
        var saveButton = UIButton()
        saveButton.addTarget(self, action: #selector(saveAction(sender:)), for: .touchDown)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitle("Save", for: .normal)
        return saveButton
    }()
    @IBAction func saveAction(sender: UIButton) {
        if checkFacts() && checkTitle(){
            
            let card = flashCard(id: nil,cardTitle: factTitleInput.text!, facts: [firstFact.text!, secondFact.text!])
            try? CardPersistence.manager.saveImage(info: card)
            
            let alert = UIAlertController(title: "", message: "Saved", preferredStyle: .alert)
            self.present(alert,animated: true)
            alert.dismiss(animated: true, completion: nil)
            clearFields()
        }else {
            let alert = UIAlertController(title: "", message: "Please fill out all fields", preferredStyle: .alert)
            self.present(alert,animated: true)
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    private func clearFields(){
        factTitleInput.text = ""
        firstFact.text = ""
        secondFact.text = ""
        
    }
    private func checkTitle() -> Bool{
        if let userTitle = factTitleInput.text{
            if !userTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                return true
            }
        }
        return false
    }
    
    private func checkFacts() -> Bool{
        if let firstFact = firstFact.text{
            if let secondFact = secondFact.text{
                if !firstFact.trimmingCharacters(in: .whitespaces).isEmpty && !secondFact.trimmingCharacters(in: .whitespaces).isEmpty{
                    return true
                }else {
                }
            }
        }
        return false
    }
    lazy var factTitleInput: UITextField = {
        let titleText = UITextField()
        titleText.placeholder = "Title"
        titleText.font = UIFont.systemFont(ofSize: 20)
        return titleText
    }()
    
    lazy var firstFact: UITextView = {
        let firstFact = UITextView()
        firstFact.text = "Fact 1"
        firstFact.backgroundColor = .white
        firstFact.font = UIFont.systemFont(ofSize: 20)
        firstFact.delegate = self
        
        return firstFact
    }()
    
    lazy var secondFact: UITextView = {
        let secondFact = UITextView()
        secondFact.text = "Fact 2"
        secondFact.delegate = self
        secondFact.font = UIFont.systemFont(ofSize: 20)
        secondFact.backgroundColor = .white
        return secondFact
    }()
    
    
    private func constrainFactTitle(){
        view.addSubview(factTitleInput)
        factTitleInput.translatesAutoresizingMaskIntoConstraints = false
        [factTitleInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         factTitleInput.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
         factTitleInput.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10),
         factTitleInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40)
            ].forEach{$0.isActive = true}
        
    }
    private func constrainFirstFact(){
        view.addSubview(firstFact)
        firstFact.translatesAutoresizingMaskIntoConstraints = false
        [firstFact.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         firstFact.topAnchor.constraint(equalTo: factTitleInput.bottomAnchor, constant: 0),
         firstFact.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30),
         firstFact.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)
            ].forEach{$0.isActive = true}
        
    }
    private func constrainSecondFact(){
        view.addSubview(secondFact)
        secondFact.translatesAutoresizingMaskIntoConstraints = false
        [secondFact.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         secondFact.topAnchor.constraint(equalTo: firstFact.bottomAnchor, constant: 20),
         secondFact.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30),
         secondFact.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)
            ].forEach{$0.isActive = true}
        
    }
    private func constrainButton(){
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        [saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         saveButton.topAnchor.constraint(equalTo: secondFact.bottomAnchor, constant: 30),
         saveButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
         saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30)
            ].forEach{$0.isActive = true}
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        constrainFactTitle()
        constrainFirstFact()
        constrainSecondFact()
        constrainButton()
    }
    private func setUpView(){
        view.backgroundColor = .systemTeal
    }
    
}
extension CreateFlashCardVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
  
    }

