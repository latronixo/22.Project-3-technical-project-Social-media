//
//  DetailViewController.swift
//  16. Setting up (UIKit)
//
//  Created by Валентин Картошкин on 20.04.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var pictureId: Int?
    var countOfPictures: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = pictureId, let count = countOfPictures {
            title = "Picture \(id+1) of \(count)"
        }
        
        //заголовок делаем не большим
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageName = selectedImage {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else
        {
            print("No image found")
            return
        }
        
        guard let imageName = selectedImage else { return }
        
        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    
}
