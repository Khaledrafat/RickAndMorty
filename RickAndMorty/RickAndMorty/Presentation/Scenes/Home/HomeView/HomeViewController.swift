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
    @IBOutlet weak var collectionView: UICollectionView!

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
        collectionSetup()
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
    
    //MARK: - Collection
    private func collectionSetup() {
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(DefaultHomeCollectionCell.self, forCellWithReuseIdentifier: "DefaultHomeCollectionCell")
        
        let nib = UINib(nibName: "TestCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TestCell")
    }
    
    @IBAction func AllButton(_ sender: Any) {
        self.viewModel?.filter(with: .all)
    }
    
    @IBAction func deadButton(_ sender: Any) {
        self.viewModel?.filter(with: .dead)
    }
    
    @IBAction func aliveButton(_ sender: Any) {
        self.viewModel?.filter(with: .alive)
    }
    
    @IBAction func unknownButton(_ sender: Any) {
        self.viewModel?.filter(with: .unknown)
    }
    
}
