//
//  Checkbox.swift
//  PartyWise
//
//  Created by Sprinthub on 25/03/2020.
//  Copyright © 2020 Sprinthub Mobile. All rights reserved.
//

import UIKit

/// Checkbox is a simple, animation free checkbox and UISwitch alternative designed
/// to be performant and easy to implement.
public class Checkbox: UIControl {

    
    

    /// Width of the borders stroke.
    ///
    /// **NOTE**
    ///
    /// Diagonal/rounded lines tend to appear thicker, so border styles
    /// that use these (.circle) have had their border widths halved to compensate
    /// in order appear similar next to other border styles.
    ///
    /// **Default:** `2`
    public var borderLineWidth: CGFloat = 2

    /// **Default:** The current tintColor.
    public var checkmarkColor: UIColor!

    public var uncheckedBorderColor: UIColor!
    /// Increases the controls touch area.
    ///
    /// Checkbox's tend to be smaller than regular UIButton elements
    /// and in some cases making them difficult to interact with.
    /// This property helps with that.
    ///
    /// **Default:** `5`
    public var increasedTouchRadius: CGFloat = 5

    /// A function can be passed in here and will be called
    /// when the `isChecked` value changes due to a tap gesture
    /// triggered by the user.
    ///
    /// An alternative to use the TargetAction method.
    public var valueChanged: ((_ isChecked: Bool) -> Void)?

    /// Indicates whether the checkbox is currently in a state of being
    /// checked or not.
    public var isChecked: Bool = false {
        didSet { setNeedsDisplay() }
    }

    /// Determines if tapping the checkbox generates haptic feedback to the user.
    ///
    /// **Default:** `true`
    public var useHapticFeedback: Bool = true

    private var feedbackGenerator: UIImpactFeedbackGenerator?

    // MARK: - Lifecycle
    lazy private var checkmarkIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "ic_checkmark")?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(UIEdgeInsets(top: -9, left: -9, bottom: -9, right: -9)))
//        icon.contentV
        icon.contentMode = .scaleAspectFit
        icon.willSetContraints()
        return icon
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
    }

    private func setupDefaults() {
        checkmarkIcon.layer.cornerRadius = self.layer.cornerRadius
        self.layer.borderWidth = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
        addGestureRecognizer(tapGesture)
        
        self.addSubview(self.checkmarkIcon)
        NSLayoutConstraint.activate([
            self.checkmarkIcon.topAnchor.constraint(equalTo: self.topAnchor),
            self.checkmarkIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.checkmarkIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.checkmarkIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])

        if useHapticFeedback {
            feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            feedbackGenerator?.prepare()
        }
    }

    override public func draw(_ rect: CGRect) {
        if isChecked {
            self.layer.borderColor = self.checkmarkColor.cgColor
            self.checkmarkIcon.tintColor = self.checkmarkColor
            self.checkmarkIcon.isHidden = false
        } else {
            self.checkmarkIcon.isHidden = true
            self.layer.borderColor = self.uncheckedBorderColor.cgColor
//            self.layer.borderWidth = 0
        }
    }
    
    // MARK: - Touch

    @objc private func handleTapGesture(recognizer: UITapGestureRecognizer) {
        isChecked = !isChecked
        valueChanged?(isChecked)
        sendActions(for: .valueChanged)

        if useHapticFeedback {
            // Trigger impact feedback.
            feedbackGenerator?.impactOccurred()

            // Keep the generator in a prepared state.
            feedbackGenerator?.prepare()
        }
    }
}
