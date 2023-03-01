//
//  CustomTableViewCell.swift
//  PreOnBoarding
//
//  Created by sejin jeong on 2023/03/02.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    var buttonAction : (()-> Void)?
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
        
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor.blue
        progressView.trackTintColor = UIColor.gray
        progressView.progress = 0.5
        return progressView
    }()
        
    let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutolayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setAutolayout(){
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumbnailImageView)
        addSubview(progressView)
        addSubview(loadButton)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 80),
            
            progressView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: loadButton.leadingAnchor, constant: -10),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            loadButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            loadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            loadButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setButtonAction(_ action: @escaping ()->Void){
        buttonAction = action
        loadButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(){
        buttonAction?()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let buttonPoint = convert(point, to: loadButton)
        if loadButton.point(inside: buttonPoint, with: event) {
            return loadButton
        }
        return super.hitTest(point, with: event)
    }

}

