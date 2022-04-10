import 'package:coffee_shop/models/coffee.dart';
import 'package:coffee_shop/resources/styles/gradients.dart';
import 'package:coffee_shop/resources/styles/text_styles.dart';
import 'package:coffee_shop/utils/coffee_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoffeeListView extends StatefulWidget {
  const CoffeeListView({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState()  => CoffeeListViewState();

}


class CoffeeListViewState extends State<CoffeeListView> {
  List<Coffee> coffeeListDB = [];

  final _pageCtrl = PageController(
    viewportFraction: 0.4
  );

  double _currentPage = 0.0;

  @override
  void initState() {
    _pageCtrl.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose(){
    _pageCtrl.removeListener(_scrollListener);
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(context),
          _priceHeader(),
          _coffeePageView(_pageCtrl)
        ],
      ),
    );
  }

  Widget _background(BuildContext context) {
    return Positioned(child: Container(
        height: MediaQuery.of(context).size.height,
        decoration:
        BoxDecoration(gradient: Gradients.brownGradient)));
  }

  Widget _priceHeader(){
    try{
      if(_currentPage.floor() == 0){
        return Positioned(child: Container(
            height: 150,
            child: Center(child:
              Text(
                coffeeListDB[_currentPage.floor()].name,
                style: TextStyles.titleTextStyle,
              )
            )
        ));
      }
      return Positioned(child: Container(
          height: 150,
          child: Center(child:
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 50,
                  child:Text(
                  coffeeListDB[_currentPage.floor()].name,
                  style: TextStyles.titleTextStyle,
                )),
                Positioned(
                  top: 80,
                  child: Text(
                    "\$"+coffeeListDB[_currentPage.floor()].price.toString(),
                    style: TextStyles.priceTextStyle,
                  )
                )
              ],
            )
          )
      ));
    } catch(ex){
      return Positioned(child: Container(
          height: 150
      ));
    }

  }

  Widget _coffeePageView(PageController pageController) {
    return FutureBuilder(
      future: CoffeeUtils().getListCoffee(),
      builder:  (BuildContext context, AsyncSnapshot<List<Coffee>> coffeeList){
        if(!coffeeList.hasData){
          return SizedBox.shrink();
        }
        coffeeListDB = coffeeList.data ?? [];
        return PageView.builder(
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: coffeeList.data!.length + 1,
            itemBuilder: (context, index){
              if(index == 0) {
                return const SizedBox.shrink();
              }
              final value = (-0.4 * (_currentPage - index ) + 1) * 1.1;
              final opacity = value.clamp(0.0, 1.0);
              double xPoint = (MediaQuery.of(context).size.height/2.4 * (1 - value).abs()) * 0.05;
              double xPointReal = (MediaQuery.of(context).size.height/2.4 * (1 - value)) * 0.05;
              if(xPointReal > 0) {
                xPoint = xPoint * 20;
              }
              return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 1.001)
                    ..translate(0.0, xPoint)
                    ..scale(value),
                  child: Opacity(
                      opacity: opacity,
                      child: Image.asset(coffeeList.data![index - 1].imageUrl)
                  )
              );
            });
      },
    );
  }


  void _scrollListener() {
    setState(() {
      _currentPage = _pageCtrl.page!;
    });
  }
}