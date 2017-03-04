//
//  Translation.swift
//  ImmiGuide
//
//  Created by Cris on 2/19/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

enum TranslationLanguage: String {
    case spanish, english, chinese, appLanguage
}

class Translation {
    
    static let supportVC: [String: Any] = [
        TranslationLanguage.spanish.rawValue : [
            SupportProgramType.legalServices.rawValue : "Servicios Legales",
            SupportProgramType.domesticViolence.rawValue : "Abuso Domestico",
            SupportProgramType.immigrantFamilies.rawValue : "Familias Inmigrantes",
            SupportProgramType.legalAssistance.rawValue : "Servicios Legales",
            SupportProgramType.ndaImmigrants.rawValue : "Área de desarrollo de la vecindad (NDA)",
            SupportProgramType.youthServices.rawValue : "Servicios Para La Juventud",
            SupportProgramType.refugeeAssistance.rawValue : "Asistencia A Los Refugiados"
        ],
        TranslationLanguage.english.rawValue : [
            SupportProgramType.legalServices.rawValue : SupportProgramType.legalAssistance.rawValue,
            SupportProgramType.domesticViolence.rawValue : SupportProgramType.domesticViolence.rawValue,
            SupportProgramType.immigrantFamilies.rawValue : SupportProgramType.immigrantFamilies.rawValue,
            SupportProgramType.legalAssistance.rawValue : SupportProgramType.legalAssistance.rawValue,
            SupportProgramType.ndaImmigrants.rawValue : SupportProgramType.ndaImmigrants.rawValue,
            SupportProgramType.youthServices.rawValue : SupportProgramType.youthServices.rawValue,
            SupportProgramType.refugeeAssistance.rawValue : SupportProgramType.refugeeAssistance.rawValue
        ],
        TranslationLanguage.chinese.rawValue : [
            SupportProgramType.legalServices.rawValue : "法律服务",
            SupportProgramType.domesticViolence.rawValue : "家庭暴力",
            SupportProgramType.immigrantFamilies.rawValue : "移民家庭",
            SupportProgramType.legalAssistance.rawValue : "法律援助",
            SupportProgramType.ndaImmigrants.rawValue : "邻里开发区",
            SupportProgramType.youthServices.rawValue : "青年服务",
            SupportProgramType.refugeeAssistance.rawValue : "难民援助"
        ]
    ]
    
    static let programVC: [String : Any] = [
        TranslationLanguage.spanish.rawValue : [
            "GED" : "GED/ Preparación para la Universidad",
            "Adolescent Literacy" : "Literatura de Adolescentes",
            "grades 6 to 8" : "Los Grados 6 a 8",
            "Adult Literacy" : "Leer, Escribir y Hablar en Inglés",
            "At least 16 Years Old or Older" : "Al menos 16 años de edad o más",
            "ESOL" : "Inglés como Segundo Idioma",
            "ESOL/Civics" : "ESOL/ Civics",
            "Family Literacy" : "Leer, Escribir y Hablar en Inglés para Familias",
            "A parent 16 Years Old or Older " : "Un padre de familia de 16 años o más"
        ],
        TranslationLanguage.english.rawValue : [
            "GED" : "GED",
            "Adolescent Literacy" : "Adolescent Literacy",
            "grades 6 to 8" : "grades 6 to 8",
            "Adult Literacy" :  "Adult Literacy",
            "At least 16 Years Old or Older" : "At least 16 Years Old or Older",
            "ESOL" : "ESOL",
            "ESOL/Civics" : "ESOL/Civics",
            "Family Literacy" : "Family Literacy",
            "A parent 16 Years Old or Older " : "A parent 16 Years Old or Older"
        ],
        TranslationLanguage.chinese.rawValue : [
            "GED" : "GED/大学准备",
            "Adolescent Literacy" : "青少年文化",
            "grades 6 to 8" : "六至八年级",
            "Adult Literacy" :  "成人文化",
            "At least 16 Years Old or Older" : "至少16岁或以上",
            "ESOL" : "英语作为第二语言",
            "ESOL/Civics" : "公民",
            "Family Literacy" : "家庭文化",
            "A parent 16 Years Old or Older " : "16岁或以上的父母"
        ]
    ]

    static let tabBarTranslation = [
        TranslationLanguage.spanish.rawValue : [
            "Community" : "Comunidad",
            "Education" : "Educación",
            "Settings" : "Preferencias"
        ],
        TranslationLanguage.english.rawValue : [
            "Community" : "COMMUNITY",
            "Education" : "EDUCATION",
            "Settings" : "SETTINGS"
        ],
        TranslationLanguage.chinese.rawValue : [
            "Community" : "社区",
            "Education" : "教育",
            "Settings" : "设置"
        ]
    ]
    
    static let imageToLanguageDict = ["Spain" : TranslationLanguage.spanish.rawValue ,
                                    "china" : TranslationLanguage.chinese.rawValue,
                                    "united-states" : TranslationLanguage.english.rawValue]
    
    static func getLanguageFromDefauls() -> String {
        let userDefaults = UserDefaults.standard
        let language = userDefaults.object(forKey: TranslationLanguage.appLanguage.rawValue) as! String
        return language
    }
    
    static func languageFrom(imageName: String) -> String {
        let language =  imageToLanguageDict[imageName]
        return language!
    }
    
}
