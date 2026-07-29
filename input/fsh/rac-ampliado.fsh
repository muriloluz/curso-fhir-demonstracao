// ============================================================
// RAC AMPLIADO — o exemplo "ainda mais completo".
// Reaproveita as Instances do rac-recursos.fsh (peso, altura,
// dipirona, plano, motivo, local, consulta, salbutamol...) e
// acrescenta o que os perfis permitem repetir:
//   - 2º diagnóstico (J459 asma, como comorbidade — use #CM)
//   - 2º procedimento (0301100039 aferição de pressão arterial)
//   - 3ª observação (CA — circunferência abdominal)
//   - 2ª alergia (amendoim — CBARA, categoria alimentar)
//   - 2ª prescrição (paracetamol) NA MESMA seção do RPM
//     (Composition.section.entry é 1..* no BRRegistroPrescricao)
// Repare nos padrões de repetição: seções 1..*/0..* com entry
// 1..1 repetem a SEÇÃO (uma entry cada), não a entry.
// ============================================================

// ---------- 2º diagnóstico: asma (comorbidade) ----------

Instance: RacDiagnosticoAsma
InstanceOf: BRProblemaDiagnostico
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p>Comorbidade ativa: J45.9 — Asma não especificada (CID-10). Paciente CPF 12345678909.</p></div>"""
* clinicalStatus.coding = $cond-clinical#active
* code.coding = $cid10#J459
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"

// ---------- 2º procedimento: aferição de pressão arterial ----------

Instance: RacProcedimentoAfericaoPA
InstanceOf: BRProcedimentoRealizado-1.0
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p>Procedimento concluído em 22/07/2026: 0301100039 — aferição de pressão arterial (Tabela SUS), quantidade 1. Paciente CPF 12345678909.</p></div>"""
* extension[quantity].valuePositiveInt = 1
* status = #completed
* code.coding = $tabela-sus#0301100039
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* performedDateTime = "2026-07-22T09:05:00-03:00"
* performer[practitioner].extension[healthcareTeam].valueInteger = 1234567
* performer[practitioner].function.coding = $cbo#225103
* performer[practitioner].actor.identifier.system = $id-lotacao
* performer[practitioner].actor.identifier.value = "898001160660034-2337545"
* performer[practitioner].onBehalfOf.identifier.system = $id-estabelecimento
* performer[practitioner].onBehalfOf.identifier.value = "2337545"

// ---------- 3ª observação: circunferência abdominal ----------

Instance: RacObservacaoCircAbdominal
InstanceOf: BRMedidaObservada
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Circunferência abdominal</b>: 89 cm, aferida no atendimento.</p></div>"""
* status = #final
* code.coding = $tipo-obs#CA
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* effectiveTiming.event = "2026-07-22T09:45:00-03:00"
* valueQuantity.value = 89
* valueQuantity.unit = "cm"
* valueQuantity.system = $ucum
* valueQuantity.code = #cm

// ---------- 2ª alergia: amendoim (alimentar, catálogo CBARA) ----------

Instance: RacAlergiaAmendoim
InstanceOf: BRAlergiaReacaoAdversa-1.0
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Alergia alimentar</b>: amendoim (CBARA) — confirmada, baixa criticidade. Reação prévia: angioedema. Início: 10/06/2015.</p></div>"""
* clinicalStatus.coding = $alergia-clinical#active
* verificationStatus.coding = $alergia-verif#confirmed
* type = #allergy
* category = #food
* criticality = #low
* code.coding = $alergenos-cbara#amendoim
* patient.identifier.system = $id-individuo
* patient.identifier.value = "12345678909"
* onsetDateTime = "2015-06-10"
* reaction.manifestation.coding = $meddra#10002424

// ---------- 2ª prescrição: paracetamol (mesma seção do RPM) ----------

Instance: RacMedicamentoParacetamol
InstanceOf: BRMedicamento
Usage: #inline
* code.coding = $medicamento#BR0267778-1
* form.coding = $unidade#27

