import 'package:flutter/material.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dashboard/widgets/security/security_module_widget.dart';
import 'dart:ui';

class SecurityFormWidget extends StatefulWidget {
  final String formTitle;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final String textFieldTitle1;
  final String textFieldTitle2;
  final String textFieldTitle3;
  final String buttonTitle1;
  final String buttonTitle2;
  final String buttonTitle3;
  final VoidCallback buttonAction1;
  final VoidCallback buttonAction2;
  final VoidCallback buttonAction3;



  const SecurityFormWidget({
    super.key,
    required this.formTitle,
    required this.controller1,
    required this.controller2,
    required this.controller3,
    required this.textFieldTitle1,
    required this.textFieldTitle2,
    required this.textFieldTitle3,
    required this.buttonTitle1,
    required this.buttonTitle2,
    required this.buttonTitle3,
    required this.buttonAction1,
    required this.buttonAction2,
    required this.buttonAction3,
    });

  @override
  State<SecurityFormWidget> createState() => SecurityFormWidgetState();
}

class SecurityFormWidgetState extends State<SecurityFormWidget> {

  final GlobalKey<SecurityModuleWidgetState> _moduleKey = GlobalKey<SecurityModuleWidgetState>();

  void showError(String message) {
    setState(() {
      _moduleKey.currentState?.showError(message);
    });
  }

