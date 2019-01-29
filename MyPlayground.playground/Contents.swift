import UIKit


enum Ones: Int {
    case one = 100
    case two = 200
    case three = 300
    case four = 400
    case five = 500
    case six = 600
}

enum Twos: Int {
    case zero = 1
    case five = 2
    case ten = 3
    case fifteen = 4
    case twenty = 5
    case twentyfive = 6
}


var str = Ones.one.rawValue

var ing = Twos.fifteen.rawValue

var numString = str + ing


