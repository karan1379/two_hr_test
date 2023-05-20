
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:two_hr_test/data/image_model.dart';
import 'package:two_hr_test/helper/routes/routes.dart';
import 'package:two_hr_test/home_module/controller/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final controller = Get.put(HomeScreenController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() {
    Future.delayed(const Duration(milliseconds: 1000)).then((val) async {
      await controller.getList();
      _refreshController.refreshCompleted();
    });
  }


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body:
      Obx(()=>
      controller.imageList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const MaterialClassicHeader(
          color: Colors.black,
        ),
        footer:const ClassicFooter(
          loadingIcon: CupertinoActivityIndicator(
            color: Colors.black,
          ),
          loadStyle: LoadStyle.ShowWhenLoading,
        ),
        controller: _refreshController,
        scrollDirection: Axis.vertical,
        onRefresh: _onRefresh,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (ctx, position) {
            final bodyData = controller.imageList[position];
            return createCard(bodyData);
          },
          itemCount: controller.imageList.length,
        ),
      )
      ),
    );
  }
  Widget createCard(ImageModel bodyData) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 80,
        child: InkWell(
          onTap: (){
            Get.toNamed(Routes.homeDetails,arguments:bodyData);
          },
          child: Card(
            clipBehavior: Clip.hardEdge,
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                CachedNetworkImage(
                  imageUrl:bodyData.image??"",
                  imageBuilder: (context, imageProvider)=>
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                  errorWidget: (context, url, error) =>
                      Container(
                        decoration:const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/placeholder.jpeg"),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        color: const Color(0x80000000),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${bodyData.title}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text("Price : ${bodyData.price}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ))
                )],
            ),
          ),
        ),
      ),
    );
  }
}
