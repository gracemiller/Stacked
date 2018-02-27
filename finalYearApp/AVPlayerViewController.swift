import Foundation
import AVFoundation
import UIKit

class AVPlayerViewController: UIViewController {
    
    lazy var saveButton: UIButton = {
        let save = UIButton()
        save.setImage(#imageLiteral(resourceName: "save"), for: .normal)
        //save.frame.size = CGSize(width: 0.5, height: 0.5)
        //save.center = CGPoint(x:320.0, y: 480.0)
        save.frame = CGRect(x: 320, y: 480, width: 35, height: 10);
        return save
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
    
    private func setupSaveButton(){
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            saveButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
        
    }
}

