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

part 'celle.freezed.dart';

@freezed
class Celle with _$Celle {
  const factory Celle({
    //InformazioniLezioneDTO? informazioniLezione,
    bool? mostraAula,
    String? tipologia,
    List<String>? display,
    String? linkLezioneOnline,
    String? codiceInsegnamento,
    String? nomeInsegnamento,
    String? nome,
    String? nameOriginal,
    //Streaming? streaming,
    String? linkCorso,

    ///String? linkInsegnamento,
    //String? percorsoDidattico,
    String? id,
    int? timestamp,
    String? data,
    String? giornoCompleto,
    String? codiceAula,
    String? codiceSede,
    String? aula,
    String? orario,
    String? tipo,
    String? giorno,
    String? numeroGiorno,
    String? nomeGiorno,
    String? oraInizio,
    String? oraFine,
    //String? notes,
    //String? maps,
    //String? locMap,
    //String? coordX,
    //String? coordY,
    String? noteAula,
    String? noteSettimanali,
    String? annullato,
    List<String>? insegnamentoTipo,
    //List<String>? linkAula,
    //int? highlighted,
    //int? fromEsterno,
    String? titoloLezione,
    //String? asteriskStr,
    String? codiceDocente,
    String? docente,
    //int? identifierCell,
    //int? verticalIdx,
  }) = _Celle;

// factory Celle.fromJson(Map<String, dynamic> json) =>
//     _$CelleFromJson(json);
}
