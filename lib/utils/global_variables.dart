import 'package:asset_ziva/screens/home_screen.dart';
import 'package:asset_ziva/screens/profile_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const HomeScreen(),
  const ProfileScreen(),
];

// Map<String, double> service = {
//   'EC Digital': 2000,
//   'EC Manual': 2500,
//   'Sale Deed (Certified Copy)': 2250,
//   'Mother Deed (Certified Copy)': 2250,
//   'Link Deeds': 2500,
//   'RTC/Phani Manual': 3500,
//   'RTC/Phani Digital': 1500,
//   'Khata/Patta/Mutation Records': 30000,
//   'Property Tax': 1000,
//   'Survey Maps': 1000,
//   'Legal Opinion': 3000,
//   'Legal Opinion Detailed': 5000,
//   'Legal Second Opinion': 4000,
//   'Revenue Records': 1000,
//   'Land Conversion/Change of Land use': 550000,
//   'Khata Extract': 3000,
//   'NOCs': 5000,
//   'Survey Records': 30000,
//   'Property Search': 1000,
// };

List<Map> services = [
  {
    "service": "EC Digital",
    "amount": 2000,
    "image": 'assets/ec-digital.png',
  },
  {
    "service": "EC Manual",
    "amount": 2500,
    "image": 'assets/ec-manual.png',
  },
  {
    "service": "Sale Deed (Certified Copy)",
    "amount": 2250,
    "image": 'assets/sale-deed.png',
  },
  {
    "service": "Mother Deed (Certified Copy)",
    "amount": 2250,
    "image": 'assets/mother-deed.png',
  },
  {
    "service": "Link Deeds",
    "amount": 2500,
    "image": 'assets/link-deeds.png',
  },
  {
    "service": "RTC/Phani Manual",
    "amount": 3500,
    "image": 'assets/rtc-phani-manual.png',
  },
  {
    "service": "RTC/Phani Digital",
    "amount": 1500,
    "image": 'assets/rtc-digital-phani.png',
  },
  {
    "service": "Khata/Patta/Mutation Records",
    "amount": 30000,
    "image": 'assets/khata-patta-mutation-records.png',
  },
  {
    "service": "Property Tax",
    "amount": 1000,
    "image": 'assets/property-tax.png',
  },
  {
    "service": "Survey Maps",
    "amount": 1000,
    "image": 'assets/survey-maps.png',
  },
  {
    "service": "Legal Opinion",
    "amount": 3000,
    "image": 'assets/legal-opinion.png',
  },
  {
    "service": "Legal Opinion Detailed",
    "amount": 5000,
    "image": 'assets/legal-opinion-detailed.png',
  },
  {
    "service": "Legal Second Opinion",
    "amount": 4000,
    "image": 'assets/legal-second-opinion.png',
  },
  {
    "service": "Revenue Records",
    "amount": 1000,
    "image": 'assets/revenue-records.png',
  },
  {
    "service": "Land Conversion/Change of Land use",
    "amount": 550000,
    "image": 'assets/land-conversion.png',
  },
  {
    "service": "Khata Extract",
    "amount": 3000,
    "image": 'assets/khata-extract.png',
  },
  {
    "service": "NOCs",
    "amount": 5000,
    "image": 'assets/nocs.png',
  },
  {
    "service": "Survey Records",
    "amount": 30000,
    "image": 'assets/survey-records.png',
  },
  {
    "service": "Property Search",
    "amount": 1000,
    "image": 'assets/property-search.png',
  },
];

List<Map> vendors = [
  {
    "vendor": "Construction",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Painting",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Gardening",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "R-E Agent",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Nursery",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Architect",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Interiors",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Solar Solutions",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Landscaping",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Plumbing",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Electrical",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "JCB",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Surveying",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Contractor",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Mason",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Loan Agents",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Bank Collaboration",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Metals",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Hardware",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Bricks Dealers",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Cement Dealers",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Wood Dealers",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Flooring",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Tiles & Ceramics",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Handlooms",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Furniture",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Welding",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Fabrication",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Tank Cleaning",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Waterproofing",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Water Treatment",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Pool Construction",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "M-Sand / P-Sand",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Key making",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Air Conditioning",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Scrap Dealers",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Demolishers",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Pest Control",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Vastu Consultant",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Logistics",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Labour Contractor",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Lift/Technicians",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Marbles & Granites",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Lighting",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Chimney",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "CCTV",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "Borewell",
    "image": 'assets/ec-digital.png',
  },
  {
    "vendor": "UPS Services",
    "image": 'assets/ec-digital.png',
  },
];
