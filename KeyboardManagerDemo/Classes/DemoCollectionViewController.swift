//
//  DemoCollectionViewController.swift
//  KeyboardManagerDemo
//
//  Created by Edouard Siegel on 25/04/2019.
//

import UIKit
import ADKeyboardManager

class DemoCollectionViewController: UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {

    private lazy var collectionView = createCollectionView()
    private lazy var keyboardManager = KeyboardManager(scrollView: collectionView)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CollectionView Demo"
        view.addSubview(collectionView)
        collectionView.ad_pinToSuperview()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardManager.startObservingKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        keyboardManager.stopObservingKeyboard()
        super.viewWillDisappear(animated)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DemoCollectionViewCell = collectionView.dequeueCell(at: indexPath)
        cell.textField.placeholder = String(format: "Cell %1d", indexPath.row)
        return cell
    }

    // MARK: - UICollectionViewDelegate
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 66.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }

    // MARK: - Private

    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cell: .class(DemoCollectionViewCell.self))
        return collectionView
    }
}
