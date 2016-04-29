//
//  ConditionsView.swift
//  WeatherView
//
//  Created by Raul Riera on 28/07/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

class ConditionsView: UIView {
    
    private var conditionsLabel: UILabel?
    private var conditionsImageView: UIImageView?
    
    var forecast: Forecast? {
        didSet {
            didUpdateForecast()
        }
    }
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView(font: .systemFontOfSize(UIFont.systemFontSize()))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView(font: .systemFontOfSize(UIFont.systemFontSize()))
    }
    
    convenience init(frame: CGRect, font: UIFont) {
        self.init(frame: frame)
        configureView(font: font)
    }
    
    // MARK: Private
    
    private func configureView(font font: UIFont) {
        
        conditionsLabel = UILabel(frame: frame)
        conditionsImageView = UIImageView(frame: frame)
        
        if let conditionsLabel = conditionsLabel, let conditionsImageView = conditionsImageView {
            backgroundColor = .clearColor()
            
            conditionsLabel.font = font
            conditionsLabel.textColor = .whiteColor()
            conditionsLabel.lineBreakMode = .ByClipping
            conditionsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            conditionsImageView.translatesAutoresizingMaskIntoConstraints = false
            conditionsImageView.contentMode = .ScaleAspectFit
            
            addSubview(conditionsImageView)
            addSubview(conditionsLabel)
            
            let views = ["label": conditionsLabel, "image": conditionsImageView]
            
            let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[image]-4-[label]-|", options: [], metrics: nil, views: views)
            let verticalConstraintsImage = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[image]-0-|", options: [], metrics: nil, views: views)
            let verticalConstraintsLabel = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: [], metrics: nil, views: views)
            
            NSLayoutConstraint.activateConstraints(horizontalConstraints + verticalConstraintsImage + verticalConstraintsLabel)
            
        }
    }
    
    private func didUpdateForecast() {
        if let forecast = forecast, let conditionsLabel = conditionsLabel, let conditionsImageView = conditionsImageView {
            conditionsLabel.text = "\(forecast.high.value)˚"
            conditionsImageView.image = UIImage(named: forecast.conditions.icon, inBundle: NSBundle(forClass: ConditionsView.self), compatibleWithTraitCollection: nil)
        }
    }
    
}