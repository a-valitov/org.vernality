import CoreText

public class PCFontProvider: NSObject {
    public enum Style: CaseIterable {
        case montserratBold
        case montserratMedium
        case montserratRegular
        case montserratSemiBold
        case playfairDisplayBold
        case playfairDisplayVariableFontWeight
        case robotoMedium
        case robotoRegular
        public var value: String {
            switch self {
                case .montserratBold: return "Montserrat-Bold"
                case .montserratMedium: return "Montserrat-Medium"
                case .montserratRegular: return "Montserrat-Regular"
                case .montserratSemiBold: return "Montserrat-SemiBold"
                case .playfairDisplayBold: return "PlayfairDisplay-Bold"
                case .playfairDisplayVariableFontWeight: return "PlayfairDisplay-VariableFont_wght"
                case .robotoMedium: return "Roboto-Medium"
                case .robotoRegular: return "Roboto-Regular"
            }
        }
        public var font: UIFont {
            return UIFont(name: self.value, size: 14) ?? UIFont.init()
        }
    }

    public static var loadFonts: () -> Void = {
        let fontNames = Style.allCases.map { $0.value }
        for fontName in fontNames {
            loadFont(withName: fontName)
        }
        return {}
    }()

    private static func loadFont(withName fontName: String) {
        guard
            let bundleURL = Bundle(for: self).resourceURL?.appendingPathComponent("PCFontProvider.bundle"),
            let bundle = Bundle(url: bundleURL),
            let fontURL = bundle.url(forResource: fontName, withExtension: "ttf"),
            let fontData = try? Data(contentsOf: fontURL) as CFData,
            let provider = CGDataProvider(data: fontData),
            let font = CGFont(provider) else {
                return
            }
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
}
