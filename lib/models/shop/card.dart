import 'package:flutter/material.dart';

class Card {
  final String name;
  final int id;
  final String imageRoute;
  final int coinCost;
  final int levelIndicator;
  final bool isBought;
  final BuyMethod buymethod;

  Card(
      {required this.name,
      required this.id,
      required this.imageRoute,
      required this.coinCost,
      required this.levelIndicator,
      required this.isBought,
      required this.buymethod});
}

class BuyMethod {
  final bool isCoinAvailable;
  final int coinCost;
  final bool isLevelAvailable;
  final int levelCost;
  bool isExpanded;

  BuyMethod({
    required this.isCoinAvailable,
    required this.coinCost,
    required this.isLevelAvailable,
    required this.levelCost,
    this.isExpanded = false,
  });
}

List<Card> demoCards = [
  Card(
      id: 1,
      name: "Midoriya",
      imageRoute: "assets/images/midoriya_nice.gif",
      coinCost: 600,
      levelIndicator: 2,
      isBought: false,
      buymethod: buyMethodCards[0]),
  Card(
      id: 2,
      name: "Midoriya",
      imageRoute: "assets/images/midoriya1.gif",
      coinCost: 600,
      levelIndicator: 2,
      isBought: false,
      buymethod: buyMethodCards[1]),
  Card(
      id: 3,
      name: "Midoriya",
      imageRoute: "assets/images/midoriya3.gif",
      coinCost: 600,
      levelIndicator: 2,
      isBought: false,
      buymethod: buyMethodCards[2]),
];

List<BuyMethod> buyMethodCards = [
  BuyMethod(
      coinCost: 650,
      isCoinAvailable: true,
      isLevelAvailable: true,
      levelCost: 2),
  BuyMethod(
      coinCost: 1000,
      isCoinAvailable: true,
      isLevelAvailable: false,
      levelCost: 2),
  BuyMethod(
      coinCost: 1200,
      isCoinAvailable: true,
      isLevelAvailable: true,
      levelCost: 5),
  BuyMethod(
      coinCost: 1400,
      isCoinAvailable: true,
      isLevelAvailable: true,
      levelCost: 7),
];
