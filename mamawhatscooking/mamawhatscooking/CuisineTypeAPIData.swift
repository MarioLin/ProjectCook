//
//  CuisineTypeAPIData
//  mamawhatscooking
//
//  Created by Mario Lin on 12/29/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

// the cuisine types that the api currently accepts
enum CuisineType: Int {
    case american = 1, italian, asian, mexican, southern, french, indian, chinese
    case cajun, mediterranean, english, spanish, thai, german, moroccan, irish
    case japanese, cuban, hawaiian, swedish, hungarian, portuguese
    
    // TODO(mario): find a better way to do this
    // HACK(mario): gross hack to iterate over all enum values, since there isn't a pretty way to do this atm
    // this array needs to be updated if we add anything to the enum list
    static let allValues: [CuisineType] = [.american, .italian, .asian, .mexican, .southern, .french, .indian, .chinese,
                                           .cajun, .mediterranean, .english, .spanish, .thai, .german, .moroccan, .irish,
                                           .japanese, .cuban, .hawaiian, .swedish, .hungarian, .portuguese]
    
    // outputs the yummly api supported string param for a CuisineType
    static func typeToDisplayParamString(_ type: CuisineType) -> (displayName: String, param: String) {
        switch type {
        case .american: return ("American", "american")
        case .italian: return ("Italian", "italian")
        case .asian: return ("Asian", "asian")
        case .mexican: return ("Mexican", "mexican")
        case .southern: return ("Southern & Soul", "southern")
        case .french: return ("French", "french")
        case .indian: return ("Indian", "indian")
        case .chinese: return ("Chinese", "chinese")
        case .cajun: return ("Cajun & Creole", "cajun")
        case .mediterranean: return ("Mediterranean", "mediterranean")
        case .english: return ("English", "english")
        case .spanish: return ("Spanish", "spanish")
        case .thai: return ("Thai", "thai")
        case .german: return ("German", "german")
        case .moroccan: return ("Moroccan", "moroccan")
        case .irish: return ("Irish", "irish")
        case .japanese: return ("Japanese", "japanese")
        case .cuban: return ("Cuban", "cuban")
        case .hawaiian: return ("Hawaiian", "hawaiian")
        case .swedish: return ("Swedish", "swedish")
        case .hungarian: return ("Hungarian", "hungarian")
        case .portuguese: return ("Portuguese", "portuguese")
        }
    }
}
