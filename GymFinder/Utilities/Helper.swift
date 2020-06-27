//
//  Helper.swift
//  CampusCulture
//
//  Created by Azfal, Umar on 5/5/19.
//  Copyright © 2019 CodeXpirit. All rights reserved.
//

import UIKit

struct LoginNameRegularExtention {
    static let username = "^[a-zA-Z][a-zA-Z 0-9]{2,19}$"
    static let usernameChanged = "^[a-zA-Z]+([_ -]?[a-zA-Z 0-9]){2,19}$"
    static let login = "^[a-zA-Z][a-zA-Z0-9]{2,49}$"
    static let loginEmail = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,49}$"
    static let loginChanged = "^[a-zA-Z][a-zA-Z0-9]{2,49}$"
    static let loginEmailChanged = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,49}$"
}


class Helper: NSObject {
    
    class func nsStringIsValidPassword(_ checkString: String) -> Bool {
        if checkString.count < 6 {
            return false
        }
        if checkString.contains(" ") {
            return false
        }
        let stricterFilterString = "[A-Za-z\\d$`~!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?]+"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", stricterFilterString)
        let valid: Bool = passwordTest.evaluate(with: checkString)
        return valid
    }
    
    class func nsStringIsValidEmail(_ checkString: String) -> Bool {
        if (((checkString as NSString).range(of: " ")).location != NSNotFound) || (checkString == "") {
            return false
        }
        else {
            let numberOfOccurrences: Int = checkString.components(separatedBy: "@").count - 1
            if numberOfOccurrences > 1 {
                // because the regexp accepts multiple @'s
                return false
            }
            let stricterFilter = false
            let stricterFilterString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
            let laxString = ".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*"
            let emailRegex: String = stricterFilter ? stricterFilterString : laxString
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailTest.evaluate(with: checkString)
        }
    }
    
    class func getAllMajors () -> [String]
    {
        return ["Accounting",
        "Art & Art History",
        "Biology",
        "Bio-engineering",
        "Business Administration",
        "Chemistry & Biochemistry",
        "Civil Engineering",
        "Communication",
        "Computer Science and Engineering",
       "Criminology & Criminal Justice",
        "Curriculum and Instruction",
        "Earth and Environmental Science",
        "Economics",
        "Educational Leadership and Policy Studies",
        "Electrical Engineering",
        "English",
        "Finance and Real Estate",
        "Health Care Administration",
        "History",
        "Industrial and Manufacturing Systems Engineering",
        "Information Systems & Operation Management",
        "Kinesiology",
        "Linguistics",
        "Management",
        "Marketing",
        "Materials Science and Engineering",
        "Mathematics",
        "Mechanical and Aerospace Engineering",
        "Modern Languages",
        "Music",
        "Nursing",
        "Philosophy and Humanities",
        "Physics",
        "Political Science",
        "Psychology",
        "Sociology and Anthropology",
        "Social Work",
        "Theater Arts",
        "University Studies"]
    }
    
    class func getAllGenders() -> [String]
    {
        return ["Male","Female","Other"]
    }
    
    class func getAllRaces() -> [String]
    {
        return ["American Indian or Alaska Native","Asian","Black or African American","Native Hawaiian or Other Pacific Islander","White"]
    }
    
    class func getRelationshipStatuses() -> [String]
    {
        return["Not Saying","Single","Married","Divorced","Engaged","In Relationship","Complicated","Open relationship"]
    }
    
    class func getAllCountries() -> [String]
    {
        return ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France Metropolitan", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe"]
    }
    
    class func getAllClassLevel() -> [String]
    {
        return ["Freshman", "Sophomore", "Junior",
            "Senior", "Master", "Doctorate", "Postdoctorate", "Certificate","Alumni"]
    }

    
    class func getDeviceToken() -> String? {
        if (UserDefaults.standard.object(forKey: "deviceToken") != nil) {
            return UserDefaults.standard.object(forKey: "deviceToken") as? String
        } else {
            return nil
        }
    }
    
    class func saveUser(token:String,userID:String)
    {
        UserDefaults.standard.set(token, forKey: "userToken")
        
        if userID.count > 0
        {
            UserDefaults.standard.set(userID, forKey: "userID")
        }
        
        UserDefaults.standard.synchronize()
    }
    
    class func getUserID() -> String?
    {
        return UserDefaults.standard.object(forKey: "userID") as? String
    }
    
    class func deleteUserData()
    {
        UserDefaults.standard.removeObject(forKey: "userToken")
        UserDefaults.standard.removeObject(forKey: "deviceToken")
        UserDefaults.standard.removeObject(forKey: "userID")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userPassword")
        UserDefaults.standard.removeObject(forKey: "deviceTokenData")
        UserDefaults.standard.synchronize()
    }
}

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}

class ScaledHeightImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }
    
}

