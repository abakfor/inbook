//
//  GenreCollectionViewCell.swift
//  Ertakchi
//
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    var book: Book?
    
    lazy var subView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var mainImageView: ActivityImageView = {
        let imageView = ActivityImageView(frame: .zero)
        imageView.layer.cornerRadius = 7
        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage(named: "sample")!
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Harry Potter"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "J.K. Rowling"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")!
        imageView.contentMode = .right
        imageView.tintColor = .label
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
        subView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        subView.addSubview(topImageView)
        subView.addSubview(authorLabel)

        
        topImageView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.centerY.equalTo(authorLabel)
            make.height.width.equalTo(8)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalTo(titleLabel)
            make.left.equalTo(topImageView.snp.right).offset(5)
        }
    }
    
    func setBook(book: BookList) {
        titleLabel.text = book.title
        authorLabel.text = "\(book.overallRanking ?? 0)"
        mainImageView.loadImage(url: book.imageUrl)
    }
}
