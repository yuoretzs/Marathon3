//
//  ViewController.swift
//  Marathon3.1
//
//  Created by юра on 7.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    let slider = UISlider()
    let squareView = UIView()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.5077049732, green: 0.7384749055, blue: 1, alpha: 1)
        slider.thumbTintColor = #colorLiteral(red: 0.9976127744, green: 0.1790564954, blue: 0.3298662007, alpha: 1)
        slider.tintColor = #colorLiteral(red: 0.9995493293, green: 0.4671113491, blue: 0.2142044306, alpha: 1)
        slider.maximumTrackTintColor = .white
        
        squareView.backgroundColor = .red
        let cornerRadius: CGFloat = 7
        squareView.layer.cornerRadius = cornerRadius
        squareView.layer.masksToBounds = true
        
        self.view.addSubview(squareView)
        view.addSubview(slider)
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        slider.addTarget(self, action: #selector(handleSliderTouchUp), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if count == 0 {
            slider.frame = CGRect(x: view.layoutMargins.left, y: view.layoutMargins.top + 170, width: view.bounds.width - (view.layoutMargins.left + view.layoutMargins.right), height: 20)
            squareView.frame = CGRect(x: view.layoutMargins.left, y: view.layoutMargins.top + 40, width: 80, height: 80)
     
            let gradient = CAGradientLayer()
            gradient.frame = squareView.bounds
            gradient.colors = [UIColor.systemPink.cgColor, UIColor.yellow.cgColor]
            gradient.locations = [0.2, 1.0]
            gradient.startPoint = CGPoint(x: 1, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
            squareView.layer.insertSublayer(gradient, at: 0)
            
            count += 1
        } else { return }
    }
    
    @objc func handleSliderChange(_ sender: UISlider) {
        let sliderValue = CGFloat(sender.value)
        let viewWidth = view.bounds.width - squareView.bounds.width - (view.layoutMargins.left + view.layoutMargins.right) - 20
        let finalX = view.layoutMargins.left + (viewWidth * sliderValue) + (squareView.bounds.width / 2)
        let scale = 1 + sliderValue / 2
        let angle = (sliderValue * .pi / 2)
        let rotationTransform = CGAffineTransform(rotationAngle: angle)
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        let transform = scaleTransform.concatenating(rotationTransform)
        self.squareView.transform = transform
        self.squareView.center.x = finalX
    }
    
    @objc func handleSliderTouchUp(_ sender: UISlider) {
        let finalX = view.bounds.width - slider.frame.origin.x - view.layoutMargins.left - 20 - view.layoutMargins.left
        let rotationTransform = CGAffineTransform(rotationAngle: (.pi / 2))
        let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        let transform = scaleTransform.concatenating(rotationTransform)
        UIView.animate(withDuration: 0.6, animations: {
            self.squareView.transform = transform
            self.squareView.center.x = finalX
        })
        sender.setValue(slider.maximumValue, animated: true)
    }
}