Instance: RacPrescricaoParacetamol
InstanceOf: BRPrescricaoMedicamento
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p>Prescrição ativa: paracetamol 500 mg pó para solução 10 ml, via oral, se dor ou febre, até 4 administrações/dia por 3 dias, validade 22/07/2026–25/07/2026, dispensar 12 envelopes. Paciente CPF 12345678909.</p></div>"""
* status = #active
* intent = #order
* medicationReference.reference = "urn:uuid:f2a3b4c5-6d7e-4f80-99ba-123456789012"
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* authoredOn = "2026-07-22T09:40:00-03:00"
* requester.identifier.system = $id-lotacao
* requester.identifier.value = "898001160660034-2337545"
* recorder.identifier.system = $id-lotacao
* recorder.identifier.value = "898001160660034-2337545"
* dosageInstruction.timing.repeat.count = 12
* dosageInstruction.timing.repeat.countMax = 12
* dosageInstruction.route.coding = $via-adm#10907
* dosageInstruction.doseAndRate.type.coding = $unidade#48
* dosageInstruction.doseAndRate.doseQuantity.value = 10
* dosageInstruction.maxDosePerAdministration.value = 10
* dispenseRequest.validityPeriod.start = "2026-07-22T00:00:00-03:00"
* dispenseRequest.validityPeriod.end = "2026-07-25T23:59:59-03:00"
* dispenseRequest.quantity.value = 12

// ---------- RPM ampliado: 1 seção, 2 entries (1..*) ----------

Instance: RacPrescricaoComposicaoAmpliada
InstanceOf: BRRegistroPrescricaoMedicamento
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Registro de Prescrição de Medicamento</b> — paciente CPF 12345678909, prescrito em 22/07/2026 pela UBS CNES 2337545: (1) salbutamol sulfato 0,4 mg/ml xarope, via bucal; (2) paracetamol 500 mg pó para solução 10 ml, via oral.</p></div>"""
* status = #final
* type.coding = $tipo-doc#RPM
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* date = "2026-07-22T09:40:00-03:00"
* author.identifier.system = $id-estabelecimento
* author.identifier.value = "2337545"
* title = "Registro de Prescrição de Medicamento"
* section.entry[0].reference = "urn:uuid:3f4a5b60-7c8d-4e9f-a0b1-6d7e8f90a1b3"
* section.entry[1].reference = "urn:uuid:e1f2a3b4-5c6d-4e7f-88a9-012345678901"

// ---------- Contato assistencial ampliado: 2 diagnósticos + 2 procedimentos ----------