public class ScaleAspectFitImageView : UIImageView
{
    /// constraint to maintain same aspect ratio as the image
    private var aspectRatioConstraint:NSLayoutConstraint? = nil
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
        self.setup()
    }
    
    public override init(frame:CGRect)
    {
        super.init(frame:frame)
        self.setup()
    }
    
    public override init(image: UIImage!)
    {
        super.init(image:image)
        self.setup()
    }
    
    public override init(image: UIImage!, highlightedImage: UIImage?)
    {
        super.init(image:image,highlightedImage:highlightedImage)
        self.setup()
    }
    
    override public var image: UIImage? {
        didSet {
            self.updateAspectRatioConstraint()
        }
    }
    
    private func setup()
    {
        self.contentMode = .scaleAspectFit
        self.updateAspectRatioConstraint()
    }
    
    /// Removes any pre-existing aspect ratio constraint, and adds a new one based on the current image
    private func updateAspectRatioConstraint()
    {
        // remove any existing aspect ratio constraint
        if let c = self.aspectRatioConstraint {
            self.removeConstraint(c)
        }
        self.aspectRatioConstraint = nil
        
        if let imageSize = image?.size, imageSize.height != 0
        {
            let aspectRatio = imageSize.width / imageSize.height
            let c = NSLayoutConstraint(item: self, attribute: .width,
                                       relatedBy: .equal,
                                       toItem: self, attribute: .height,
                                       multiplier: aspectRatio, constant: 0)
            // a priority above fitting size level and below low
            c.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue((Double(UILayoutPriority.defaultLow.rawValue + UILayoutPriority.fittingSizeLevel.rawValue)) / 2.0))
            self.addConstraint(c)
            self.aspectRatioConstraint = c
        }
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UIImageView {
    
    func addAspectRatioConstraint(image: UIImage?) {
        
        if let image = image {
            removeAspectRatioConstraint()
            let aspectRatio = image.size.width / image.size.height
            let constraint = NSLayoutConstraint(item: self, attribute: .width,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .height,
                                                multiplier: aspectRatio, constant: 0.0)
            addConstraint(constraint)
        }
    }
    
    
    func removeAspectRatioConstraint() {
        for constraint in self.constraints {
            if (constraint.firstItem as? UIImageView) == self,
                (constraint.secondItem as? UIImageView) == self {
                removeConstraint(constraint)
            }
        }
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        var rect = bounds
        
        // Increase height (only useful for the iPhone X for now)
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                rect.size.height += window.safeAreaInsets.bottom
            }
        }
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 3.0
    @IBInspectable var bottomInset: CGFloat = 3.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}

extension UILabel {
    
    func textSize(font: UIFont, text: String) -> CGRect {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return labelSize
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        let label:UILabel = PaddingLabel()
        label.frame = CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}


extension Date {
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    
    func timeAgoSinceDate(numericDates:Bool) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        let now = Date()
        let earliest = self < now ? self : now
        let latest =  self > now ? self : now
        
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfMonth, .month, .year, .second]
        let components: DateComponents = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        
        if let year = components.year
        {
            if year >= 1
            {
                return "\(year)yr"
            }
            
        }
        
        if let month = components.month
        {
            if month >= 1
            {
                return "\(month)mo"
            }
            
        }
        
        if let weekOfYear = components.weekOfYear
        {
            if weekOfYear >= 1
            {
                return "\(weekOfYear)w"
            }
            
        }
        
        if let day = components.day
        {
            if day >= 1
            {
                return "\(day)d"
            }
            
        }
        
        if let hour = components.hour
        {
            if hour >= 1
            {
                return "\(hour)hr"
            }
            
        }
        
        if let minute = components.minute
        {
            if minute >= 1
            {
                return "\(minute)m"
            }
        }
        
        if let second = components.second
        {
            if second >= 1
            {
                return "\(second)s"
            }
            else
            {
                return "Just now"
            }
           
        }
        
        return "Just now"
    }
    
    private func stringToReturn(flag:Bool, strings: (String, String)) -> String {
        if (flag){
            return strings.0
        } else {
            return strings.1
        }
    }
}

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?
    
    override init()
    {
        super.init()
    }
    
    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback
        self.viewController = viewController
        
        let cameraAction = UIAlertAction(title: "Take photo", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Pick from Albums", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        if let popoverController = alert.popoverPresentationController
        {
          popoverController.sourceView = self.viewController!.view
            popoverController.sourceRect = CGRect(x: self.viewController!.view.bounds.midX, y: self.viewController!.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }
        
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            print("no camera")
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
      // For Swift 4.2
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          picker.dismiss(animated: true, completion: nil)
          guard let image = info[.originalImage] as? UIImage else {
              fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
          }
          pickImageCallback?(image)
      }
    
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }
    
}
