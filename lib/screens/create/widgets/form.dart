import 'package:expire/config/constants.dart';
import 'package:expire/models/category_model.dart';
import 'package:expire/service/category_service.dart';
import 'package:expire/service/create_service.dart';
import 'package:expire/widgets/button_widget.dart';
import 'package:expire/widgets/date_widget.dart';
import 'package:expire/widgets/input_widget.dart';
import 'package:expire/widgets/select_widget.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FormPageState();
  }
}

class _FormPageState extends State<FormPage> {
  List<String> _categoryData = [];
  List<CategoryList> _category = [];

  // 分类
  String _selectCategory = '药品';

  // 商品名称
  final TextEditingController _nameController = TextEditingController();

  // 生产日期
  List<DateTime?> _manufactureDate = [DateTime(2021, 8, 10)];

  // 有效日期
  final TextEditingController _qualityGuaranteePeriodController =
      TextEditingController();
  String _selectUnit = 'day';
  String _remind = '7';

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  // 获取分类
  Future<void> _getCategory() async {
    var res = await CategoryAPI.getCategoryData();

    List<String> nameList = [];

    for (var item in res.list) {
      nameList.add(item.name);
    }
    setState(() {
      _categoryData = nameList;
      _category = res.list;
    });
  }

  // 提交
  Future<void> _submit() async {
    String name = _nameController.value.text;
    String qualityGuaranteePeriod =
        _qualityGuaranteePeriodController.value.text;
    int categoryId = 0;

    if (name.isEmpty) {
      FToast.toast(
        context,
        duration: 800,
        msg: '请输入物品名称',
        msgStyle: const TextStyle(
          color: Colors.white,
        ),
      );
      return;
    }
    if (qualityGuaranteePeriod.isEmpty) {
      FToast.toast(
        context,
        duration: 800,
        msg: '请输入有效时间',
        msgStyle: const TextStyle(
          color: Colors.white,
        ),
      );
      return;
    }

    for (var item in _category) {
      if (item.name == _selectCategory) {
        categoryId = item.id;
      }
    }

    CreateAPI.getCreateData(
      name: name,
      manufactureDate:
          _manufactureDate.first.toString().replaceAll(' 00:00:00.000', ''),
      qualityGuaranteePeriod: int.parse(qualityGuaranteePeriod),
      categoryId: categoryId,
      unit: _selectUnit,
      remind: int.parse(_remind),
    ).then((value) {
      navigatorKey.currentState?.pushNamed('/home');
      FToast.toast(
        context,
        duration: 800,
        msg: '添加成功！',
        msgStyle: const TextStyle(
          color: Colors.white,
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _qualityGuaranteePeriodController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HCInput(
          controller: _nameController,
          hintText: '请输入物品名称',
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        HCSelect(
          value: _selectCategory,
          items: _categoryData,
          hintText: '请选择分类',
          onChanged: (String? value) {
            setState(() {
              _selectCategory = value!;
            });
          },
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        HCSelect(
          value: _selectUnit,
          items: const ['day', 'month', 'year'],
          hintText: '请选单位时间',
          onChanged: (String? value) {
            setState(() {
              _selectUnit = value!;
            });
          },
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        HCDatePicker(
          hintText: '请选择物品的生成日期',
          onChanged: (List<DateTime?>? value) {
            setState(() {
              _manufactureDate = value!;
            });
          },
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        HCInput(
          controller: _qualityGuaranteePeriodController,
          hintText: '请输入有效时间',
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        HCSelect(
          value: _remind,
          items: const ['7', '14', '21', '30'],
          hintText: '请选择到期提醒天数',
          onChanged: (String? value) {
            setState(() {
              _remind = value!;
            });
          },
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        HCButton(
          onPressed: () => _submit(),
          text: '提 交',
          backgroundColor: const Color(0xFF24A5EA),
          textColor: const Color(0xFFFFFFFF),
        ),
      ],
    );
  }
}
