import Foundation
import UIKit

class CapturedImageView: UIView {
    
    lazy var cancelButton: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(.red, for: .normal)
        return cancel
    }()
    
    lazy var saveButton: UIButton = {
        let save = UIButton()
        save.setTitle("Save", for: .normal)
        save.setTitleColor(.green, for: .normal)
        return save
    }()
    
    lazy var imagePreviewView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var headerView: UIView = {
        let header = UIView()
        header.layer.opacity = 0.6
        header.backgroundColor = .black 
        return header
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupHeaderView()
        setupImagePreviewView()
        setupCancelButton()
        setupSaveButton()

    }
    
    private func setupHeaderView(){
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15),
            headerView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func setupImagePreviewView(){
        addSubview(imagePreviewView)
        imagePreviewView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePreviewView.topAnchor.constraint(equalTo: topAnchor),
            imagePreviewView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imagePreviewView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imagePreviewView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imagePreviewView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imagePreviewView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    private func setupCancelButton(){
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            cancelButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            ])
    }
    
    private func setupSaveButton(){
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            saveButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
        
    }
}

