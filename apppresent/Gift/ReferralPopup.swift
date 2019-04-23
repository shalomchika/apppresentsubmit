//
//  ReferralPopup.swift
//  knPopup
//
//  Created by Ky Nguyen Coinhako on 10/9/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class ReferralPopup: knView {
    let blackView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return button
    }()
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.createRoundCorner(7)
        return v
    }()
    let okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor.color(r: 241, g: 66, b: 70)
        button.backgroundColor = color
        button.setTitle("COPY & CONTINUE", for: .normal)
        button.backgroundColor = UIColor.color(r: 71, g: 204, b: 54)
        button.height(54)
        button.createRoundCorner(27)
        return button
    }()
    
    func show(in view: UIView) {
        addSubviews(views: blackView, container)
        blackView.fill(toView: self)
        container.centerY(toView: self)
        container.horizontal(toView: self, space: 24)
        
        blackView.alpha = 0
        UIView.animate(withDuration: 0.1, animations:
            { [weak self] in self?.blackView.alpha = 1 })
        container.zoomIn(true)
        
        view.addSubviews(views: self)
        fill(toView: view)
    }
    
    @objc func dismiss() {
        let initialValue: CGFloat = 1
        let middleValue: CGFloat = 1.025
        let endValue: CGFloat = 0.001
        func fadeOutContainer() {
            UIView.animate(withDuration: 0.2, animations:
                { [weak self] in self?.container.alpha = 0 })
        }
        func zoomInContainer() {
            UIView.animate(withDuration: 0.05,
                           animations: { [weak self] in self?.container.scale(value: middleValue) })
        }
        func zoomOutContainer() {
            UIView.animate(withDuration: 0.3, delay: 0.05, options: .curveEaseIn,
                           animations:
                { [weak self] in
                    self?.container.scale(value: endValue)
                    self?.blackView.alpha = 0
                }, completion: { [weak self] _ in self?.removeFromSuperview() })
        }
        
        container.transform = container.transform.scaledBy(x: initialValue , y: initialValue)
        fadeOutContainer()
        zoomInContainer()
        zoomOutContainer()
    }
    
    override func setupView() {
        let color = UIColor.color(r: 241, g: 66, b: 70)
        
        let instruction = "GET YOUR FREE $10 CREDITS"
        let label = UIMaker.makeLabel(text: instruction,
                                      font: UIFont.boldSystemFont(ofSize: 15),
                                      color: .white,
                                      alignment: .center)
        
        let circle = UIMaker.makeView(background: color)
        let logo = UIMaker.makeImageView(image: UIImage(named: "swift"), contentMode: .scaleAspectFit)
        logo.backgroundColor = .white
        
        let codeTitle = UIMaker.makeLabel(text: "REFERRAL CODE",
                                          font: UIFont.boldSystemFont(ofSize: 12),
                                          color: UIColor.color(r: 155, g: 165, b: 172),
                                          alignment: .center)
        let codeLabel = UIMaker.makeLabel(text: "KYNGUYEN",
                                          font: UIFont.boldSystemFont(ofSize: 40),
                                          color: UIColor.color(r: 242, g: 64, b: 65),
                                          alignment: .center)
        
        
        container.addSubviews(views: circle, label, okButton, logo, codeTitle, codeLabel)
        
        // (1)
        label.top(toView: container, space: 24)
        label.horizontal(toView: container, space: 24)
        
        // (2)
        let edge: CGFloat = UIScreen.main.bounds.width * 2
        circle.square(edge: edge)
        circle.createRoundCorner(edge / 2)
        circle.centerX(toView: container)
        circle.bottom(toAnchor: logo.centerYAnchor)
        
        // (3)
        let logoEdge: CGFloat = 66
        logo.square(edge: logoEdge)
        logo.centerX(toView: circle)
        logo.verticalSpacing(toView: label, space: 40)
        logo.createRoundCorner(logoEdge / 2)
        logo.createBorder(1, color: color)
        
        // (4)
        codeTitle.centerX(toView: container)
        codeTitle.verticalSpacing(toView: logo, space: 24)
        
        // (5)
        codeLabel.centerX(toView: container)
        codeLabel.verticalSpacing(toView: codeTitle, space: 8)
        
        // (6)
        okButton.verticalSpacing(toView: codeLabel, space: 24)
        okButton.bottom(toView: container, space: -24)
        okButton.horizontal(toView: container, space: 36)
        okButton.createRoundCorner(28)
        
        okButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        blackView.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
}
