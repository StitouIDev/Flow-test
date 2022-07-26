//
//  PopUp.swift
//  Flow test
//
//  Created by HAMZA on 26/7/2022.
//

import Foundation
import UIKit


class PopUp: UIView {
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    func xibSetup(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }
    
    
    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PopUp", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view!
    }
    
}
