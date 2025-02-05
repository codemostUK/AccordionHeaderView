//
//  AccordionHeaderView.swift
//  PageControlEmbeddedScrollView
//
//  Created by Tolga Seremet on 29.01.2025.
//

import UIKit

/// A protocol defining the properties required for an accordion-style header in a view controller.
public protocol AccordionHeaderView: UIViewController {

    /// The minimum allowable height for the accordion header.
    var accordionHeaderMinHeight: CGFloat { get }

    /// The maximum allowable height for the accordion header.
    var accordionHeaderMaxHeight: CGFloat { get }
}

public protocol AccordionHeaderViewDelegate: AccordionHeaderView {

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

    /// Notifies the delegate that the accordion header view's height is about to change.
    ///
    /// - Parameters:
    ///   - accordionHeaderView: The accordion header view that is changing height.
    ///   - height: The new height the header view will transition to.
    ///   - withDuration: The duration of the height change animation.
    func accordionHeaderView(_ accordionHeaderView: AccordionHeaderView,
                             willChange height: CGFloat,
                             withDuration: TimeInterval)

    /// Notifies the delegate that the accordion header view's height has changed.
    ///
    /// - Parameters:
    ///   - accordionHeaderView: The accordion header view whose height has changed.
    ///   - height: The updated height of the header view.
    func accordionHeaderView(_ accordionHeaderView: AccordionHeaderView,
                             didChange height: CGFloat)

    /// Retrieves the current height of the accordion header view.
    ///
    /// - Returns: The current height of the accordion header view.
    func currentAccordionHeaderHeight() -> CGFloat
}

/// Extension for `AccordionHeaderViewDelegate` providing the scrolling behavior logic.
public extension AccordionHeaderViewDelegate {

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
        var accordionHeaderHeightToSet = currentAccordionHeaderHeight() - offsetY

        // Enforce minimum height restriction
        if accordionHeaderHeightToSet <= accordionHeaderMinHeight {
            // Notify that the header has reached its minimum height
            accordionHeaderView(self, didChange: accordionHeaderMinHeight)
            return true // Prevent further shrinking
        }

        // Enforce maximum height restriction
        else if accordionHeaderHeightToSet >= accordionHeaderMaxHeight {
            // Notify that the header has reached its maximum height
            accordionHeaderView(self, didChange: accordionHeaderMaxHeight)
            return true // Prevent further expansion
        }

        else {
            if !isDecelerating {
                // If actively scrolling (not decelerating), update the header height dynamically
                accordionHeaderView(self, didChange: accordionHeaderHeightToSet)
            }

            else if scrollDirection == .down {
                // When scrolling down, allow header expansion with deceleration

                // Adjust the header height while ensuring it remains within the allowed range
                accordionHeaderHeightToSet = min(currentAccordionHeaderHeight() + targetOfsetYDelta, accordionHeaderMaxHeight)

                // If the predicted offset change is large (>2), expand the header fully
                if targetOfsetYDelta > 2 {
                    accordionHeaderHeightToSet = accordionHeaderMaxHeight
                }

                // Calculate animation duration proportional to the height change ratio
                let duration = 0.05 * (accordionHeaderHeightToSet - currentAccordionHeaderHeight()) / currentAccordionHeaderHeight()

                // Notify that the height change is about to occur
                self.accordionHeaderView(self, willChange: accordionHeaderHeightToSet, withDuration: duration)

                // Schedule the final height update after the animation duration
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.accordionHeaderView(self, didChange: accordionHeaderHeightToSet)
                }
            }
            return false // Scrolling is not allowed in this case
        }
    }
}
