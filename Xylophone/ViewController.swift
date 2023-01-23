//
//  ViewController.swift
//  Xylophone
//
//  Created by Никита Ясеник on 17.01.2023.
//

import UIKit
import SwiftUI
import AVFoundation


class ViewController: UIViewController {
    
    var player: AVAudioPlayer!

    func createButton(symbol text: String, color clr: UIColor) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = text
        config.baseBackgroundColor = clr
        config.baseForegroundColor = .black
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "TimesNewRomanPSMT", size: 30) ?? .systemFont(ofSize: 40)
            return outgoing
         }
        let button = UIButton(configuration: config, primaryAction: UIAction(){ _ in
            print(text)
            self.soundPlay(nameSound: text)
        })
        
        return button
    }
    
    func soundPlay(nameSound: String) {
        guard let url = Bundle.main.url(forResource: nameSound, withExtension: "wav") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
        
    }

    
    lazy var mainStackView: UIStackView = {
        let buttonC = createButton(symbol: "C", color: .red)
        let buttonD = createButton(symbol: "D", color: .orange)
        let buttonE = createButton(symbol: "E", color: .yellow)
        let buttonF = createButton(symbol: "F", color: .green)
        let buttonG = createButton(symbol: "G", color: .purple)
        let buttonA = createButton(symbol: "A", color: .blue)
        let buttonB = createButton(symbol: "B", color: .systemPink)
        
        let arr = [buttonB, buttonA, buttonG, buttonF, buttonE, buttonD, buttonC]
        
        let stack = UIStackView(arrangedSubviews: [
            buttonC,
            buttonD,
            buttonE,
            buttonF,
            buttonG,
            buttonA,
            buttonB,
            ])
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        
        
        var constraintsArray: [NSLayoutConstraint] = [
            buttonB.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            buttonB.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 40),
            buttonB.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -40),
        ]
        var start: CGFloat = 35
        for i in 1..<arr.count {
            constraintsArray.append(arr[i].bottomAnchor.constraint(equalTo: arr[i-1].topAnchor, constant: -10))
            constraintsArray.append(arr[i].leftAnchor.constraint(equalTo: stack.leftAnchor, constant: start))
            constraintsArray.append(arr[i].rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -start))
            start -= 5
        }
        
        
        NSLayoutConstraint.activate(constraintsArray)
        
        return stack
        
    }()
    
    
    
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(mainStackView)
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }


}

struct MyProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return ViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}


