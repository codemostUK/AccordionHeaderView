//
//  AccordionHeaderViewClient.swift
//  PageControlEmbeddedScrollView
//
//  Created by Tolga Seremet on 29.01.2025.
//

import UIKit

/// A protocol defining the requirements for a scrollable client that interacts with an accordion-style header.
@MainActor
public protocol AccordionHeaderViewClient {

    /// Stores the previous vertical scroll position of the content.
    ///
    /// Used to determine the scroll direction and calculate the offset changes.
    var previousContentOffsetY: CGFloat { get set }

    /// A Boolean indicating whether the scroll view is currently decelerating.
    ///
    /// Helps manage the smooth expansion/contraction of the accordion header when scrolling slows down.
    var decelerationInProgress: Bool { get set }

    /// The target content offset after the scroll view stops scrolling.
    ///
    /// This value is used to predict where the scrolling will settle after the user lifts their finger.
    var targetContentOffset: CGPoint { get set }

    /// A reference to the delegate responsible for handling the accordion header's scroll behavior.
    ///
    /// The delegate conforms to `AccordionHeaderViewDelegate`, allowing dynamic header resizing.
    var delegate: NSObjectProtocol? { get set }
}
