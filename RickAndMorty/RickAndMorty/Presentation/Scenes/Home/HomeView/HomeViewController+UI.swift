//
//  HomeViewController+UI.swift
//  RickAndMorty
//
//  Created by Khaled on 08/12/2024.
//

import UIKit

extension HomeViewController {
    //MARK: - Setup Stack
    func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        let button1 = createButton(title: "All", tag: 1)
        let button2 = createButton(title: "Alive", tag: 2)
        let button3 = createButton(title: "Dead", tag: 3)
        let button4 = createButton(title: "Unknown", tag: 4)
        
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        stackView.addArrangedSubview(button4)
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //MARK: - Create Button
    private func createButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 20
        button.tag = tag
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
            switch sender.tag {
            case 1:
                self.viewModel?.filter(with: .all)
            case 2:
                self.viewModel?.filter(with: .alive)
            case 3:
                self.viewModel?.filter(with: .dead)
            case 4:
                self.viewModel?.filter(with: .unknown)
            default:
                return
            }
        }
}
