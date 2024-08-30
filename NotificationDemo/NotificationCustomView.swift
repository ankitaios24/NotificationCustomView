
import UIKit

class NotificationCustomView: UIView {
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    private var dismissTimer: Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6

        // Add a long press gesture recognizer to handle touch events
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(longPressGesture)

        // Add a swipe gesture recognizer to handle swipe up events
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .up
        self.addGestureRecognizer(swipeGesture)
    }

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            dismissTimer?.invalidate()
            dismissTimer = nil
        case .ended, .cancelled:
            startDismissalTimer()
        default:
            break
        }
    }

    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            dismissView()
        }
    }

     func startDismissalTimer() {
        dismissTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissView), userInfo: nil, repeats: false)
    }

    @objc private func dismissView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.origin.y = -self.frame.height
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
