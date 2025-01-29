//
//  ViewController.swift
//  AccordionHeaderViewExample
//
//  Created by Tolga Seremet on 27.01.2025.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController, AccordionHeaderViewDelegate {

    // MARK: - IBOutlets

    @IBOutlet var containerView: UIView!
    @IBOutlet var accordionHeaderHeightHeightConstraint: NSLayoutConstraint!

    // MARK: - Properties

    var pageViewController: PageViewController?

    var accordionHeaderMinHeight: CGFloat = 40.0
    var accordionHeaderMaxHeight: CGFloat = 150.0
    var accordionHeaderHeight: CGFloat = 150.0 {
        didSet {
            accordionHeaderHeightHeightConstraint.constant = accordionHeaderHeight
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: - Navigation

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedPageViewController"  {
            if let pageViewController = segue.destination as? PageViewController {
                pageViewController.accordionHeaderViewDelegate = self
            }
        }
        segue.destination.hidesBottomBarWhenPushed = true
    }
}