Instance: RacContatoAssistencialAmpliado
InstanceOf: BRContatoAssistencial-1.0
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p>Contato assistencial finalizado, atenção básica, demanda espontânea, 22/07/2026 09:00–09:40. Paciente CPF 12345678909, profissional lotado (CNS 898001160660034, CNES 2337545), UBS CNES 2337545. Diagnósticos: J06.9 (atendimento) e J45.9 (comorbidade). Procedimentos: consulta na APS e aferição de pressão arterial. Motivo: dor de garganta e coriza há 3 dias. Local: Consultório 3. Desfecho: alta clínica.</p></div>"""
* status = #finished
* class = $modalidade#01
* priority.coding = $carater#05
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* participant.extension[function].valueCodeableConcept.coding = $cbo#225103
* participant.extension[team].valueInteger = 1234567
* participant.type.coding = $responsabilidade#atendimento
* participant.individual.identifier.system = $id-lotacao
* participant.individual.identifier.value = "898001160660034-2337545"
* period.start = "2026-07-22T09:00:00-03:00"
* period.end = "2026-07-22T09:40:00-03:00"
// dois diagnósticos no MESMO slice (0..*): AD (principal) e CM (comorbidade)
* diagnosis[problemAndDiagnosis][0].condition.reference = "urn:uuid:5b6f3a10-2c1e-4a7b-9a44-1f2ab3c4d5e6"
* diagnosis[problemAndDiagnosis][0].use.coding = $diag-role#AD
* diagnosis[problemAndDiagnosis][1].condition.reference = "urn:uuid:f6a7b8c9-0d1e-4f2a-93b4-5c6d7e8f9012"
* diagnosis[problemAndDiagnosis][1].use.coding = $diag-role#CM
// dois procedimentos no slice procedure (1..*), ambos com financiador
* diagnosis[procedure][0].condition.reference = "urn:uuid:7c8d9e20-3f4a-4b5c-8d6e-2a3b4c5d6e7f"
* diagnosis[procedure][0].condition.extension[financier].valueCodeableConcept.coding = $financiamento#01
* diagnosis[procedure][1].condition.reference = "urn:uuid:a7b8c9d0-1e2f-4a3b-84c5-6d7e8f901234"
* diagnosis[procedure][1].condition.extension[financier].valueCodeableConcept.coding = $financiamento#01
* hospitalization.admitSource.coding = $procedencia#09
* hospitalization.dischargeDisposition.coding = $desfecho#01
* serviceProvider.identifier.system = $id-estabelecimento
* serviceProvider.identifier.value = "2337545"
* reasonReference.reference = "urn:uuid:b2c3d4e5-6f7a-4b8c-9d0e-1f2a3b4c5d6e"
* location.location.reference = "urn:uuid:c3d4e5f6-7a8b-4c9d-a0e1-2f3a4b5c6d7e"

// ---------- Composition RAC ampliada: seções repetidas ----------

Instance: RacComposicaoAmpliada
InstanceOf: BRRegistroAtendimentoClinico
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Registro de Atendimento Clínico</b> — atenção básica. Paciente CPF 12345678909, atendida em 22/07/2026 na UBS CNES 2337545. Diagnósticos: J06.9 (atendimento) e J45.9 (comorbidade). Procedimentos: 0301010030 (consulta APS) e 0301100039 (aferição de PA). Prescrição: salbutamol xarope (bucal) e paracetamol pó para solução (oral). Observações: peso 72,5 kg; altura 175 cm; circunferência abdominal 89 cm. Alergias: dipirona (medicamento, alta criticidade — urticária) e amendoim (alimento, baixa criticidade — angioedema). Plano de cuidados: hidratação, repouso e retorno em 7 dias.</p></div>"""
* status = #final
* type.coding = $tipo-doc#RAC
* category.coding = $modalidade#01
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* date = "2026-07-22T09:45:00-03:00"
* author.identifier.system = $id-estabelecimento
* author.identifier.value = "2337545"
* title = "Registro de Atendimento Clínico"
* section[informacoesContatoAssistencial].entry.reference = "urn:uuid:e5f6a7b8-9c0d-4e1f-82a3-4b5c6d7e8f90"
// problemasDiagnosticosAvaliados: 1..* com entry 1..1 → repete a SEÇÃO
* section[problemasDiagnosticosAvaliados][0].entry.reference = "urn:uuid:5b6f3a10-2c1e-4a7b-9a44-1f2ab3c4d5e6"
* section[problemasDiagnosticosAvaliados][1].entry.reference = "urn:uuid:f6a7b8c9-0d1e-4f2a-93b4-5c6d7e8f9012"
// procedimentosRealizados: idem (1..*, entry 1..1)
* section[procedimentosRealizados][0].entry.reference = "urn:uuid:7c8d9e20-3f4a-4b5c-8d6e-2a3b4c5d6e7f"
* section[procedimentosRealizados][1].entry.reference = "urn:uuid:a7b8c9d0-1e2f-4a3b-84c5-6d7e8f901234"
* section[prescricao].entry.reference = "urn:uuid:d0e1f2a3-4b5c-4d6e-97f8-901234567890"
// observacoes: agora com 3 seções
* section[observacoes][0].entry.reference = "urn:uuid:8b9c0da0-1e2f-4a3b-8c4d-e5f60718293a"
* section[observacoes][1].entry.reference = "urn:uuid:9c0d1eb0-2f3a-4b4c-9d5e-f60718293a4b"
* section[observacoes][2].entry.reference = "urn:uuid:b8c9d0e1-2f3a-4b4c-95d6-7e8f90123456"
// alergiaReacaoAdversa: 2 alergias = 2 seções (1 entry cada)
* section[alergiaReacaoAdversa][0].entry.reference = "urn:uuid:5f6a7b80-9c0d-4e1f-a2b3-c4d5e6f708a9"
* section[alergiaReacaoAdversa][1].entry.reference = "urn:uuid:c9d0e1f2-3a4b-4c5d-86e7-8f9012345678"
* section[planoCuidados].entry.reference = "urn:uuid:a1b2c3d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d"

// ---------- O Bundle ampliado: 19 entries ----------

