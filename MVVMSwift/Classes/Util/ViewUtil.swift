//
//  ViewUtil.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/19.
//

import UIKit

/**
 * 스크린 포지션 타입
 *
 * @returns Int
 */
enum ScreenPosition: Int {
    case center = 0
    case leftAbove = 1
    case leftBottom = 2
    case rightAbove = 3
    case rightBottom = 4
}

/**
 * ViewUtil.swift
 *
 * @description 뷰 유틸
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/19/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class ViewUtil {
    let TAG: String = "[ViewUtil]" // 디버그 태그
    
    static let sharedInstance = ViewUtil() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }
    
    /**
     * 스크린 포지션
     *
     * @param x X 좌표
     * @param y Y 좌표
     *
     * @returns ScreenPosition   스크린 포지션
     */
    func getScreenPosition(x: CGFloat,
                           y: CGFloat) -> ScreenPosition {
        let screenSize: CGRect = UIScreen.main.bounds
        let centerX: CGFloat = screenSize.width * 0.5
        let centerY: CGFloat = screenSize.height * 0.5
        var Right: Bool = false
        var Down: Bool = false
        if (x > centerX) { Right = true }
        if (y > centerY) { Down = true }
        
        if (!Right && !Down) {
            print("\(self.TAG) getScreenPosition() >> 왼쪽 위")
            return .leftAbove
        } else if (!Right && Down) {
            print("\(self.TAG) getScreenPosition() >> 왼쪽 아래")
            return .leftBottom
        } else if (Right && !Down) {
            print("\(self.TAG) getScreenPosition() >> 오른쪽 위")
            return .rightAbove
        } else if (Right && Down) {
            print("\(self.TAG) getScreenPosition() >> 오른쪽 아래")
            return .rightBottom
        } else {
            print("\(self.TAG) getScreenPosition() >> 정중앙")
            return .center
        }
    }
}

// MARK: - UIView

extension UIView {
    /**
     * 버튼 맨 위로 올리기
     *
     */
    func bringButtonsToFront() {
        for subView in self.subviews as [UIView] {
            if let button = subView as? UIButton {
                self.bringSubviewToFront(button)
            }
        }
    }
    
    /**
     * 컨텐트 위로 올리기
     *
     * @param tag 뷰 태그
     */
    func bringContentToFront(tag: Int) {
        if let content = self.viewWithTag(tag) {
            self.bringSubviewToFront(content)
        }
    }
    
    /**
     * UIImage로 변환
     *
     * @returns UIImage
     */
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    /**
     * 모든 뷰 삭제
     *
     */
    func removeAllSubviewsFromView() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    /**
     * 라운드
     *
     * @param 반지름
     */
    func addRound(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 0.1
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    /**
     * 라운드
     *
     * @param radius 반지름
     * @param color 반지름 색상
     */
    func addRound(_ radius: CGFloat, color: UIColor) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 0.1
        self.layer.borderColor = color.cgColor
    }
    
    /**
     * 라운드
     *
     * @param radius 반지름
     * @param color 반지름 색상
     * @param width 테두리두깨
     */
    func addRound(_ radius: CGFloat, color: UIColor, width: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    /**
     * 라운드
     *
     * @param radius 반지름
     * @param corners 코너 마스크
     */
    func addRoundCorners(_ radius: CGFloat,
                         corners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(arrayLiteral: corners)
    }
    
    /**
     * 원형
     *
     */
    func addCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
    }
}

// MARK: - UIImageView

extension UIImageView {
    /**
     * 이미지뷰 회전
     *
     * @returns time
     */
    func rotate(time: Double) {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.duration = time
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.repeatCount = .infinity
        animation.values = [0, Double.pi/2, Double.pi, Double.pi*3/2, Double.pi*2]
        animation.keyTimes = [NSNumber(value: 0.0), NSNumber(value: 0.1),
                              NSNumber(value: 0.3), NSNumber(value: 0.8), NSNumber(value: 1.0)]
        self.layer.add(animation, forKey: "rotate")
    }
}

// MARK: - UITableView

extension UITableView {
    /**
     * 테이블 뷰 갱신
     *
     * @return completion
     */
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
            { _ in completion() }
    }
}

// MARK: - UIScrollView

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
    
    func updateContentView(height: CGFloat) {
        contentSize.height = height
    }
    
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
    
    var currentPage: Int {
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
    
    /**
     * 모든 뷰 삭제
     *
     */
    func removeAllSubviewsFromScrollView() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}

// MARK: - UITextView

extension UITextView {
    
    func centerVertical() {
        let deadSpace
            = self.bounds.size.height - self.contentSize.height
        let inset = max(0, deadSpace/2.0)
        self.contentInset = UIEdgeInsets(top: inset,
                                         left: self.contentInset.left,
                                         bottom: inset,
                                         right: self.contentInset.right)
    }
}

// MARK: - UITextField

extension UITextField {
    func addLeftPadding(_ width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: width,
                                               height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

// MARK: - CALayer

extension CALayer {
    /**
     * 테두리 추가
     *
     * @param arrEdge 추가할 모서리
     * @param color 테두리 색상
     * @param width     테두리 두께
     */
    func addBorder(_ arrEdge: [UIRectEdge],
                   color: UIColor,
                   width: CGFloat) {
        for edge in arrEdge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}

