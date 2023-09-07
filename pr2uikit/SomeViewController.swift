//
//  SomeViewController.swift
//  pr2uikit
//
//  Created by Никита Попов on 7.09.23.
//

import UIKit

class SomeViewController: UIViewController {
    private var countries = ["us","uk","spain","russia","poland","nigeria","monaco","italy","ireland", "germany", "france","estonia"].shuffled()
    private var score:Int = 0{
        didSet{
            if score < 0 { score = 0 }
        }
    }
    private var startTime:Date?
    private var stopTime:Date?
    private var countTap:Int = 0
    
    private var someLabel:UILabel!
    private var stopButton:UIButton!
    private var scoreLabel:UILabel!
    
    private var selectedCountrie:String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Flags Game"
        
        
        createStopButton()
        createCountrLabel()
        roundGame()
        
    }
    
    private func createLabel(){
        self.someLabel = UILabel()
        self.view.addSubview(someLabel)
        self.someLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.someLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.someLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.someLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            self.someLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4)
            
        ])
        self.someLabel.text = "SomeLabel"
    }
    
    private func basicButtonFlag(count: Int, h:CGFloat, w:CGFloat, title:String){
        var basicButon = UIButton()
        basicButon.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(basicButon)
        
        let hGap:CGFloat = 150 + 2 * (h * CGFloat(count))
        
        NSLayoutConstraint.activate([
            basicButon.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (count != 0 ? hGap : 150)),
            basicButon.widthAnchor.constraint(equalToConstant: w),
            basicButon.heightAnchor.constraint(equalToConstant: h),
            basicButon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        basicButon.setTitle(title, for: .normal)
        basicButon.setImage(UIImage(named: title), for: .normal)
        basicButon.clipsToBounds = true
        //basicButon.titleLabel?.font = .monospacedSystemFont(ofSize: 20, weight: .light)
        //basicButon.setTitleColor(.black, for: .normal)
        basicButon.layer.cornerRadius = 20
        basicButon.layer.borderWidth = 1
        
        basicButon.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    private func createStopButton(){
        self.stopButton = UIButton()
        self.view.addSubview(stopButton)
        self.stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stopButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
            self.stopButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stopButton.heightAnchor.constraint(equalTo: self.view
                .heightAnchor, multiplier: 0.05),
            self.stopButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        ])
        
        self.stopButton.setTitle("Stop Game", for: .normal)
        self.stopButton.setTitleColor(.white, for: .normal)
        self.stopButton.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        self.stopButton.layer.cornerRadius = 20
        self.stopButton.layer.borderWidth = 1
        
        self.stopButton.addTarget(self, action: #selector(stopGameButtonAct), for: .touchUpInside)
    }
    
    private func createCountrLabel(){
        self.scoreLabel = UILabel()
        self.view.addSubview(scoreLabel)
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scoreLabel.bottomAnchor.constraint(equalTo: self.stopButton.topAnchor, constant: -30),
            self.scoreLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.scoreLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
            self.scoreLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        ])
        self.scoreLabel.textAlignment = .center
        self.scoreLabel.text = "Score: \(self.score)"
        self.scoreLabel.font = .systemFont(ofSize: 20, weight: .regular)
    }
    
    private func roundGame(){
        var roundFlags = [countries.randomElement(),countries.randomElement(),countries.randomElement()]
        self.selectedCountrie = roundFlags.first!!
        self.title = self.selectedCountrie
        roundFlags.shuffle()
        
        for i in 0...2{
            self.basicButtonFlag(count: i, h: 100, w: 200, title: roundFlags[i]!)
        }
    }
    
    private func goodAnswer(){
        roundGame()
        self.score += 1
        self.scoreLabel.text = "Score: \(self.score)"
    }
    
    private func badAnswer(countr: String){
//        if score != 0 {
//            score -= 1
//        }
        score -= 1
        self.scoreLabel.text = "Score: \(self.score)"
        roundGame()
        let alert = UIAlertController(title: "Are you serious?", message: "This countrie is \(countr)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(alertAction)
        
        present(alert, animated: true)
    }

    @objc func buttonAction(_ butt: UIButton){
        countTap += 1
        if countTap == 1{
            self.startTime = Date()
        }
        if butt.titleLabel?.text == self.selectedCountrie{
            goodAnswer()
        }else{
            badAnswer(countr: butt.titleLabel?.text ?? ":(")
        }
    }
    
    @objc func stopGameButtonAct(){
        self.stopTime = Date()
        let diff = Calendar.current.dateComponents([.minute, .second], from: self.startTime ?? Date(), to: self.stopTime ?? Date())
        let alert = UIAlertController(title: "Your Score", message: "\(self.score). Time: \(diff.minute ?? 0)-\(diff.second ?? 0)", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action1)
        present(alert, animated: true)
        
        self.score = 0
        self.countTap = 0
        self.scoreLabel.text = "Score: \(self.score)"
        self.roundGame()
    }
}
