//
//  AccordionHeaderView.swift
//  PageControlEmbeddedScrollView
//
//  Created by Tolga Seremet on 29.01.2025.
//

import UIKit

/// A protocol defining the properties required for an accordion-style header in a view controller.
protocol AccordionHeaderView: UIViewController {

    /// The minimum allowable height for the accordion header.
    var accordionHeaderMinHeight: CGFloat { get }

    /// The maximum allowable height for the accordion header.
    var accordionHeaderMaxHeight: CGFloat { get }

    /// The current height of the accordion header, which adjusts dynamically based on user interaction.
    var accordionHeaderHeight: CGFloat { get set }

    /// A constraint reference used to programmatically adjust the header's height.
    ///
    /// This constraint is updated dynamically when the header expands or contracts.
    var accordionHeaderHeightHeightConstraint: NSLayoutConstraint! { get set }
}

protocol AccordionHeaderViewDelegate: AccordionHeaderView {

    /// Determines whether the accordion header view should scroll based on the given offset, scroll direction, and deceleration state.
    ///
    /// - Parameters:
    ///   - offsetY: The change in vertical content offset.
    ///   - scrollDirection: The direction in which the user is scrolling.
    ///   - isDecelerating: A Boolean indicating whether the scroll view is currently decelerating.
    ///   - targetOfsetYDelta: The predicted change in content offset after deceleration.
    /// - Returns: A Boolean value indicating whether scrolling should be allowed.
    func canIScroll(offsetY: CGFloat,
                    scrollDirection: UIAccessibilityScrollDirection,
                    isDecelerating: Bool,
                    targetOfsetYDelta: CGFloat) -> Bool
}

/// Extension for `AccordionHeaderViewDelegate` providing the scrolling behavior logic.
extension AccordionHeaderViewDelegate {

    /// Determines whether the accordion header view should scroll based on the given offset, scroll direction, and deceleration state.
    ///
    /// - Parameters:
    ///   - offsetY: The change in vertical content offset.
    ///   - scrollDirection: The direction in which the user is scrolling.
    ///   - isDecelerating: A Boolean indicating whether the scroll view is currently decelerating.
    ///   - targetOfsetYDelta: The predicted change in content offset after deceleration.
    /// - Returns: A Boolean value indicating whether scrolling should be allowed.
    func canIScroll(offsetY: CGFloat,
                    scrollDirection: UIAccessibilityScrollDirection,
                    isDecelerating: Bool,
                    targetOfsetYDelta: CGFloat) -> Bool {

        // Calculate the new potential height of the accordion header
        var accordionHeaderHeightToSet = accordionHeaderHeight - offsetY

        // Enforce minimum height restriction
        if accordionHeaderHeightToSet <= accordionHeaderMinHeight {
            accordionHeaderHeight = accordionHeaderMinHeight
            return true // Prevent further shrinking
        }

        // Enforce maximum height restriction
        else if accordionHeaderHeightToSet >= accordionHeaderMaxHeight {
            accordionHeaderHeight = accordionHeaderMaxHeight
            return true // Prevent further expansion
        }

        else {
            if !isDecelerating {
                // If scrolling is actively happening (not decelerating), adjust the header height dynamically
                accordionHeaderHeight = accordionHeaderHeightToSet
            }

            else if scrollDirection == .down {
                // When scrolling down, allow expansion with deceleration

                // Adjust the header height within bounds
                accordionHeaderHeightToSet = min(accordionHeaderHeight + targetOfsetYDelta, accordionHeaderMaxHeight)

                // If the predicted offset change is large (>2), force expand to max height
                if targetOfsetYDelta > 2 {
                    accordionHeaderHeightToSet = accordionHeaderMaxHeight
                }

                // Update the height constraint of the accordion header
                accordionHeaderHeightHeightConstraint.constant = accordionHeaderHeightToSet

                // Calculate animation duration based on the height change ratio
                let duration = 0.05 * (accordionHeaderHeightToSet - accordionHeaderHeight) / accordionHeaderHeight

                // Smoothly animate the height change
                UIView.animate(withDuration: duration) {
                    self.view.layoutIfNeeded()
                } completion: { finished in
                    // Once animation completes, finalize the new height
                    self.accordionHeaderHeight = accordionHeaderHeightToSet
                }
            }

            return false // Scrolling is not allowed in this case
        }
    }
}
