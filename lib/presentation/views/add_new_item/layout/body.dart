import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_app/backend/models/food_item.dart';
import 'package:food_app/backend/services/user.dart';
import 'package:food_app/configuration/front_end.dart';
import 'package:food_app/presentation/elements/app_button.dart';
import 'package:food_app/presentation/elements/custom_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../configuration/back_end.dart';
import 'widgets/add_title_and_notes_text_field.dart';
import 'widgets/bottom_sheet_container.dart';
import 'widgets/custom_drop_down_tile.dart';
import 'widgets/inc_dec_button.dart';

class AddNewItemViewBody extends StatefulWidget {
  const AddNewItemViewBody({Key? key}) : super(key: key);

  @override
  State<AddNewItemViewBody> createState() => _AddNewItemViewBodyState();
}

class _AddNewItemViewBodyState extends State<AddNewItemViewBody> {
  String _itemFromDropdownValue = 'Selecting item from';
  final List<String> _itemsFromList = [
    'Selecting item from',
    'Fridge',
    'Freezer',
    'Pantry'
  ];
  String _categoryDropdownValue = 'Select Category';
  final List<String> _categoryList = [
    'Select Category',
    'Vegetables',
    'Fruits',
    'Dairy',
    'Meat'
  ];
  bool isLoading = false;
  String _url = '';
  int _quantity = 0;
  String _expiryDate = 'Expiry Date';
  bool _isVegetable = false;
  bool _isFruit = false;
  bool _isDairy = false;
  bool _isMeat = false;
  bool _isFromFridge = false;
  bool _isFromFreezer = false;
  bool _isFromPantry = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  dispose() {
    super.dispose();
    _titleController.dispose();
    _notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserServices userServices = UserServices();
    return LoadingOverlay(
      opacity: 0.2,
      isLoading: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'New Item',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  textColor: FrontEndConfigs.kPrimaryColor,
                ),
                const CustomText(
                  text: 'Add new item in your list and track ',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Color(0xff8D8D8D),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: FrontEndConfigs.kWhiteColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10))),
                              builder: (context) {
                                return Container(
                                  height: 150,
                                  padding: const EdgeInsets.all(20),
                                  color: FrontEndConfigs.kWhiteColor,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _pickImageWithOptionsAndUpload(
                                                ImageSource.camera);
                                            Navigator.pop(context);
                                          },
                                          child: const BottomSheetContainer(
                                            text: 'Take Photo',
                                            icon: Icons.camera_alt_outlined,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _pickImageWithOptionsAndUpload(
                                                ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                          child: const BottomSheetContainer(
                                            text: 'Gallery',
                                            icon: Icons.collections,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                            height: 84,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xffE6E6E6),
                            ),
                            child: _url.isEmpty
                                ? const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40,
                                    color: Color(0xffA8A5A5),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: CachedNetworkImage(
                                      imageUrl: _url,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress)),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ))),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Expanded(
                        child: CustomText(
                            text: 'Take or import image of your food',
                            fontSize: 12,
                            align: TextAlign.start,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 20, right: 20),
                  decoration: BoxDecoration(
                    color: FrontEndConfigs.kWhiteColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          text: 'Quantity',
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IncDecButton(
                                onPressed: () {
                                  if (_quantity > 0) {
                                    _quantity = _quantity - 1;
                                    setState(() {});
                                  } else {
                                    null;
                                  }
                                },
                                icon: Icons.remove),
                            const SizedBox(
                              width: 22,
                            ),
                            CustomText(
                                text: _quantity.toString(),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            const SizedBox(
                              width: 22,
                            ),
                            IncDecButton(
                                onPressed: () {
                                  _quantity = _quantity + 1;
                                  setState(() {});
                                },
                                icon: Icons.add),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  width: double.infinity,
                  color: FrontEndConfigs.kWhiteColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 56,
                        child: ItemTitleAndNotesTextField(
                          hintText: 'Title',
                          maxLines: 1,
                          controller: _titleController,
                        ),
                      ),
                      _buildDivider(),
                      SizedBox(
                        height: 48,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                  text: _expiryDate.toString(),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  textColor: const Color(0xff414141)),
                              IconButton(
                                  splashRadius: 20,
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050),
                                    ).then((value) {
                                      _expiryDate = DateFormat("dd-MM-yyyy")
                                          .format(value!);
                                      setState(() {});
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: Color(0xff9B9B9B),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      _buildDivider(),
                      CustomDropDownTile(
                        itemValue: _itemFromDropdownValue,
                        itemsList: _itemsFromList,
                        onChange: (val) => setState(() {
                          if (val == 'Fridge') {
                            _isFromFridge = true;
                            _isFromFreezer = false;
                            _isFromPantry = false;
                          } else if (val == 'Freezer') {
                            _isFromFreezer = true;
                            _isFromFridge = false;
                            _isFromPantry = false;
                          } else if (val == 'Pantry') {
                            _isFromPantry = true;
                            _isFromFreezer = false;
                            _isFromFridge = false;
                          }
                          _itemFromDropdownValue = val;
                        }),
                      ),
                      _buildDivider(),
                      CustomDropDownTile(
                        itemValue: _categoryDropdownValue,
                        itemsList: _categoryList,
                        onChange: (val) => setState(() {
                          if (val == 'Vegetables') {
                            _isVegetable = true;
                            _isMeat = false;
                            _isDairy = false;
                            _isFruit = false;
                          } else if (val == 'Fruits') {
                            _isFruit = true;
                            _isVegetable = false;
                            _isDairy = false;
                            _isMeat = false;
                          } else if (val == 'Dairy') {
                            _isDairy = true;
                            _isFruit = false;
                            _isMeat = false;
                            _isVegetable = false;
                          } else if (val == 'Meat') {
                            _isMeat = true;
                            _isDairy = false;
                            _isFruit = false;
                            _isVegetable = false;
                          }
                          _categoryDropdownValue = val;
                        }),
                      ),
                      _buildDivider(),
                      ItemTitleAndNotesTextField(
                        hintText: 'Spacial Notes',
                        maxLines: 8,
                        controller: _notesController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppButton(
                      text: 'Add item',
                      onPressed: () async {
                        makeLoadingTrue();
                        await userServices
                            .addNewFoodItem(FoodItemModel(
                          image: _url,
                          quantity: _quantity,
                          name: _titleController.text,
                          expiryDate:
                              _expiryDate == 'Expiry Date' ? '' : _expiryDate,
                          isFromFreezer: _isFromFreezer,
                          isFromFridge: _isFromFridge,
                          isFromPantry: _isFromPantry,
                          isVegetable: _isVegetable,
                          isFruit: _isFruit,
                          isDairy: _isDairy,
                          isMeat: _isMeat,
                          description: _notesController.text,
                        ))
                            .then((value) {
                          makeLoadingFalse();
                          _clearAllFields();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor:
                                      FrontEndConfigs.kPrimaryColor,
                                  content: CustomText(
                                    text: 'Food item successfully added',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: FrontEndConfigs.kWhiteColor,
                                  )));
                        }).onError((error, stackTrace) {
                          makeLoadingFalse();
                          _clearAllFields();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor:
                                      FrontEndConfigs.kPrimaryColor,
                                  content: CustomText(
                                    text: 'Error occurred, Kindly try again',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: FrontEndConfigs.kWhiteColor,
                                  )));
                        });
                      },
                      height: 60),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  makeLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  makeLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  Divider _buildDivider() {
    return const Divider(
      color: Color(0xffBEBEBE),
      thickness: 0.4,
      height: 0,
    );
  }

  void _clearAllFields() {
    _itemFromDropdownValue = 'Selecting item from';
    _categoryDropdownValue = 'Select Category';
    _url = '';
    _quantity = 0;
    _expiryDate = ' Expiry Date';
    _isVegetable = false;
    _isFruit = false;
    _isDairy = false;
    _isMeat = false;
    _isFromFridge = false;
    _isFromFreezer = false;
    _isFromPantry = false;
    _titleController.clear();
    _notesController.clear();
    setState(() {});
  }

  Future<void> _uploadFileAndSetURL(String filePath, String fileName) async {
    File file = File(filePath);
    UploadTask uploadTask =
        BackEndConfigs.kStorage.ref('foodImages/$fileName').putFile(file);

    try {
      await uploadTask.whenComplete(() async {
        _url = await uploadTask.snapshot.ref.getDownloadURL();
        setState(() {});
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> _pickImageWithOptionsAndUpload(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: CustomText(
            text: 'No file selected',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: FrontEndConfigs.kWhiteColor,
          )));
      return;
    }
    final path = image.path;
    final name = image.name;

    _uploadFileAndSetURL(path, name);
  }
}
