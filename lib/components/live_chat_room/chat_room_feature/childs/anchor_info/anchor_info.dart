import 'package:flutter/material.dart';

class AnchorInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth; // 父層寬
        final maxHeight = constraints.maxHeight; // 父層高

        const paddingValue = 2.0; // 整個主播資訊容器的padding
        const borderRadiusValue = 8.0;

        return Container(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(paddingValue),
            width: maxWidth * 0.5,
            height: maxHeight,
            decoration: BoxDecoration(
                color: Color.fromARGB(150, 0, 0, 0),
                borderRadius: BorderRadius.circular(borderRadiusValue)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: maxHeight - paddingValue * 2,
                  width: maxHeight - paddingValue * 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.png',
                      image:
                          'https://img.zcool.cn/community/01379d567f8f126ac7251bb624a6d5.jpg@1280w_1l_2o_100sh.jpg',
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 2.0),
                            child: FittedBox(
                              child: Text(
                                'NINI',
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.yellowAccent,
                                  size: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    '666',
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: InkWell(
                    onTap: () {
                      print('object');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadiusValue),
                      ),
                      child: Text(
                        '关注',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w700,
                          fontSize: 12.0
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
