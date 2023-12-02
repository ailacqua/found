//
//  Location.swift
//  FoundIt
//
//  Created by Rohan Sedhain on 12/1/23.
//

import Foundation

class Location {
    static let locations = [
        "Alice Cook House":"ACH",
        "AD White House": "ADW",
        "Africana Center": "AFC",
        "AG Quad": "AGQ",
        "Akwe:Kon": "AKW",
        "Appel Commons": "APP",
        "Academic Surge A": "ASA",
        "Academic Surge B": "ASB",
        "Arts Quad": "ASQ",
        "Anabel Taylor Hall": "ATH",
        "Balch Hall": "BAL",
        "Bauer Hall": "BAU",
        "Beebe Beach": "BBE",
        "Beebe Hall": "BBH",
        "Bradfield Hall": "BDF",
        "Bethe House": "BET",
        "Botanic Gardens Arboretum": "BGC",
        "Baker Laboratory": "BKL",
        "Becker House": "BKR",
        "Bloomberg Center": "BLM",
        "Bailey Hall": "BLY",
        "Bondareff Raptor Facility": "BND",
        "Boldt Hall": "BOL",
        "Big Red Barn": "BRB",
        "Bard Hall": "BRD",
        "Barnes Hall": "BRN",
        "Breazzano Family Ctr for BusEd": "BRZ",
        "Basic Science Building": "BSC",
        "Baker Institute": "BTA",
        "Biotechnology Building": "BTB",
        "Boyce Thompson Institute": "BTI",
        "Bartels Hall": "BTL",
        "Barton Hall": "BTN",
        "Cascadilla Hall": "CAS",
        "College Ave, 301": "CAV",
        "Computing & Communications Ctr": "CCC",
        "Cornell Golf Center": "CGC",
        "Court Kay Bauer Lawn": "CKB",
        "Clinical Programs - Ambulatory": "CLA",
        "Clinical Programs - Breezeway": "CLB",
        "Caldwell Hall": "CLD",
        "Clark Hall": "CLK",
        "Clinical Programs M Barn": "CLM",
        "Clinical Programs - Surgery": "CLS",
        "Clinical Programs - Multipurpose": "CLU",
        "Corson & Mudd Halls": "CMH",
        "Comstock Hall": "CMS",
        "Cornell Health": "CNH",
        "Anna Comstock House": "COM",
        "Clinical Programs K Barn": "CPK",
        "Carpenter Hall": "CRP",
        "Court Residence Hall": "CRT",
        "CVM Center": "CVM",
        "Day Hall": "DAY",
        "Clara Dickson Hall": "DCK",
        "Mary Donlon Hall": "DON",
        "Duffield Hall": "DUF",
        "Hurlburt House": "ECO",
        "Emerson Hall": "EMR",
        "Engineering Quad": "ENQ",
        "Judith Eisner Pavilion": "ESN",
        "Fischell Band Center": "FBC",
        "Foundry": "FND",
        "Newman Laboratory": "FNL",
        "Flora Rose House": "FRH",
        "Fernow Hall": "FRN",
        "Fuertes Observatory": "FUE",
        "Friedman Wrestling Center": "FWC",
        "Gnva Barton Laboratory": "GBL",
        "Green Greenhouse Bldg G": "GGG",
        "Green Greenhouse Bldg M": "GGM",
        "Grumman Squash Courts": "GRS",
        "Goldwin Smith Hall": "GSH",
        "Guterman Bioclimatic Lab": "GTR",
        "Bill and Melinda Gates Hall": "GTS",
        "Hasbrouck Community Center": "HCC",
        "Human Ecology Building": "HEB",
        "Hughes Hall": "HGH",
        "Hollister Hall": "HLS",
        "Helen Newman Hall": "HNH",
        "Ho Plaza": "HOP",
        "High Rise #5": "HR5",
        "High Voltage Laboratory": "HVL",
        "ILR Conference Center": "ICC",
        "ILR Research Building": "IRB",
        "Ives Hall Faculty Wing": "IVF",
        "Ives Hall": "IVS",
        "Ornithology, Cornell Lab of": "JLO",
        "Johnson Museum Of Art": "JMA",
        "George Jameson Hall": "JMS",
        "Jessup Field": "JSS",
        "Kay Hall": "KAY",
        "Stewart Ave 640, Kahin Center": "KHN",
        "Klarman Hall": "KLR",
        "Kimball Hall": "KMB",
        "Kennedy Hall": "KND",
        "Kroch, Carl A Library": "KRC",
        "West Ave 104": "KSH",
        "William T. Keeton House": "KTN",
        "Library Slope": "LBS",
        "Liddell Laboratory": "LDL",
        "Plant Breeding Love Laboratory": "LLB",
        "Lincoln Hall": "LNC",
        "Lynah Rink": "LNH",
        "Low Rise #6": "LR6",
        "Low Rise #7": "LR7",
        "Low Rise #8": "LR8",
        "Low Rise #9": "LR9",
        "Livestock Pavilion": "LSP",
        "Botanic Gardens RM Lewis Educ Center": "LWS",
        "Lexington Ave 570": "LXT",
        "McConville Barn": "MCC",
        "Mcfaddin Hall": "MCF",
        "McGraw Hall": "MCG",
        "McClintock": "MCL",
        "Mews Residence Hall": "MEW",
        "Moakley House - Golf Course": "MKL",
        "Milstein Hall": "MLS",
        "Malott Hall": "MLT",
        "Mann Library": "MNL",
        "Muenscher Laboratory": "MNS",
        "Moore Laboratory": "MRB",
        "Morrill Hall": "MRL",
        "Morrison Hall": "MRS",
        "Merrill Family Sailing Center": "MSC",
        "Myron Taylor Hall": "MTH",
        "M Van Rensselaer Hall": "MVR",
        "Mews Hall Courtyard": "MWS",
        "Noyes Lodge": "NLG",
        "North Campus Turf Field": "NCT",
        "Noyes Community and Rec Center": "NRC",
        "Nevin Welcome Center": "NVN",
        "Olin Chemistry Research Wing": "OLC",
        "Olin Hall": "OLH",
        "Olin Library": "OLL",
        "John T Oxley Equestrian Center": "OXL",
        "Pomology Cold Storage Sales": "PCS",
        "Phillips Hall": "PHL",
        "Physical Sciences Building": "PHS",
        "Plant Science Building": "PLS",
        "Poisonous Plant Garden": "PPG",
        "Roberts Hall": "RBT",
        "Rice Hall": "RCE",
        "Rockefeller Hall": "RCK",
        "Recreation Club Pavilion": "RCP",
        "Frank H T Rhodes Hall": "RHD",
        "Risley Lawn": "RIS",
        "Rand Hall": "RND",
        "Robert Purcell Community Center": "RPC",
        "Riley-Robb Hall": "RRB",
        "Risley, Prudence Resd. College": "RSL",
        "Risley Tennis Court": "RST",
        "Reis Tennis Center": "RTC",
        "Rawlings Green": "RWL",
        "Sibley Hall": "SBL",
        "Sheldon Court": "SCT",
        "Sage Chapel": "SGC",
        "Sage Hall": "SGH",
        "Schoellkopf Memorial Hall": "SHK",
        "Schoellkopf Field": "SKF",
        "Schoellkopf Track": "SKT",
        "Snee Hall": "SNE",
        "Schurman Hall": "SRM",
        "Space Science Building": "SSB",
        "Stocking Hall": "STK",
        "Statler Hall": "STL",
        "Stimson Hall": "STM",
        "Savage Hall": "SVG",
        "Schwartz Center": "SWZ",
        "Townhouse Community Center": "TCC",
        "Teaching Dairy Barn": "TDB",
        "Teagle Hall": "TGL",
        "Tata Innovation Center": "TIC",
        "Thurston Avenue 626": "THA",
        "Thurston Hall": "THR",
        "Olive Tjaden Hall": "TJN",
        "Toni Morrison Hall": "TMR"
    ]
}

