//
//  ImagePostViewController.swift
//  LambdaTimeline
//
//  Created by Spencer Curtis on 10/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import Photos

class ImagePostViewController: ShiftableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageViewHeight(with: 1.0)
        
        hideLabels()
        
        let noFilterTapGesture = UITapGestureRecognizer(target: self, action: #selector(noFilterImageViewTapped))
        noFilterImageView.addGestureRecognizer(noFilterTapGesture)
        
        let vintageTapGesture = UITapGestureRecognizer(target: self, action: #selector(vintageImageViewTapped))
        vintageImageView.addGestureRecognizer(vintageTapGesture)
        
        let monoTapGesture = UITapGestureRecognizer(target: self, action: #selector(monoImageViewTapped))
        invertImageView.addGestureRecognizer(monoTapGesture)
        
        let noirTapGesture = UITapGestureRecognizer(target: self, action: #selector(noirImageViewTapped))
        noirImageView.addGestureRecognizer(noirTapGesture)
        
        let coolTapGesture = UITapGestureRecognizer(target: self, action: #selector(coolImageViewTapped))
        coolImageView.addGestureRecognizer(coolTapGesture)
        
        let warmTapGesture = UITapGestureRecognizer(target: self, action: #selector(warmImageViewTapped))
        warmImageView.addGestureRecognizer(warmTapGesture)
        
        updateViews()
    }
    
    
    @objc func noFilterImageViewTapped() {
        print("noFilterImageViewTapped")
        guard let originalImage = originalImage else { return }
        imageView.image = originalImage
        
        vintageImageView.layer.borderWidth = 0
        invertImageView.layer.borderWidth = 0
        noirImageView.layer.borderWidth = 0
        coolImageView.layer.borderWidth = 0
        warmImageView.layer.borderWidth = 0
        noFilterImageView.layer.borderWidth = 2
        let white: UIColor = .red
        noFilterImageView.layer.borderColor = white.cgColor
    }
    
    @objc func vintageImageViewTapped() {
        print("vintageImageViewTapped")
        guard let originalImage = originalImage else { return }
        
        DispatchQueue.global().async {
            let filteredImage = self.apply(filter: self.vintageFilter, for: originalImage)
            DispatchQueue.main.async {
                self.imageView.image = filteredImage
            }
        }
        
        noFilterImageView.layer.borderWidth = 0
        invertImageView.layer.borderWidth = 0
        noirImageView.layer.borderWidth = 0
        coolImageView.layer.borderWidth = 0
        warmImageView.layer.borderWidth = 0
        vintageImageView.layer.borderWidth = 2
        let white: UIColor = .red
        vintageImageView.layer.borderColor = white.cgColor
    }
    
    @objc func monoImageViewTapped() {
        print("monoImageViewTapped")
        guard let originalImage = originalImage else { return }
        
        DispatchQueue.global().async {
            let filteredImage = self.apply(filter: self.invertFilter, for: originalImage)
            DispatchQueue.main.async {
                self.imageView.image = filteredImage
            }
        }
        
        vintageImageView.layer.borderWidth = 0
        noFilterImageView.layer.borderWidth = 0
        noirImageView.layer.borderWidth = 0
        coolImageView.layer.borderWidth = 0
        warmImageView.layer.borderWidth = 0
        invertImageView.layer.borderWidth = 2
        let white: UIColor = .red
        invertImageView.layer.borderColor = white.cgColor
    }
    
    @objc func noirImageViewTapped() {
        print("noirImageViewTapped")
        guard let originalImage = originalImage else { return }
        
        DispatchQueue.global().async {
            let filteredImage = self.apply(filter: self.monoFilter, for: originalImage)
            DispatchQueue.main.async {
                self.imageView.image = filteredImage
            }
        }
        
        vintageImageView.layer.borderWidth = 0
        invertImageView.layer.borderWidth = 0
        noFilterImageView.layer.borderWidth = 0
        coolImageView.layer.borderWidth = 0
        warmImageView.layer.borderWidth = 0
        noirImageView.layer.borderWidth = 2
        let white: UIColor = .red
        noirImageView.layer.borderColor = white.cgColor
    }
    
    @objc func coolImageViewTapped() {
        print("coolImageViewTapped")
        guard let originalImage = originalImage else { return }
        
        DispatchQueue.global().async {
            let filteredImage = self.apply(filter: self.coolFilter, for: originalImage)
            DispatchQueue.main.async {
                self.imageView.image = filteredImage
            }
        }
        
        vintageImageView.layer.borderWidth = 0
        invertImageView.layer.borderWidth = 0
        noirImageView.layer.borderWidth = 0
        noFilterImageView.layer.borderWidth = 0
        warmImageView.layer.borderWidth = 0
        coolImageView.layer.borderWidth = 2
        let white: UIColor = .red
        coolImageView.layer.borderColor = white.cgColor
    }
    
    @objc func warmImageViewTapped() {
        print("warmImageViewTapped")
        guard let originalImage = originalImage else { return }
        
        DispatchQueue.global().async {
            let filteredImage = self.apply(filter: self.warmFilter, for: originalImage)
            DispatchQueue.main.async {
                self.imageView.image = filteredImage
            }
        }
        
        vintageImageView.layer.borderWidth = 0
        invertImageView.layer.borderWidth = 0
        noirImageView.layer.borderWidth = 0
        coolImageView.layer.borderWidth = 0
        noFilterImageView.layer.borderWidth = 0
        warmImageView.layer.borderWidth = 2
        let white: UIColor = .red
        warmImageView.layer.borderColor = white.cgColor
    }
    
    // 5. Update Image function added
    
    func updateImage() {
        let size = CGSize(width: 60, height: 60)
        guard let originalImage = originalImage else { return }
        
        imageView.image = originalImage
        noFilterImageView.image = UIImage.scaleImage(image: originalImage, size: size)
        
        DispatchQueue.global().async {
            let filteredVintage: UIImage = self.apply(filter: self.vintageFilter, for: originalImage)
            let scaledVintage = UIImage.scaleImage(image: filteredVintage, size: size)
            DispatchQueue.main.async {
                self.vintageImageView.image = scaledVintage
            }
        }
        
        DispatchQueue.global().async {
            let filteredMono: UIImage = self.apply(filter: self.invertFilter, for: originalImage)
            let scaledMono = UIImage.scaleImage(image: filteredMono, size: size)
            DispatchQueue.main.async {
                self.invertImageView.image = scaledMono
            }
        }
        
        DispatchQueue.global().async {
            let filteredNoir: UIImage = self.apply(filter: self.monoFilter, for: originalImage)
            let scaledNoir = UIImage.scaleImage(image: filteredNoir, size: size)
            DispatchQueue.main.async {
                self.noirImageView.image = scaledNoir
            }
        }
        
        DispatchQueue.global().async {
            let filteredCool: UIImage = self.apply(filter: self.coolFilter, for: originalImage)
            let scaledCool = UIImage.scaleImage(image: filteredCool, size: size)
            DispatchQueue.main.async {
                self.coolImageView.image = scaledCool
            }
        }
        
        DispatchQueue.global().async {
            let filteredWarm: UIImage = self.apply(filter: self.warmFilter, for: originalImage)
            let scaledWarm = UIImage.scaleImage(image: filteredWarm, size: size)
            DispatchQueue.main.async {
                self.warmImageView.image = scaledWarm
            }
        }
    }
    
    // 8. Hide labels
    
    private func hideLabels(){
        addFilterLabel.isHidden = true
        noFilterLabel.isHidden = true
        vintageLabel.isHidden = true
        invertLabel.isHidden = true
        noirLabel.isHidden = true
        coolLabel.isHidden = true
        warmLabel.isHidden = true
        moreButton.isHidden = true
        moreFiltersSegmentedControl.isHidden = true
        firstSliderLabel.isHidden = true
        firstSlider.isHidden = true
        secondSliderLabel.isHidden = true
        secondSlider.isHidden = true
    }
    
    // 10. Show labels
    
    private func showLabels() {
        addFilterLabel.isHidden = false
        noFilterLabel.isHidden = false
        vintageLabel.isHidden = false
        invertLabel.isHidden = false
        noirLabel.isHidden = false
        coolLabel.isHidden = false
        warmLabel.isHidden = false
        moreButton.isHidden = false
    }
    
    func updateViews() {
        
        guard let imageData = imageData,
            let image = UIImage(data: imageData) else {
                title = "New Post"
                return
        }
        
        title = post?.title
        
        setImageViewHeight(with: image.ratio)
        
        imageView.image = image
        
        chooseImageButton.setTitle("", for: [])
    }
    
    private func presentImagePickerController() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            presentInformationalAlertController(title: "Error", message: "The photo library is unavailable")
            return
        }
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func createPost(_ sender: Any) {
        
        view.endEditing(true)
        
        
        
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.1),
            let title = titleTextField.text, title != "" else {
            presentInformationalAlertController(title: "Uh-oh", message: "Make sure that you add a photo and a caption before posting.")
            return
        }
        
        postController.createPost(with: title, ofType: .image, mediaData: imageData, ratio: imageView.image?.ratio) { (success) in
            guard success else {
                DispatchQueue.main.async {
                    self.presentInformationalAlertController(title: "Error", message: "Unable to create post. Try again.")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case .authorized:
            presentImagePickerController()
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization { (status) in
                
                guard status == .authorized else {
                    NSLog("User did not authorize access to the photo library")
                    self.presentInformationalAlertController(title: "Error", message: "In order to access the photo library, you must allow this application access to it.")
                    return
                }
                
                self.presentImagePickerController()
            }
            
        case .denied:
            self.presentInformationalAlertController(title: "Error", message: "In order to access the photo library, you must allow this application access to it.")
        case .restricted:
            self.presentInformationalAlertController(title: "Error", message: "Unable to access the photo library. Your device's restrictions do not allow access.")
            
        }
        presentImagePickerController()
    }
    
    func setImageViewHeight(with aspectRatio: CGFloat) {
        
        imageHeightConstraint.constant = imageView.frame.size.width * aspectRatio
        
        view.layoutSubviews()
    }
    
    var postController: PostController!
    var post: Post?
    var imageData: Data?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    // 1. Added outlets
    @IBOutlet weak var addFilterLabel: UILabel!
    @IBOutlet weak var noFilterLabel: UILabel!
    @IBOutlet weak var noFilterImageView: UIImageView!
    @IBOutlet weak var vintageLabel: UILabel!
    @IBOutlet weak var vintageImageView: UIImageView!
    @IBOutlet weak var invertLabel: UILabel!
    @IBOutlet weak var invertImageView: UIImageView!
    @IBOutlet weak var noirLabel: UILabel!
    @IBOutlet weak var noirImageView: UIImageView!
    @IBOutlet weak var coolLabel: UILabel!
    @IBOutlet weak var coolImageView: UIImageView!
    @IBOutlet weak var warmLabel: UILabel!
    @IBOutlet weak var warmImageView: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreFiltersStackView: UIStackView!
    @IBOutlet weak var moreFiltersSegmentedControl: UISegmentedControl!
    @IBOutlet weak var firstSliderLabel: UILabel!
    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondSliderLabel: UILabel!
    @IBOutlet weak var secondSlider: UISlider!
    
    
    
    // 11. Actions
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        if moreFiltersSegmentedControl.selectedSegmentIndex == 0 && moreFiltersSegmentedControl.selectedSegmentIndex == 1 {
            changeButtonName()
            hideUnhideFirst()
            hideUnhideSecond()
        } else if moreFiltersSegmentedControl.selectedSegmentIndex == 2 {
            changeButtonName()
            hideUnhideFirst()
            hideUnhideSecond()
        } else {
            changeButtonName()
            hideUnhideFirst()
        }
    }
    
    func hideUnhideFirst() {
        if moreFiltersSegmentedControl.isHidden {
            moreFiltersSegmentedControl.isHidden = false
        } else {
            moreFiltersSegmentedControl.isHidden = true
        }
        
        if firstSliderLabel.isHidden {
            firstSliderLabel.isHidden = false
        } else {
            firstSliderLabel.isHidden = true
        }
        
        if firstSlider.isHidden {
            firstSlider.isHidden = false
        } else {
            firstSlider.isHidden = true
        }
    }
    
    func hideUnhideSecond() {
        if secondSlider.isHidden {
            secondSlider.isHidden = false
        } else {
            secondSlider.isHidden = true
        }
        
        if secondSliderLabel.isHidden {
            secondSliderLabel.isHidden = false
        } else {
            secondSliderLabel.isHidden = true
        }
    }
    
    func changeButtonName() {
        if moreButton.titleLabel?.text == "More" {
            moreButton.setTitle("Close", for: .normal)
        } else {
            moreButton.setTitle("More", for: .normal)
        }
    }
    
    @IBAction func moreFiltersSegmentedControlAction(_ sender: Any) {
        if moreFiltersSegmentedControl.selectedSegmentIndex == 0 {
            firstSliderLabel.text = "Angle"
            firstSlider.minimumValue = -3.141592653589793
            firstSlider.maximumValue = 3.141592653589793
            firstSlider.value = 0
            secondSlider.isHidden = true
            secondSliderLabel.isHidden = true
        } else if moreFiltersSegmentedControl.selectedSegmentIndex == 1 {
            firstSliderLabel.text = "Levels"
            firstSlider.minimumValue = 2
            firstSlider.maximumValue = 30
            firstSlider.value = 6
            secondSlider.isHidden = true
            secondSliderLabel.isHidden = true
        } else if moreFiltersSegmentedControl.selectedSegmentIndex == 2 {
            firstSliderLabel.text = "Center"
            // [150 150]
            firstSlider.minimumValue = 0
            firstSlider.maximumValue = 300
            firstSlider.value = 150
            
            secondSliderLabel.isHidden = false
            secondSlider.isHidden = false
            secondSliderLabel.text = "Radius"
            secondSlider.minimumValue = 0
            secondSlider.maximumValue = 300
            secondSlider.value = 150
        }
    }
    
    @IBAction func firstSliderAction(_ sender: Any) {
        guard let image = imageView.image else { return }
        guard let cgImage = image.cgImage else { return }
        let ciImage = CIImage(cgImage: cgImage)
        
        if moreFiltersSegmentedControl.selectedSegmentIndex == 0 {
                self.hueFilter.setValue(ciImage, forKey: kCIInputImageKey)
                self.hueFilter.setValue(self.firstSlider.value, forKey: kCIInputAngleKey)
            DispatchQueue.global().async {
                guard let filteredCIImage = self.hueFilter.outputImage else { return }
                guard let filteredCGImage = self.context.createCGImage(filteredCIImage, from: filteredCIImage.extent) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(cgImage: filteredCGImage)
                }
            }
        } else if moreFiltersSegmentedControl.selectedSegmentIndex == 1 {
                self.posterizeFilter.setValue(ciImage, forKey: kCIInputImageKey)
                self.posterizeFilter.setValue(self.firstSlider.value, forKey: "inputLevels") // Couldn't find right key
            DispatchQueue.global().async {
                guard let filteredCIImage = self.posterizeFilter.outputImage else { return }
                guard let filteredCGImage = self.context.createCGImage(filteredCIImage, from: filteredCIImage.extent) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(cgImage: filteredCGImage)
                }
            }
        } else if moreFiltersSegmentedControl.selectedSegmentIndex == 2 {
                self.holeDistortionFilter.setValue(ciImage, forKey: kCIInputImageKey)
                self.holeDistortionFilter.setValue([self.firstSlider.value, self.firstSlider.value], forKey: "inputCenter") // Key Unclear
            DispatchQueue.global().async {
                guard let filteredCIImage = self.holeDistortionFilter.outputImage else { return }
                guard let filteredCGImage = self.context.createCGImage(filteredCIImage, from: filteredCIImage.extent) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(cgImage: filteredCGImage)
                }
            }
        }
    }
    
    
    @IBAction func secondSliderAction(_ sender: Any) {
        guard let image = imageView.image else { return }
        guard let cgImage = image.cgImage else { return }
        let ciImage = CIImage(cgImage: cgImage)
        
        if moreFiltersSegmentedControl.selectedSegmentIndex == 2 {
            
                self.holeDistortionFilter.setValue(ciImage, forKey: kCIInputImageKey)
                self.holeDistortionFilter.setValue(self.secondSlider.value, forKey: "inputRadius")
            DispatchQueue.global().async {
                guard let filteredCIImage = self.holeDistortionFilter.outputImage else { return }
                guard let filteredCGImage = self.context.createCGImage(filteredCIImage, from: filteredCIImage.extent) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(cgImage: filteredCGImage)
                }
            }
        }
    }
    
    
    // 4. Properties added
    private var originalImage: UIImage? {
        didSet{
            updateImage()
            showLabels()
        }
    }
    
    // 3. Filters and context added
    private let vintageFilter = CIFilter(name: "CIPhotoEffectChrome")!
    private let invertFilter = CIFilter(name: "CIColorInvert")!
    private let monoFilter = CIFilter(name: "CIPhotoEffectMono")!
    private let coolFilter = CIFilter(name: "CIPhotoEffectProcess")!
    private let warmFilter = CIFilter(name: "CIPhotoEffectTransfer")!
    private let colorControlsFilter = CIFilter(name: "CIColorControls")!
    private let hueFilter = CIFilter(name: "CIHueAdjust")!
    private let posterizeFilter = CIFilter(name: "CIColorPosterize")!
    private let holeDistortionFilter = CIFilter(name: "CIHoleDistortion")!
    
    private let context = CIContext(options: nil)
    
    // 2. Created image filter function
    private func apply(filter: CIFilter, for image: UIImage) -> UIImage {
        guard let cgImage = image.cgImage else { return image }
        let ciImage = CIImage(cgImage: cgImage)
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        guard let filteredCIImage = filter.outputImage else { return image }
        guard let filteredCGImage = context.createCGImage(filteredCIImage, from: filteredCIImage.extent) else { return image }
        
        return UIImage(cgImage: filteredCGImage)
    }
}

extension ImagePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        chooseImageButton.setTitle("", for: [])
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        originalImage = image // 6. Changed
        
        setImageViewHeight(with: image.ratio)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
