/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'field_props.dart';

class AutoCompleteField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FieldProps fieldProps;
  final FocusNode? focusNode;

  const AutoCompleteField({
    Key? key,
    required this.textEditingController,
    required this.fieldProps,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      enabled: false,
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
          color: Color(0xFF3E3E70),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      textFieldConfiguration: TextFieldConfiguration(
        controller: textEditingController,
        focusNode: focusNode,
        style: const TextStyle(
          color: Color(0xFFFFFFFC),
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            labelText: fieldProps.labelText,
            labelStyle: const TextStyle(
              color: Color.fromRGBO(255, 255, 252, 0.5),
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: fieldProps.suffixIcon),
      ),
      onSuggestionSelected: (select) =>
          fieldProps.setSelected(select, textEditingController),
      itemBuilder: fieldProps.itemBuilder,
      suggestionsCallback: fieldProps.getSuggestions,
    );
  }
}
