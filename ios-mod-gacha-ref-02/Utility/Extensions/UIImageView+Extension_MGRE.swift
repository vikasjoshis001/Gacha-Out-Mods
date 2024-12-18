//
//  UIImageView+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import CoreGraphics
import Kingfisher
import PDFKit
import UIKit

typealias UIImageView_MGRE = UIImageView
typealias UIImage_MGRE = UIImage

extension UIImageView_MGRE {
    /// Загружает и устанавливает изображение по заданному пути.
    ///
    /// - Parameter imgPath: Путь к изображению.
    
    private static var currentImagePathKey: UInt8 = 0
    private static var imageLoadTaskKey: UInt8 = 1
        
    private var currentImagePath: String? {
        get { return objc_getAssociatedObject(self, &UIImageView.currentImagePathKey) as? String }
        set { objc_setAssociatedObject(self, &UIImageView.currentImagePathKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
        
    private var imageLoadTask: DispatchWorkItem? {
        get { return objc_getAssociatedObject(self, &UIImageView.imageLoadTaskKey) as? DispatchWorkItem }
        set { objc_setAssociatedObject(self, &UIImageView.imageLoadTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
        
    func cancelCurrentImageLoad() {
        imageLoadTask?.cancel()
        imageLoadTask = nil
        currentImagePath = nil
    }
    
    class ImageCacheManager {
        static let shared = ImageCacheManager()
        private let cache = NSCache<NSString, UIImage>()
        
        func setImage(_ image: UIImage, forKey key: String) {
            cache.setObject(image, forKey: key as NSString)
        }
        
        func getImage(forKey key: String) -> UIImage? {
            return cache.object(forKey: key as NSString)
        }
        
        func removeImage(forKey key: String) {
            cache.removeObject(forKey: key as NSString)
        }
    }

    func add_MGRE(image imgPath: String, for contentType: ContentType_MGRE) {
        imageLoadTask?.cancel()
            
        if currentImagePath == imgPath {
            return
        }
            
        // Clear current image and update path
        image = nil
        currentImagePath = imgPath
            
        // Check cache first
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: imgPath) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self, self.currentImagePath == imgPath else { return }
                self.image = cachedImage
            }
            return
        }
            
        // Create new task for this request
        let task = DispatchWorkItem { [weak self] in
            DBManager_MGRE.shared.fetchImage_MGRE(for: contentType, imgPath: imgPath) { [weak self] data in
                guard let self = self,
                      self.currentImagePath == imgPath,
                      let data = data,
                      let image = UIImage(data: data)
                else {
                    return
                }
                    
                // Cache the image
                ImageCacheManager.shared.setImage(image, forKey: imgPath)
                DispatchQueue.main.async {
                    guard self.currentImagePath == imgPath else { return }
                    self.image = image
                }
            }
        }
        imageLoadTask = task
        DispatchQueue.global(qos: .userInitiated).async(execute: task)
    }

    func addPDF_MGRE(image imgPath: String) {
        tag = imgPath.hashValue
        UIImageView.retrieveImage_MGRE(forKey: imgPath) { [weak self] image in
            guard let self = self else { return }
            if let image = image {
                set_MGRE(image: image, tag: imgPath.hashValue)
            } else {
                DBManager_MGRE.shared.fetchPDFData_MGRE(with: imgPath) { [weak self] data in
                    guard let self = self, let data = data else { return }
                    UIImage.getImage_MGRE(withPDFData: data) { [weak self] image in
                        UIImageView.cacheImage_MGRE(with: imgPath, image: image)
                        self?.set_MGRE(image: image, tag: imgPath.hashValue)
                    }
                }
            }
        }
    }
    
    private func set_MGRE(image: UIImage?, tag: Int) {
        guard let image = image else { return }
        if self.tag == tag {
            self.image = image
        }
    }
    
    static func uploadPDF_MGRE(image imgPath: String) {
        retrieveImage_MGRE(forKey: imgPath) { image in
            if image == nil {
                DBManager_MGRE.shared.fetchPDFData_MGRE(with: imgPath) { data in
                    guard let data = data else { return }
                    UIImage.getImage_MGRE(withPDFData: data) { image in
                        UIImageView.cacheImage_MGRE(with: imgPath, image: image)
                    }
                }
            }
        }
    }
    
    private static func cacheImage_MGRE(with key: String, imageData: Data) {
        guard let image = UIImage(data: imageData) else {
            print("Error: Unable to create UIImage from data")
            return
        }
        let cache = ImageCache.default
        cache.store(image, forKey: key)
    }
    
    private static func cacheImage_MGRE(with key: String, image: UIImage?) {
        guard let image = image else { return }
        let cache = ImageCache.default
        cache.store(image, forKey: key)
    }
    
    private static func retrieveImage_MGRE(forKey key: String,
                                           completion: @escaping (UIImage?) -> Void)
    {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: key) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(let error):
                print("Block Error retrieving image from cache: \(error)")
                completion(nil)
            }
        }
    }
}

private extension UIImage_MGRE {
    static func getImage_MGRE(withPDFData data: Data, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            autoreleasepool {
                guard let provider = CGDataProvider(data: data as CFData),
                      let pdfDoc = CGPDFDocument(provider),
                      let pdfPage = pdfDoc.page(at: 1)
                else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                let dpi: CGFloat = 300.0
                let pageRect = pdfPage.getBoxRect(.mediaBox)
                let imageSize = CGSize(width: pageRect.size.width * dpi / 72.0,
                                       height: pageRect.size.height * dpi / 72.0)
                
                let deviceType = UIDevice.current.userInterfaceIdiom
                let scaleFactor: CGFloat
                if deviceType == .phone {
                    scaleFactor = 1.0 / 8.0
                } else {
                    scaleFactor = 1.0 / 5.0
                }
                let newSize = CGSize(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
                
                let renderer = UIGraphicsImageRenderer(size: newSize)
                
                let image = renderer.image { ctx in
                    UIColor.clear.set()
                    ctx.fill(CGRect(origin: .zero, size: newSize))
                    ctx.cgContext.translateBy(x: 0.0, y: newSize.height)
                    ctx.cgContext.scaleBy(x: newSize.width / pageRect.width,
                                          y: -newSize.height / pageRect.height)
                    ctx.cgContext.drawPDFPage(pdfPage)
                }
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}
