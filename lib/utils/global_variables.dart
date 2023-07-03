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
  },
  {
    "service": "EC Manual",
    "amount": 2500,
  },
  {
    "service": "Sale Deed (Certified Copy)",
    "amount": 2250,
  },
  {
    "service": "Mother Deed (Certified Copy)",
    "amount": 2250,
  },
  {
    "service": "Link Deeds",
    "amount": 2500,
  },
  {
    "service": "RTC/Phani Manual",
    "amount": 3500,
  },
  {
    "service": "RTC/Phani Digital",
    "amount": 1500,
  },
  {
    "service": "Khata/Patta/Mutation Records",
    "amount": 30000,
  },
  {
    "service": "Property Tax",
    "amount": 1000,
  },
  {
    "service": "Survey Maps",
    "amount": 1000,
  },
  {
    "service": "Legal Opinion",
    "amount": 3000,
  },
  {
    "service": "Legal Opinion Detailed",
    "amount": 5000,
  },
  {
    "service": "Legal Second Opinion",
    "amount": 4000,
  },
  {
    "service": "Revenue Records",
    "amount": 1000,
  },
  {
    "service": "Land Conversion/Change of Land use",
    "amount": 550000,
  },
  {
    "service": "Khata Extract",
    "amount": 3000,
  },
  {
    "service": "NOCs",
    "amount": 5000,
  },
  {
    "service": "Survey Records",
    "amount": 30000,
  },
  {
    "service": "Property Search",
    "amount": 1000,
  },
];
