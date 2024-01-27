//
//  NoInternetViewController.swift
//  TourismApp
//
//

import UIKit

class NoInternetViewController: UIViewController {
    
    lazy var subView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var noInternetView: NoInternetView = {
        let view = NoInternetView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        initViews()
    }
    
    private func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(noInternetView)
        noInternetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
