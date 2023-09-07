//
//  ViewController.swift
//  pr2uikit
//
//  Created by Никита Попов on 6.09.23.
//

import UIKit

class ViewController: UIViewController {
    var someLabel:UILabel!
    var actionButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.createLabel()
        
        self.createActionButton()
        // Do any additional setup after loading the view.
    }
    private func createActionButton(){
        self.actionButton = UIButton()
        self.actionButton.addTarget(self, action: #selector(targetButton), for: .touchUpInside)
        self.actionButton.setTitle("Flag Game", for: .normal)
        self.actionButton.setTitleColor(.black, for: .normal)
        self.actionButton.titleLabel?.textAlignment = .center
        self.actionButton.contentHorizontalAlignment = .center
        self.actionButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        self.actionButton.layer.cornerRadius = 15
        
        self.view.addSubview(actionButton)
        self.actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.actionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            self.actionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.actionButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
            self.actionButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        ])
        
        
        
    }
    
    
    private func createLabel(){
        self.someLabel = UILabel()
        someLabel.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width / 2, height: self.view.bounds.width / 2)
        someLabel.center = self.view.center
        someLabel.text = "Some Label"
        someLabel.textAlignment = .center
        someLabel.layer.borderWidth = 1

        
        someLabel.font = .systemFont(ofSize: 20, weight: .black)
        
        someLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(someLabel)
        
        NSLayoutConstraint.activate([
            self.someLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            self.someLabel.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            self.someLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.someLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc func targetButton(){
        let vc = SomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


}

