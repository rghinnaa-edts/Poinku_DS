//
//  ProductViewController.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 10/02/25.
//

import UIKit

class StampCardViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var lastContentOffset: CGFloat = 0
    private var visibleCellsBeforeScroll: [IndexPath: CGPoint] = [:]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = StaggeredLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16 , left: 16, bottom: 16, right: 8)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StampCardCell.self, forCellWithReuseIdentifier: "StampCardCell")
        
        view.addSubview(collectionView)
    }
}

extension StampCardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampCardCell", for: indexPath) as! StampCardCell
        
        return cell
    }
}
