/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'informazioni_lezione_dto.g.dart';

part 'informazioni_lezione_dto.freezed.dart';

@freezed
class InformazioniLezioneDTO with _$InformazioniLezioneDTO {
  const factory InformazioniLezioneDTO({
    //@JsonKey(name: 'timestamp') Streaming? timestamp,
    @JsonKey(name: 'intestazione') String? intestazione,
    //@JsonKey(name: 'contenuto') ContenutoDTO? contenuto,
  }) = _InformazioniLezioneDTO;

  factory InformazioniLezioneDTO.fromJson(Map<String, dynamic> json) =>
      _$InformazioniLezioneDTOFromJson(json);
}
