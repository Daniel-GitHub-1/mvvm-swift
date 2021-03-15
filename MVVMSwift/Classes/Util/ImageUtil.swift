//
//  ImageUtil.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/19.
//

import UIKit
import Photos

/**
 * ImageUtil.swift
 *
 * @description 이미지 유틸
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/19/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class ImageUtil {
    let TAG: String = "[ImageUtil]" // 디버그 태그
    
    static let sharedInstance = ImageUtil() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }
    
    /**
     * 이미지 크롭 (Center)
     *
     * @param image         이미지
     * @param width         이미지 넓이
     * @param height        이미지 높이
     * @returns croppedImage 크롭된 이미지
     */
    func cropImage(image: UIImage,
                   width: CGFloat,
                   height: CGFloat) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = width
        var cgheight: CGFloat = height
        
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        let croppedImage: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return croppedImage
    }
    
    /**
     * 이미지 크롭
     *
     * @param image         이미지
     * @param x             이미지 X 좌표
     * @param y             이미지 Y 좌표
     * @param width         이미지 넓이
     * @param height        이미지 높이
     * @returns croppedImage 크롭된 이미지
     */
    func cropImage(image: UIImage,
                   x: CGFloat,
                   y: CGFloat,
                   width: CGFloat,
                   height: CGFloat) -> UIImage {
        
        let fullSizeImage = resizeFullImage(image: image)
        
        let rect: CGRect = CGRect(x: x,
                                  y: y,
                                  width: width,
                                  height: height)
        let imageRef: CGImage = fullSizeImage.cgImage!.cropping(to: rect)!
        
        let croppedImage: UIImage = UIImage(cgImage: imageRef,
                                            scale: fullSizeImage.scale,
                                            orientation: fullSizeImage.imageOrientation)
        return croppedImage
    }
    
    /**
     * 이미지 크롭
     *
     * @param image             이미지
     * @returnss croppedImage    크롭된 이미지
     */
    func cropToBounds(image: UIImage) -> UIImage {
        
        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = 0.0
        var cgheight: CGFloat = 0.0
        
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height)/2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width)/2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        let croppedImage: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        return croppedImage
    }
    
    /**
     * description
     *
     * @param image             이미지
     * @param rect              이미지 사이즈
     * @returnss croppedImage    크롭된 이미지
     */
    func cropImage(image: UIImage,
                   rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x = image.scale
        rect.origin.y = image.scale
        rect.size.width = image.scale
        rect.size.height = image.scale
        
        let imageRef = image.cgImage!.cropping(to: rect)
        let croppedImage = UIImage(cgImage: imageRef!, scale: image.scale, orientation: image.imageOrientation)
        return croppedImage
    }
    
    /**
     * 이미지 뷰 내용에 맞춤
     *
     * @param image         이미지
     * @param containerView 내용 뷰
     */
    func aspectFitImageView(image: UIImage,
                            containerView: UIView) -> CGSize {
        let ratio = image.size.width / image.size.height
        var fitSize: CGSize
        if containerView.frame.width > containerView.frame.height {
            let newHeight = containerView.frame.width / ratio
            fitSize = CGSize(width: containerView.frame.width, height: newHeight)
        } else {
            let newWidth = containerView.frame.height * ratio
            fitSize = CGSize(width: newWidth, height: containerView.frame.height)
        }
        return fitSize
    }
    
    /**
     * 이미지 뷰 풀스크린 내용에 맞춤
     *
     * @param image         이미지
     * @param containerView 내용 뷰
     */
    func aspectFitImageViewAtFullScreen(image: UIImage,
                                        containerView: UIView) -> CGSize {
        let ratio = image.size.width / image.size.height
        var fitSize: CGSize
        let newWidth = containerView.frame.height * ratio
        fitSize = CGSize(width: newWidth, height: containerView.frame.height)
        return fitSize
    }
    
    /**
     * 서클 이미지 뷰
     *
     * @param imageView 이미지 뷰
     */
    func circle(imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
    }
    
    /**
     * 반전 타입
     *
     * @returns
     */
    enum ReverseType: Int {
        case rightNleft = 0
        case upperNlower = 1
    }
    
    /**
     * 좌우 반전 이미지 뷰
     *
     * @param imageView     이미지 뷰
     * @param reverseType   반전 타입
     * @param reverse       반전 여부
     */
    func reverseImageView(imageView: UIImageView,
                          reverseType: ReverseType,
                          reverse: Bool) {
        switch(reverseType) {
        case .rightNleft:   // 좌우 반전
            if (reverse) {
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            } else {
                imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            break
        case .upperNlower:  // 상하반전
            if (reverse) {
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            } else {
                imageView.transform = CGAffineTransform(scaleX: 1, y: -1)
            }
            break
        }
    }
    
    /**
     * 이미지 리사이즈
     *
     * @param image         이미지
     * @param width         이미지 넓이
     * @returns resizedImage 사이즈 조정된 이미지
     */
    func resizeImage(image: UIImage,
                     width: CGFloat) -> UIImage {
        let scale = width / image.size.width
        let height = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
    /**
     * 풀스크린 이미지 리사이즈
     *
     * @param image          이미지
     * @returns resizedImage 사이즈 조정된 이미지
     */
    func resizeFullImage(image: UIImage) -> UIImage {
        let screenSize: CGRect = UIScreen.main.bounds
        UIGraphicsBeginImageContext(CGSize(width: screenSize.width, height: screenSize.height))
        image.draw(in: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
    
    /**
     * 스크린 사이즈
     *
     * @param rootView      메인 뷰
     * @param image         이미지
     * @returns resizeImage  사이즈 조정된 이미지
     */
    func resizeToScreenSize(rootView: UIView,
                            image: UIImage) -> UIImage {
        let screenSize = rootView.bounds.size
        return resizeImage(image: image, width: screenSize.width)
    }
    
    /**
     * 뷰안의 이미지 뷰 이미지 리사이즈
     *
     * @param rootView  메인 뷰
     * @param width     이미지 넓이
     * @param height    이미지 높이
     */
    func resizeImageViewContentImage(rootView: UIView,
                                     width: CGFloat,
                                     height: CGFloat) {
        for subView in rootView.subviews as [UIView] {
            if let imageView = subView as? UIImageView {
                imageView.frame = CGRect(x: 0,
                                         y: 0,
                                         width: width,
                                         height: height)
            }
        }
    }
    
    /**
     * GIF 애니메이션 시작
     *
     * @param rootView  메인 뷰
     * @param imageName 이미지
     * @param x         이미지
     * @param y         이미지
     * @returns
     */
    func startGIFAnimation(rootView: UIView,
                           imageName: String,
                           x: CGFloat,
                           y: CGFloat,
                           completion: @escaping (UIView) -> Void) {
        let screenSize: CGRect = UIScreen.main.bounds
        let view = UIView(frame: CGRect(x: screenSize.origin.x,
                                        y: screenSize.origin.y,
                                        width: screenSize.width,
                                        height: screenSize.height))
        
        let gif = UIImage.gifImageWithName(imageName)
        let imageView = UIImageView(image: gif)
        imageView.frame = CGRect(x: x,
                                 y: y,
                                 width: view.frame.width,
                                 height: view.frame.height)
        
        view.addSubview(imageView)
        rootView.addSubview(view)
        completion(view)
    }
    
    /**
     * GIF 애니메이션 종료
     *
     * @param rootView 메인 뷰
     * @returns
     */
    func stopGIFAnimation(rootView: UIView,
                          completion: @escaping (Bool) -> Void) {
        rootView.removeFromSuperview()
        completion(true)
    }
    
    /**
     * 로딩 애니메이션 시작
     *
     * @param rootView 메인 뷰
     * @param imageName 이미지명
     * @returns
     */
    func startLoadingAnimation(rootView: UIView,
                               imageName: String,
                               completion: @escaping (UIView) -> Void) {
        let view = UIView(frame: CGRect(x: rootView.frame.size.width * 0.5,
                                        y: rootView.frame.size.height * 0.5,
                                        width: 120.0,
                                        height: 120.0))
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        
        view.center = rootView.center
        view.backgroundColor = UIColor.white
        
        let gif = UIImage.gifImageWithName(imageName)
        let imageView = UIImageView(image: gif)
        
        imageView.frame = CGRect(x: 0.0,
                                 y: 0.0,
                                 width: view.frame.width-5,
                                 height: view.frame.height-5)
        
        imageView.contentMode = .scaleAspectFit
        rootView.addSubview(imageView)
        
        rootView.addSubview(view)
        completion(view)
    }
    
    /**
     * 로딩 애니메이션 종료
     *
     * @param rootView 메인 뷰
     * @returns
     */
    func stopLoadingAnimation(rootView: UIView,
                              completion: @escaping (Bool) -> Void) {
        rootView.removeFromSuperview()
        completion(true)
    }
    
    /**
     * 이미지 컬러 변경
     *
     * @param rootView      메인 뷰
     * @param hexString     컬러값 (HEX)
     * @returns resultImage UIImage
     */
    func changeImageColor(image: UIImage,
                          hexString: String) -> UIImage {
        let rect =  CGRect.init(x: 0,
                                y: 0 ,
                                width: image.size.width,
                                height: image.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, image.scale)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        image.draw(in: rect)
        
        let color = hexString.hexString2UIColor()
        
        context.setFillColor((color?.cgColor)!)
        context.setBlendMode(CGBlendMode.sourceAtop)
        context.fill(rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    /**
     * 이미지 리스트
     *
     * @param imageName     이미지명
     * @returns iconArray   이미지 배열
     */
    func getImageList(imageName: String) -> [UIImage] {
        let iconArray = [Int](1...100).compactMap {
            UIImage(named: "\(imageName)\($0)")
        }
        return iconArray
    }
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }

    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

    func resizeImage(size: CGSize)-> UIImage {
        
        let hasAlpha = true
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
}

