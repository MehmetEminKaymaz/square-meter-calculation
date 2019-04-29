import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  title: "Metre Kare Hesaplama",
  home: new MyApp(),

));

class MyApp extends StatefulWidget {

  _State createState()=> new _State();

}

class _State extends State<MyApp>{

 bool _isCheckedCM=true;
 bool _isCheckedM=false;


 double _toplam=0.0;
  
  final TextEditingController _yatay = new TextEditingController();
  final TextEditingController _dikey = new TextEditingController();

  final TextEditingController _maliyet = new TextEditingController();
  final TextEditingController _satis = new TextEditingController();

  double _ToplamMaliyet=0.0;
  double _ToplamSatisTutari=0.0;
  double _ToplamKar=0.0;


  final List<String> _sonuclar = new List<String>();


  void _changeTutar(){
    double birimmaliyet = double.parse( _maliyet.text);
    double birimsatis = double.parse(_satis.text);

setState(() {
  _ToplamMaliyet=_toplam*birimmaliyet;
  _ToplamSatisTutari=_toplam*birimsatis;
  _ToplamKar=_ToplamSatisTutari-_ToplamMaliyet;
});




  }

  Paint _RenkDondur(){
    if(_ToplamKar<0) {
      return Paint()
        ..color = Colors.red;
    }
    else if(_toplam>0){
      return Paint()..color=Colors.green;
    }
    else if(_toplam==0){
      return Paint()..color=Colors.black;
    }
 }

  void _changeCM(bool value){
    setState(() {
      if(value){
        _isCheckedCM=true;
        _isCheckedM=false;

      }
    });
  }

  void _changeM(bool value){
    setState(() {
      if(value){
        _isCheckedM=true;
        _isCheckedCM=false;
      }
    });
  }




  void _HesaplaVeEkle(){
    if(_isCheckedM==true||_isCheckedCM==true) {
      setState(() {
        if(_isCheckedCM==true) {
          double x = double.parse(_yatay.text);
          double y = double.parse(_dikey.text);
          double sonuc = (x/100)*(y/100);
          _toplam+=sonuc;
          _sonuclar.add("${_yatay.text}X${_dikey.text} = ${sonuc.toStringAsFixed(2)}");
          _yatay.text="";
          _dikey.text="";

        }else if(_isCheckedM==true){
          double x = double.parse(_yatay.text);
          double y = double.parse(_dikey.text);
          double sonuc = x*y;
          _toplam+=sonuc;
          _sonuclar.add("${_yatay.text}X${_dikey.text} = ${sonuc.toStringAsFixed(2)}");
          _yatay.text="";
          _dikey.text="";
        }


      });
    }
  }

  void _Temizle(){
    setState(() {
       _sonuclar.clear();
       _toplam=0.0;
       _maliyet.text="";
       _satis.text="";
       _ToplamKar=0.0;
       _ToplamMaliyet=0.0;
       _ToplamSatisTutari=0.0;

    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Metre Kare Hesaplama"),

      ),
      drawer: new Drawer(child: new Container(
        padding: EdgeInsets.all(16.0),
        child:new Column(
          children: <Widget>[
            new Text("Metre Kare ",style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold,foreground: Paint()..color=Colors.indigoAccent ),),
            new Flexible(child: new TextField(decoration: InputDecoration(hintText: "Birim Maliyet TL (m2) "),controller:_maliyet ,)),
            new Flexible(child: new TextField(decoration: InputDecoration(hintText: "Birim Satış TL (m2) "),controller:_satis ,)),
            new Center(child: new RaisedButton(child: new Text("Hesapla",),onPressed: (){_changeTutar();}),),
            new Text("Toplam Alan (m2) : ${_toplam.toStringAsFixed(2)}",style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold,foreground: Paint()..color=Colors.blue),textAlign: TextAlign.left,),
            new Text("Toplam Maliyet : ${_ToplamMaliyet.toStringAsFixed(2)} TL",style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold,foreground: Paint()..color=Colors.red  ),textAlign: TextAlign.left,),
            new Text("Toplam Satış Tutarı : ${_ToplamSatisTutari.toStringAsFixed(2)} TL",style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold, ),textAlign: TextAlign.left,),
            new Text("Toplam Kar : ${_ToplamKar.toStringAsFixed(2)} TL",style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold,foreground: _RenkDondur()),textAlign: TextAlign.left,)
          ],
        ) ,
      ),),
      body: new Container(

        padding: EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[

            new Row(children: <Widget>[
              new Flexible(child:  new CheckboxListTile(title: new Text("Metre Cinsi"),value: _isCheckedM, onChanged:(bool value){_changeM(value);}),),
              new Flexible(child:  new CheckboxListTile(title: new Text("Santimetre Cinsi"),value: _isCheckedCM, onChanged: (bool value){_changeCM(value);}))

            ],),
             new Row(
              children: <Widget>[

                new Flexible(child: new  TextField(keyboardType: TextInputType.numberWithOptions(),decoration: InputDecoration(hintText: "Yatay"),controller: _yatay,/*onChanged: (v)=>_yatay.text=v,*/),),
                new Flexible(child: new TextField(keyboardType: TextInputType.numberWithOptions(),decoration: InputDecoration(hintText: "Dikey"),controller: _dikey,/*onChanged: (v)=>_dikey.text=v,*/),)




              ],
            ),

             new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                new Flexible(child:  new RaisedButton(child: new Text("Temizle"),onPressed: (){_Temizle();}),),
                new Flexible(child:  new RaisedButton(child: new Text("Ekle/Hesapla"),onPressed: (){_HesaplaVeEkle();}))

              ],
            ),
            new Expanded(child:  new ListView.builder(

                shrinkWrap: true,
                itemCount: _sonuclar.length,
                itemBuilder: (BuildContext context,int index){
                  return new Card(
                    child: new Container(

                      padding: const EdgeInsets.all(32.0),
                      child: new Row(

                        children: <Widget>[
                         new Flexible(child: new Text("${_sonuclar[index]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                         new Flexible(child: Image(image: AssetImage("images/metrekare.png"),width: 30,height: 30,)),

                        ],
                      ),
                    ),

                  );}),),

            new Text("Toplam Metre Kare : ${_toplam.toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)
          ],
        ),
      ),
    );
  }


}
