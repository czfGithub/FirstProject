import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';
import 'package:image_picker/image_picker.dart';

class FaultRepair extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FaultRepair();
  }
}

class _FaultRepair extends State<FaultRepair>{

  List<File> _imageList = [new File('')];
  Future<File> _imageFile;

  void _selectedImage(bool isSelect) async{
    File file = await ImagePicker.pickImage(source: isSelect ? ImageSource.gallery : ImageSource.camera);
//    _imageFile = ImagePicker.pickImage(source: isSelect ? ImageSource.gallery : ImageSource.camera);
//      _imageFile.then((value) => _imageList.add(value));
    setState(() {
      if(file != null){
        _imageList.add(file);
      }
    });
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            _imageList.add(snapshot.data);
          }
          return Image.asset('images/ic_add_photo.png',width: 120,height: 120,);
        });
  }

  Future<String> _showModalBottomSheet() {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: ScreenUtil().setWidth(370),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Navigator.of(context).pop('1');
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(ScreenUtil().setWidth(40)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('拍照',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: ScreenUtil().setSp(32)),),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
                color: Color.fromRGBO(232, 232, 232, 1),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Navigator.of(context).pop('0');
                },
                child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(ScreenUtil().setWidth(40)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('相册',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: ScreenUtil().setSp(32)),),
                    )
                ),
              ),
              Container(
                width: double.infinity,
                height: ScreenUtil().setWidth(1),
                color: Color.fromRGBO(232, 232, 232, 1),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Navigator.of(context).pop('-1');
                },
                child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(ScreenUtil().setWidth(40)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('取消',style: TextStyle(color: Color.fromRGBO(186, 186, 186, 1),fontSize: ScreenUtil().setSp(32)),),
                    )
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        leading: 'images/ic_title_back_black.png',
        leftListener: (){
          Navigator.pop(context);
        },
        center: Text('故障报修',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Color.fromRGBO(232, 232, 232, 1),
                  width: double.infinity,
                  height: 0.5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 25,top: 25),
                  child: Text('请描述一下您所遇到的问题',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10,left: 25,right: 25,bottom: 20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(248, 248, 248, 1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    maxLines: 10,
                    maxLength: 500,
                    style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintText: '说明您遇到的问题',
                      hintStyle: TextStyle(color: Color.fromRGBO(95, 94, 94, 1),fontSize: 12)
                    ),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(232, 232, 232, 1),
                  width: double.infinity,
                  height: 0.5,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20,left: 25),
                  child: Text('图片上传（提供故障截图）',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 25,right: 25,top: 10),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
              ),
              delegate: SliverChildBuilderDelegate((context,index){
                if(index == 0)
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async{
                      String type = await _showModalBottomSheet();
                      if(type != null){
                        if(type == '1'){ //1 拍照 0 相册
                          _selectedImage(false);
                        }else if(type == '0'){
                          _selectedImage(true);
                        }
                      }
                    },
                    child: Image.asset('images/ic_add_photo.png',width: 120,height: 120,),
                  );
                else return Image.file(_imageList[index],width: 120,height: 120,fit: BoxFit.cover,);
              },childCount: _imageList.length),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 30,left: 15,right: 15,bottom: 30),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromRGBO(114, 198, 254, 1),Color.fromRGBO(30, 103, 228, 1),Color.fromRGBO(30, 103, 228, 1)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('提交',style: TextStyle(color: Colors.white,fontSize: 14),),
            ),
          ),
        ],
      ),
    );
  }
}