

import UIKit
class GuideView: UIView {
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        self.layer.cornerRadius = 10
        self.addPikeOnView()
    
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Click on planet to see planet information"
    label.numberOfLines = 2
    label.textColor = .black
    label.textAlignment = .center
    self.addSubview(label)
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 10
    button.backgroundColor = .black
    button.setTitle("OK", for: .normal)
    button.addTarget(self, action: #selector(remove), for: .touchUpInside)
    self.addSubview(button)
    
    let constraints = [
        label.centerXAnchor.constraint(equalTo: centerXAnchor),
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        button.centerXAnchor.constraint(equalTo: centerXAnchor),
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
    ]
    NSLayoutConstraint.activate(constraints)
    
    
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func remove() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(translationX: -750, y: 0)
        }, completion: { _ in
            NotificationCenter.default.post(name: Notification.Name("setEnable"), object: nil)
            self.removeFromSuperview()
        })
    }
    
}


public extension UIView {

    func addPikeOnView(size: CGFloat = 10.0) {
        self.layoutIfNeeded()
        let peakLayer = CAShapeLayer()
        var path: CGPath?
        path = self.makePeakPathWithRect(rect: self.bounds, topSize: 0.0, rightSize: 0.0, bottomSize: size, leftSize: 0.0)
        peakLayer.path = path
        let color = (self.backgroundColor ?? .clear).cgColor
        peakLayer.fillColor = color
        peakLayer.strokeColor = color
        peakLayer.lineWidth = 1
        peakLayer.position = CGPoint.zero
        self.layer.insertSublayer(peakLayer, at: 0)
    }


    func makePeakPathWithRect(rect: CGRect, topSize ts: CGFloat, rightSize rs: CGFloat, bottomSize bs: CGFloat, leftSize ls: CGFloat) -> CGPath {

        let centerX = rect.width / 2
        let centerY = rect.height / 2
        var h: CGFloat = 0
        let path = CGMutablePath()
        var points: [CGPoint] = []
        points.append(CGPoint(x: rect.origin.x, y: rect.origin.y))
        if ts > 0 {
            h = ts * sqrt(3.0) / 2
            let x = rect.origin.x + centerX
            let y = rect.origin.y
            points.append(CGPoint(x: x - ts, y: y))
            points.append(CGPoint(x: x, y: y - h))
            points.append(CGPoint(x: x + ts, y: y))
        }
        points.append(CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y))
        if rs > 0 {
            h = rs * sqrt(3.0) / 2
            let x = rect.origin.x + rect.width
            let y = rect.origin.y + centerY
            points.append(CGPoint(x:x, y:y - rs))
            points.append(CGPoint(x:x + h,y: y))
            points.append(CGPoint(x:x, y:y + rs))
        }
        points.append(CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y + rect.height))
        if bs > 0 {
            h = bs * sqrt(3.0) / 2
            let x = rect.origin.x + centerX
            let y = rect.origin.y + rect.height
            points.append(CGPoint(x: x + bs, y: y))
            points.append(CGPoint(x: x, y: y + h))
            points.append(CGPoint(x: x - bs, y: y))
        }
        points.append(CGPoint(x: rect.origin.x, y: rect.origin.y + rect.height))
        if ls > 0 {
            h = ls * sqrt(3.0) / 2
            let x = rect.origin.x
            let y = rect.origin.y + centerY
            points.append(CGPoint(x: x, y: y + ls))
            points.append(CGPoint(x: x - h, y: y))
            points.append(CGPoint(x: x, y: y - ls))
        }

        let startPoint = points.removeFirst()
        self.startPath(path: path, onPoint: startPoint)
        for point in points {
            self.addPoint(point: point, toPath: path)
        }
        self.addPoint(point: startPoint, toPath: path)
        return path
    }

    private func startPath(path: CGMutablePath, onPoint point: CGPoint) {
        path.move(to: CGPoint(x: point.x, y: point.y))
    }

    private func addPoint(point: CGPoint, toPath path: CGMutablePath) {
        path.addLine(to:CGPoint(x: point.x, y: point.y))
    }

}
