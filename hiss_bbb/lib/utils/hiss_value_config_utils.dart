class HissValueConfigUtils{
  static final HissValueConfigUtils _configUtils=HissValueConfigUtils();
  static HissValueConfigUtils get instance => _configUtils;

  //悬浮气泡
  double getBubbleAddNum()=> 10.2;

  //翻开一张牌
  double getFlipCardAddNum()=>5.0;

  List<int> cashList()=>[1000,1200,1500];
}