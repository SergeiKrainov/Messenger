//
//  NewConversationCell.swift
//  Messenger
//
//  Created by Sergey on 12.07.2022.
//

import Foundation
import SDWebImage

class NewConversationCell: UITableViewCell {
    
    static let identifier = "NewConversationCell"
    
    
    private let userImageVIew: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageVIew)
        contentView.addSubview(userNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageVIew.frame = CGRect(x: 10,
                                     y: 10,
                                     width: 70,
                                     height: 70)
        
        userNameLabel.frame = CGRect(x: userImageVIew.right + 10,
                                     y: 20,
                                     width: contentView.width - 20 - userImageVIew.width,
                                     height: 50)
    }
    
    public func configure(with model: SearchResult) {
        userNameLabel.text = model.name
        
        let path = "images/\(model.email)_profile_picture.png"
        StorageManager.shared.downloadUrl(for: path, completion: { [weak self] result in
            switch result {
            case .success(let url):
                
                DispatchQueue.main.async {
                    self?.userImageVIew.sd_setImage(with: url, completed: nil)
                }
                
            case .failure(let error):
                print("failed to get url: \(error)")
            }
        })
    }
}