  @override
  Widget build(BuildContext context) {

    final desktop_form = Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 400.0,
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const SizedBox(
                                                  height:
                                                      50.0), // Added padding on top of the form
                                              TextField(
                                                controller: widget.controller1,
                                                decoration: InputDecoration(
                                                  labelText: widget.textFieldTitle1, // Changed from 'Username' to 'RSI Handle'
                                                  labelStyle: TextStyle(
                                                      color: Colors.white),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .yellow), // Change border color to yellow on focus
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(height: 16.0),
                                              TextField(
                                                controller: widget.controller2,
                                                decoration: InputDecoration(
                                                  labelText: widget.textFieldTitle2,
                                                  labelStyle: TextStyle(
                                                      color: Colors.white),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .yellow), // Change border color to yellow on focus
                                                  ),
                                                ),
                                                obscureText: true,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(height: 16.0),
                                              TextField(
                                                decoration: InputDecoration(
                                                  labelText: widget.textFieldTitle3,  
                                                  labelStyle: TextStyle(
                                                      color: Colors.white),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .yellow), // Change border color to yellow on focus
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                  height:
                                                      32.0), // Increased margin
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: widget.buttonAction1,
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        backgroundColor, // Set background color to black
                                                    textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30.0,
                                                      fontWeight: FontWeight
                                                          .bold, // make text bold
                                                    ), // text color and size
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 32.0,
                                                        vertical:
                                                            16.0), // button size
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .zero, // remove rounded corners
                                                    ),
                                                    elevation:
                                                        10.0, // Add elevation for 3D effect
                                                    shadowColor: Colors
                                                        .black, // Set shadow color
                                                    overlayColor: Colors
                                                        .grey, // Set color to grey on hover and click
                                                  ),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      widget.buttonTitle1,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white), // ensure text color is white
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                  height:
                                                      16.0), // Add spacing between button and links
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: widget.buttonAction2,
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            backgroundColor, // Set background color to black
                                                        textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.0,
                                                          fontWeight: FontWeight
                                                              .bold, // make text bold
                                                        ), // text color and size
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    16.0,
                                                                vertical:
                                                                    16.0), // button size
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.0), // Add radius to bottom left corner
                                                          ),
                                                        ),
                                                        elevation:
                                                            10.0, // Add elevation for 3D effect
                                                        shadowColor: Colors
                                                            .black, // Set shadow color
                                                        overlayColor: Colors
                                                            .grey, // Set color to grey on hover and click
                                                      ),
                                                      child: Text(
                                                        widget.buttonTitle2,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white), // ensure text color is white
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      width:
                                                          16.0), // Add spacing between buttons
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: widget.buttonAction3,
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            backgroundColor, // Set background color to black
                                                        textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.0,
                                                          fontWeight: FontWeight
                                                              .bold, // make text bold
                                                        ), // text color and size
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    16.0,
                                                                vertical:
                                                                    16.0), // button size
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.0), // Add radius to top right corner
                                                          ),
                                                        ),
                                                        elevation:
                                                            10.0, // Add elevation for 3D effect
                                                        shadowColor: Colors
                                                            .black, // Set shadow color
                                                        overlayColor: Colors
                                                            .grey, // Set color to grey on hover and click
                                                      ),
                                                      child: Text(
                                                        widget.buttonTitle3,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white), // ensure text color is white
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(16.0),
                                            bottomRight: Radius.circular(16.0),
                                          ),
                                          child: Container(
                                            width: 400,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  20.0), // Add padding around the logo
                                              child: Image.asset(
                                                'assets/logo/corp_logo.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                         
    final mobile_form = Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(
                                            height:
                                                50.0), // Added padding on top of the form
                                        Image.asset(
                                          'assets/logo/corp_logo.png',
                                          fit: BoxFit.cover,
                                          height:
                                              120.0, // Adjust the height to make the logo bigger
                                        ),
                                        TextField(
                                          controller: widget.controller1,
                                          decoration: const InputDecoration(
                                            labelText:
                                                'RSI handle', // Changed from 'Username' to 'RSI Handle'
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .yellow), // Change border color to yellow on focus
                                            ),
                                          ),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(height: 16.0),
                                        TextField(
                                          controller: widget.controller2,
                                          decoration: InputDecoration(
                                            labelText: widget.textFieldTitle2,
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .yellow), // Change border color to yellow on focus
                                            ),
                                          ),
                                          obscureText: true,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(height: 16.0),
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: widget.textFieldTitle3,
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .yellow), // Change border color to yellow on focus
                                            ),
                                          ),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(
                                            height: 32.0), // Increased margin
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: widget.buttonAction1,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  backgroundColor, // Set background color to black
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30.0,
                                                fontWeight: FontWeight
                                                    .bold, // make text bold
                                              ), // text color and size
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 32.0,
                                                  vertical:
                                                      16.0), // button size
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .zero, // remove rounded corners
                                              ),
                                              elevation:
                                                  10.0, // Add elevation for 3D effect
                                              shadowColor: Colors
                                                  .black, // Set shadow color
                                              overlayColor: Colors
                                                  .grey, // Set color to grey on hover and click
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                widget.buttonTitle1,
                                                style: TextStyle(
                                                    color: Colors
                                                        .white), // ensure text color is white
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            height:
                                                16.0), // Add spacing between button and links
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: widget.buttonAction2,
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      backgroundColor, // Set background color to black
                                                  textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight
                                                        .bold, // make text bold
                                                  ), // text color and size
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical:
                                                          16.0), // button size
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft: Radius.circular(
                                                          10.0), // Add radius to bottom left corner
                                                    ),
                                                  ),
                                                  elevation:
                                                      10.0, // Add elevation for 3D effect
                                                  shadowColor: Colors
                                                      .black, // Set shadow color
                                                  overlayColor: Colors
                                                      .grey, // Set color to grey on hover and click
                                                ),
                                                child: Text(
                                                  widget.buttonTitle2,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .white), // ensure text color is white
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    16.0), // Add spacing between buttons
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: widget.buttonAction3,
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      backgroundColor, // Set background color to black
                                                  textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight
                                                        .bold, // make text bold
                                                  ), // text color and size
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical:
                                                          16.0), // button size
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomRight: Radius.circular(
                                                          10.0), // Add radius to top right corner
                                                    ),
                                                  ),
                                                  elevation:
                                                      10.0, // Add elevation for 3D effect
                                                  shadowColor: Colors
                                                      .black, // Set shadow color
                                                  overlayColor: Colors
                                                      .grey, // Set color to grey on hover and click
                                                ),
                                                child: Text(
                                                  widget.buttonTitle3,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .white), // ensure text color is white
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );

   return SecurityModuleWidget(
            key: _moduleKey,
            formTitle: widget.formTitle,
            DesktoColumn: desktop_form,
            MobileColumn: mobile_form,
   );                    
  }
}