Instance: rac-bundle-ampliado
InstanceOf: Bundle
Usage: #example
Title: "RAC — exemplo ainda mais completo (bundle ampliado)"
Description: "Versão ampliada do RAC: 2 diagnósticos (J06.9 atendimento + J45.9 comorbidade), 2 procedimentos (consulta APS + aferição de PA), prescrição com 2 medicamentos (salbutamol + paracetamol) no mesmo RPM, 3 observações (peso, altura, circunferência abdominal), 2 alergias (dipirona + amendoim), plano de cuidados, motivo do contato e local. Demonstra os padrões de repetição dos perfis: seções 1..*/0..* com entry 1..1 repetem a seção; a seção do RPM aceita N entries."
* identifier.system = "http://www.saude.gov.br/fhir/r4/NamingSystem/BRRNDS-99999"
* identifier.value = "2337545-8f2b47ac-3d5e-4c91-b76a-de0f19283a4b"
* type = #document
* timestamp = "2026-07-22T09:45:00-03:00"
* entry[0].fullUrl = "urn:uuid:d4e5f6a7-8b9c-4d0e-b1f2-3a4b5c6d7e8f"
* entry[0].resource = RacComposicaoAmpliada
* entry[1].fullUrl = "urn:uuid:e5f6a7b8-9c0d-4e1f-82a3-4b5c6d7e8f90"
* entry[1].resource = RacContatoAssistencialAmpliado
* entry[2].fullUrl = "urn:uuid:5b6f3a10-2c1e-4a7b-9a44-1f2ab3c4d5e6"
* entry[2].resource = RacProblemaDiagnostico
* entry[3].fullUrl = "urn:uuid:f6a7b8c9-0d1e-4f2a-93b4-5c6d7e8f9012"
* entry[3].resource = RacDiagnosticoAsma
* entry[4].fullUrl = "urn:uuid:7c8d9e20-3f4a-4b5c-8d6e-2a3b4c5d6e7f"
* entry[4].resource = RacProcedimentoRealizado
* entry[5].fullUrl = "urn:uuid:a7b8c9d0-1e2f-4a3b-84c5-6d7e8f901234"
* entry[5].resource = RacProcedimentoAfericaoPA
* entry[6].fullUrl = "urn:uuid:d0e1f2a3-4b5c-4d6e-97f8-901234567890"
* entry[6].resource = RacPrescricaoComposicaoAmpliada
* entry[7].fullUrl = "urn:uuid:3f4a5b60-7c8d-4e9f-a0b1-6d7e8f90a1b3"
* entry[7].resource = RacPrescricaoMedicamento
* entry[8].fullUrl = "urn:uuid:4a5b6c70-8d9e-4fa0-b1c2-7e8f90a1b2c4"
* entry[8].resource = RacMedicamento
* entry[9].fullUrl = "urn:uuid:e1f2a3b4-5c6d-4e7f-88a9-012345678901"
* entry[9].resource = RacPrescricaoParacetamol
* entry[10].fullUrl = "urn:uuid:f2a3b4c5-6d7e-4f80-99ba-123456789012"
* entry[10].resource = RacMedicamentoParacetamol
* entry[11].fullUrl = "urn:uuid:8b9c0da0-1e2f-4a3b-8c4d-e5f60718293a"
* entry[11].resource = RacObservacaoPeso
* entry[12].fullUrl = "urn:uuid:9c0d1eb0-2f3a-4b4c-9d5e-f60718293a4b"
* entry[12].resource = RacObservacaoAltura
* entry[13].fullUrl = "urn:uuid:b8c9d0e1-2f3a-4b4c-95d6-7e8f90123456"
* entry[13].resource = RacObservacaoCircAbdominal
* entry[14].fullUrl = "urn:uuid:5f6a7b80-9c0d-4e1f-a2b3-c4d5e6f708a9"
* entry[14].resource = RacAlergiaDipirona
* entry[15].fullUrl = "urn:uuid:c9d0e1f2-3a4b-4c5d-86e7-8f9012345678"
* entry[15].resource = RacAlergiaAmendoim
* entry[16].fullUrl = "urn:uuid:a1b2c3d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d"
* entry[16].resource = RacPlanoCuidados
* entry[17].fullUrl = "urn:uuid:b2c3d4e5-6f7a-4b8c-9d0e-1f2a3b4c5d6e"
* entry[17].resource = RacMotivoContato
* entry[18].fullUrl = "urn:uuid:c3d4e5f6-7a8b-4c9d-a0e1-2f3a4b5c6d7e"
* entry[18].resource = RacLocalAtendimento
