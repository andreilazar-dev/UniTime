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

import 'informazioni_lezione_dto.dart';

part 'celle_dto.g.dart';

part 'celle_dto.freezed.dart';

@freezed
class CelleDTO with _$CelleDTO {
  const factory CelleDTO({
    @JsonKey(name: 'informazioni_lezione')
        InformazioniLezioneDTO? informazioniLezione,
    @JsonKey(name: 'mostra_aula') bool? mostraAula,
    @JsonKey(name: 'tipologia') String? tipologia,
    @JsonKey(name: 'display') List<String>? display,
    //@JsonKey(name: 'link_lezione_online') String? linkLezioneOnline,
    @JsonKey(name: 'codice_insegnamento') String? codiceInsegnamento,
    @JsonKey(name: 'nome_insegnamento') String? nomeInsegnamento,
    @JsonKey(name: 'nome') String? nome,
    @JsonKey(name: 'name_original') String? nameOriginal,
    //@JsonKey(name: 'Streaming') Streaming? streaming,
    @JsonKey(name: 'link_corso') String? linkCorso,
    @JsonKey(name: 'link_insegnamento') String? linkInsegnamento,
    @JsonKey(name: 'percorso_didattico') String? percorsoDidattico,
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'timestamp') int? timestamp,
    @JsonKey(name: 'data') String? data,
    @JsonKey(name: 'GiornoCompleto') String? giornoCompleto,
    @JsonKey(name: 'codice_aula') String? codiceAula,
    @JsonKey(name: 'codice_sede') String? codiceSede,
    @JsonKey(name: 'aula') String? aula,
    @JsonKey(name: 'orario') String? orario,
    @JsonKey(name: 'tipo') String? tipo,
    @JsonKey(name: 'giorno') String? giorno,
    @JsonKey(name: 'numero_giorno') String? numeroGiorno,
    @JsonKey(name: 'nome_giorno') String? nomeGiorno,
    @JsonKey(name: 'ora_inizio') String? oraInizio,
    @JsonKey(name: 'ora_fine') String? oraFine,
    @JsonKey(name: 'notes') String? notes,
    @JsonKey(name: 'maps') String? maps,
    //@JsonKey(name: 'loc_map') String? locMap,
    @JsonKey(name: 'coordX') String? coordX,
    @JsonKey(name: 'coordY') String? coordY,
    @JsonKey(name: 'NoteAula') String? noteAula,
    @JsonKey(name: 'NoteSettimanali') String? noteSettimanali,
    @JsonKey(name: 'Annullato') String? annullato,
    @JsonKey(name: 'insegnamento_tipo') List<String>? insegnamentoTipo,
    //@JsonKey(name: 'link_aula') List<String>? linkAula,
    @JsonKey(name: 'highlighted') int? highlighted,
    @JsonKey(name: 'from_esterno') int? fromEsterno,
    @JsonKey(name: 'titolo_lezione') String? titoloLezione,
    @JsonKey(name: 'asterisk_str') String? asteriskStr,
    @JsonKey(name: 'codice_docente') String? codiceDocente,
    @JsonKey(name: 'docente') String? docente,
    @JsonKey(name: 'identifier_cell') int? identifierCell,
    @JsonKey(name: 'vertical_idx') int? verticalIdx,
  }) = _CelleDTO;

  factory CelleDTO.fromJson(Map<String, dynamic> json) =>
      _$CelleDTOFromJson(json);
}
