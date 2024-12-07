//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    //Variables
    var viewModel: HomeViewModel?
    var baseVCActions: BaseViewAction?
    
    //Outlets
    private var stackView: UIStackView!
    private var collectionView: UICollectionView!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        bind()
    }
    
    //MARK: - Setup Screen
    private func setupScreen() {
        if baseVCActions == nil {
            baseVCActions = DefaultBaseViewAction()
        }
        self.title = "Characters"
        self.view.backgroundColor = .white
        setupStackView()
        createCollection()
        viewModel?.viewDidLoad()
    }
    
    //MARK: - Bind
    private func bind() {
        //MARK: - Bind Loading
        viewModel?.isLoading.observe(on: self, observerBlock: {
            [weak self] show in
            guard let self = self else { return }
            DispatchQueue.main.async {
                show ? self.baseVCActions?.showLoader(on: self) : self.baseVCActions?.hideLoader()
            }
        })
        
        //MARK: - Bind Alert
        viewModel?.showError.observe(on: self, observerBlock: {
            [weak self] message in
            guard let self = self, !message.isEmpty else { return }
            DispatchQueue.main.async {
                self.baseVCActions?.showAlert(on: self, title: "Error", message: message, action: {
                    self.baseVCActions?.dismissAlert()
                } )
            }
        })
        
        //MARK: - Bind Reloading Data
        viewModel?.filteredCharacters.observe(on: self, observerBlock: {
            [weak self] filteredCharacters in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}

extension HomeViewController {
    //MARK: - Setup Stack
    private func setupStackView() {
        self.stackView = UIStackView()
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
    
    //MARK: - Create Collection
    func createCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: self.view.frame.size.width,
            height: 100
        )
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
