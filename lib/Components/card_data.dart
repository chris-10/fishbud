final List<CardViewModel> demoCards = [
  new CardViewModel(
    backdropAssetPath: 'assets/images/home_bg.jpg',
    tankName: 'Tank 1\nSalmon',
    pHval: 6.5,
    tempInDegrees: 22.5,
    turbidity: 20.1,
    DOval: 39.5,
    salinity: 5.6,
    waterQuality: 0.78
  ),
  new CardViewModel(
      backdropAssetPath: 'assets/images/home_bg_2.jpeg',
      tankName: 'Tank 1\nSalmon',
      pHval: 6.5,
      tempInDegrees: 22.5,
      turbidity: 20.1,
      DOval: 39.5,
      salinity: 5.6,
      waterQuality: 0.78
  ),
  new CardViewModel(
      backdropAssetPath: 'assets/images/home_bg_3.jpg',
      tankName: 'Tank 1\nSalmon',
      pHval: 6.5,
      tempInDegrees: 22.5,
      turbidity: 20.1,
      DOval: 39.5,
      salinity: 5.6,
      waterQuality: 0.78
  ),
];

class CardViewModel {
  final String backdropAssetPath;
  final String tankName;
  final double pHval;
  final double turbidity;
  final double tempInDegrees;
  final double DOval;
  final double salinity;
  final double waterQuality;

  CardViewModel({
    this.backdropAssetPath,
    this.tankName,
    this.pHval,
    this.turbidity,
    this.tempInDegrees,
    this.DOval,
    this.salinity,
    this.waterQuality,
  });
}
