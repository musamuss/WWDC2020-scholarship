
import UIKit
import PlaygroundSupport

public class CardView: UIView {
    public init(planet: Int) {
        super.init(frame: CGRect(x: 50, y: 50, width: 400, height: 400))
        self.layer.cornerRadius = 25
        self.backgroundColor = .white
        initButton()
        
        let namePlanet = UILabel()
        namePlanet.font = UIFont.boldSystemFont(ofSize: 32.0)
        self.addSubview(namePlanet)
        namePlanet.translatesAutoresizingMaskIntoConstraints = false
        
        let planetRadius = UILabel()
        self.addSubview(planetRadius)
        planetRadius.translatesAutoresizingMaskIntoConstraints = false
        planetRadius.font = UIFont.systemFont(ofSize: 21.0)
        
        let satellites = UILabel()
        satellites.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(satellites)
        satellites.font = UIFont.systemFont(ofSize: 21.0)
        
        let population = UILabel()
        population.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(population)
        population.font = UIFont.systemFont(ofSize: 21.0)
        
        let mass = UILabel()
        mass.translatesAutoresizingMaskIntoConstraints = false
        mass.font = UIFont.systemFont(ofSize: 21.0)
        self.addSubview(mass)
        
        let constraints = [
            namePlanet.centerXAnchor.constraint(equalTo: centerXAnchor),
            namePlanet.topAnchor.constraint(equalTo: self.topAnchor, constant: 64),
            planetRadius.centerXAnchor.constraint(equalTo: centerXAnchor),
            planetRadius.topAnchor.constraint(equalTo: namePlanet.bottomAnchor, constant: 32),
            satellites.centerXAnchor.constraint(equalTo: centerXAnchor),
            satellites.topAnchor.constraint(equalTo: planetRadius.bottomAnchor, constant: 16),
            population.centerXAnchor.constraint(equalTo: centerXAnchor),
            population.topAnchor.constraint(equalTo: satellites.bottomAnchor, constant: 16),
            mass.centerXAnchor.constraint(equalTo: centerXAnchor),
            mass.topAnchor.constraint(equalTo: population.bottomAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
        
        
        switch planet {
        case 0:
            namePlanet.text = "Mercury"
            planetRadius.text = "Radius: 2439,7 km"
            satellites.text = "Number of natural satellites: 0"
            population.text = "Population: 0"
            mass.text = "Mass of planet: 3,285E23 kg"
        case 1:
            namePlanet.text = "Mars"
            planetRadius.text = "Radius: 3389,5 km"
            satellites.text = "Number of natural satellites: 2"
            population.text = "Population: 0"
            mass.text = "Mass of planet: 6,39E23 kg"
        case 2:
            namePlanet.text = "Venus"
            planetRadius.text = "Radius: 6051,8 km"
            satellites.text = "Number of natural satellites: 0"
            population.text = "Population: 0"
            mass.text = "Mass of planet: 4,867E24 kg"
        case 3:
            namePlanet.text = "Earth"
            planetRadius.text = "Radius: 6371 km"
            satellites.text = "Number of natural satellites: 1"
            population.text = "Population: 7594 billion"
            mass.text = "Mass of planet: 5,972E24 kg"
        case 4:
            namePlanet.text = "Neptune"
            planetRadius.text = "Radius: 24622 km"
            satellites.text = "Number of natural satellites: 13"
            population.text = "Population: 0"
            mass.text = "Mass of planet: 1,024E26 kg"
        case 5:
            namePlanet.text = "Uranus"
            planetRadius.text = "Radius: 25362 km"
            satellites.text = "Number of natural satellites: 27"
            population.text = "Population: 0"
            mass.text = "Mass of planet: 8,681E25 kg"
        case 6:
            namePlanet.text = "Saturn"
            planetRadius.text = "Radius: 58232 km"
            satellites.text = "Number of natural satellites: 60"
            population.text = "Population: 0"
            mass.text = "Mass of planet: 5,683E26 kg"
        case 7:
            namePlanet.text = "Jupiter"
            planetRadius.text = "Radius: 58232 km"
            satellites.text = "Number of natural satellites: 63"
            population.text = "Population: 0"
            mass.text = "Mass of planet: 1,898E27 kg"
        default:
            break
        }
    }

    required init(coder aCoder: NSCoder) {
        super.init(coder: aCoder)!
        
    }
    func initButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size.height = 50.0
        button.layer.cornerRadius = 15
        button.backgroundColor = .black
        button.setTitle("   Close   ", for: .normal)
        self.addSubview(button)
        button.addTarget(self,action:#selector(closeCard),for:.touchUpInside)
        
        let constraints = [
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setX(items: [UILabel]) {
        for item in items {
            let xConstraint = NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
            item.addConstraint(xConstraint)
        }
    }
    
    @objc func closeCard() {
        self.removeFromSuperview()
        NotificationCenter.default.post(name: Notification.Name("setEnable"), object: nil)
    }

}

