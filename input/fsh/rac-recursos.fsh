// ============================================================
// Recursos do RAC como instâncias INLINE (Usage: #inline):
// não são exportadas avulsas — existem para serem embutidas
// no Bundle document (rac-bundle.fsh), SEM id, como o perfil
// BRMedicamento exige (id ..0) e como o exemplo validado usa.
// InstanceOf = perfil real → SUSHI preenche meta.profile e
// confere as atribuições contra o StructureDefinition.
// ============================================================

Instance: RacComposicao
InstanceOf: BRRegistroAtendimentoClinico
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Registro de Atendimento Clínico</b> — atenção básica. Paciente CPF 12345678909, atendida em 22/07/2026 na UBS CNES 2337545. Diagnóstico: J06.9 (CID-10). Procedimento: 0301010030 (Tabela SUS). Prescrição: salbutamol xarope, via bucal. Observações: peso 72,5 kg; altura 175 cm. Alergia: dipirona (confirmada, criticidade alta — urticária). Plano de cuidados: hidratação, repouso e retorno em 7 dias.</p></div>"""
* status = #final
* type.coding = $tipo-doc#RAC
* category.coding = $modalidade#01
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* date = "2026-07-22T09:45:00-03:00"
* author.identifier.system = $id-estabelecimento
* author.identifier.value = "2337545"
* title = "Registro de Atendimento Clínico"
* section[informacoesContatoAssistencial].entry.reference = "urn:uuid:9d0e1f30-4a5b-4c6d-8e7f-3b4c5d6e7f80"
* section[problemasDiagnosticosAvaliados].entry.reference = "urn:uuid:5b6f3a10-2c1e-4a7b-9a44-1f2ab3c4d5e6"
* section[procedimentosRealizados].entry.reference = "urn:uuid:7c8d9e20-3f4a-4b5c-8d6e-2a3b4c5d6e7f"
* section[prescricao].entry.reference = "urn:uuid:2e3f4a50-6b7c-4d8e-9fa0-5c6d7e8f90a2"
// observacoes: seção repetível com 1 entry cada (0..* seções, entry 1..1)
* section[observacoes][0].entry.reference = "urn:uuid:8b9c0da0-1e2f-4a3b-8c4d-e5f60718293a"
* section[observacoes][1].entry.reference = "urn:uuid:9c0d1eb0-2f3a-4b4c-9d5e-f60718293a4b"
// alergiaReacaoAdversa: o perfil permite N entries (0..*), mas o discriminador
// entry.resolve() não casa seções multi-entry — 1 alergia por seção
* section[alergiaReacaoAdversa].entry.reference = "urn:uuid:5f6a7b80-9c0d-4e1f-a2b3-c4d5e6f708a9"
// planoCuidados: 0..1, entry 1..1
* section[planoCuidados].entry.reference = "urn:uuid:a1b2c3d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d"

Instance: RacContatoAssistencial
InstanceOf: BRContatoAssistencial-1.0
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p>Contato assistencial finalizado, atenção básica, demanda espontânea, 22/07/2026 09:00–09:40. Paciente CPF 12345678909, profissional lotado (CNS 898001160660034, CNES 2337545), UBS CNES 2337545. Motivo: dor de garganta e coriza há 3 dias. Local: Consultório 3. Desfecho: alta clínica.</p></div>"""
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
* diagnosis[problemAndDiagnosis].condition.reference = "urn:uuid:5b6f3a10-2c1e-4a7b-9a44-1f2ab3c4d5e6"
* diagnosis[problemAndDiagnosis].use.coding = $diag-role#AD
* diagnosis[procedure].condition.reference = "urn:uuid:7c8d9e20-3f4a-4b5c-8d6e-2a3b4c5d6e7f"
* diagnosis[procedure].condition.extension[financier].valueCodeableConcept.coding = $financiamento#01
* hospitalization.admitSource.coding = $procedencia#09
* hospitalization.dischargeDisposition.coding = $desfecho#01
* serviceProvider.identifier.system = $id-estabelecimento
* serviceProvider.identifier.value = "2337545"
// Referências REAIS (reference 1..1) — destravadas no package 0.5.0:
* reasonReference.reference = "urn:uuid:b2c3d4e5-6f7a-4b8c-9d0e-1f2a3b4c5d6e"
* location.location.reference = "urn:uuid:c3d4e5f6-7a8b-4c9d-a0e1-2f3a4b5c6d7e"

Instance: RacProblemaDiagnostico
InstanceOf: BRProblemaDiagnostico
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p>Diagnóstico ativo: J06.9 — Infecção aguda das vias aéreas superiores, não especificada (CID-10). Paciente CPF 12345678909.</p></div>"""
* clinicalStatus.coding = $cond-clinical#active
* code.coding = $cid10#J069
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"

Instance: RacProcedimentoRealizado
InstanceOf: BRProcedimentoRealizado-1.0
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p>Procedimento concluído em 22/07/2026: 0301010030 — consulta de profissional de nível superior na atenção primária (Tabela SUS), quantidade 1. Paciente CPF 12345678909.</p></div>"""
* extension[quantity].valuePositiveInt = 1
* status = #completed
* code.coding = $tabela-sus#0301010030
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* performedDateTime = "2026-07-22T09:30:00-03:00"
* performer[practitioner].extension[healthcareTeam].valueInteger = 1234567
* performer[practitioner].function.coding = $cbo#225103
* performer[practitioner].actor.identifier.system = $id-lotacao
* performer[practitioner].actor.identifier.value = "898001160660034-2337545"
* performer[practitioner].onBehalfOf.identifier.system = $id-estabelecimento
* performer[practitioner].onBehalfOf.identifier.value = "2337545"

Instance: RacPrescricaoComposicao
InstanceOf: BRRegistroPrescricaoMedicamento
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Registro de Prescrição de Medicamento</b> — paciente CPF 12345678909, prescrito em 22/07/2026 pela UBS CNES 2337545: salbutamol sulfato 0,4 mg/ml xarope, via bucal.</p></div>"""
* status = #final
* type.coding = $tipo-doc#RPM
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* date = "2026-07-22T09:40:00-03:00"
* author.identifier.system = $id-estabelecimento
* author.identifier.value = "2337545"
* title = "Registro de Prescrição de Medicamento"
* section.entry.reference = "urn:uuid:3f4a5b60-7c8d-4e9f-a0b1-6d7e8f90a1b3"

Instance: RacPrescricaoMedicamento
InstanceOf: BRPrescricaoMedicamento
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p>Prescrição ativa: salbutamol sulfato 0,4 mg/ml xarope, via bucal, 10 ml por administração, 3 administrações, validade 22/07/2026–29/07/2026, dispensar 1 frasco. Paciente CPF 12345678909.</p></div>"""
* status = #active
* intent = #order
* medicationReference.reference = "urn:uuid:4a5b6c70-8d9e-4fa0-b1c2-7e8f90a1b2c4"
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* authoredOn = "2026-07-22T09:40:00-03:00"
* requester.identifier.system = $id-lotacao
* requester.identifier.value = "898001160660034-2337545"
* recorder.identifier.system = $id-lotacao
* recorder.identifier.value = "898001160660034-2337545"
* dosageInstruction.timing.repeat.count = 3
* dosageInstruction.timing.repeat.countMax = 3
* dosageInstruction.route.coding = $via-adm#10863
* dosageInstruction.doseAndRate.type.coding = $unidade#48
* dosageInstruction.doseAndRate.doseQuantity.value = 10
* dosageInstruction.maxDosePerAdministration.value = 10
* dispenseRequest.validityPeriod.start = "2026-07-22T00:00:00-03:00"
* dispenseRequest.validityPeriod.end = "2026-07-29T23:59:59-03:00"
* dispenseRequest.quantity.value = 1

Instance: RacMedicamento
InstanceOf: BRMedicamento
Usage: #inline
* code.coding = $medicamento#BR0292331-2
* form.coding = $unidade#31

// ---------- Observações (BRMedidaObservada) ----------
// O perfil PROÍBE performer (..0): o warning de best practice
// "observations should have a performer" é inevitável — trade-off
// de modelagem, como o dom-6 do Medication.

Instance: RacObservacaoPeso
InstanceOf: BRMedidaObservada
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Peso</b>: 72,5 kg, aferido no atendimento.</p></div>"""
* status = #final
* code.coding = $tipo-obs#P
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* effectiveTiming.event = "2026-07-22T09:45:00-03:00"
* valueQuantity.value = 72.5
* valueQuantity.unit = "kg"
* valueQuantity.system = $ucum
* valueQuantity.code = #kg

Instance: RacObservacaoAltura
InstanceOf: BRMedidaObservada
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Altura</b>: 175 cm, aferida no atendimento.</p></div>"""
* status = #final
* code.coding = $tipo-obs#A
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* effectiveTiming.event = "2026-07-22T09:45:00-03:00"
* valueQuantity.value = 175
* valueQuantity.unit = "cm"
* valueQuantity.system = $ucum
* valueQuantity.code = #cm

// ---------- Alergia (BRAlergiaReacaoAdversa-1.0) ----------
// Caso completo: confirmada, criticidade alta, reação MedDRA, onset.

Instance: RacAlergiaDipirona
InstanceOf: BRAlergiaReacaoAdversa-1.0
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Alergia a medicamento</b>: dipirona sódica 500 mg comprimido — confirmada, criticidade alta. Reação prévia: urticária. Início: 15/03/2020.</p></div>"""
* clinicalStatus.coding = $alergia-clinical#active
* verificationStatus.coding = $alergia-verif#confirmed
* type = #allergy
* category = #medication
* criticality = #high
* code.coding = $medicamento#BR0267203U0042
* patient.identifier.system = $id-individuo
* patient.identifier.value = "12345678909"
* onsetDateTime = "2020-03-15"
* reaction.manifestation.coding = $meddra#10046735


// ---------- Plano de cuidados (BRPlanoCuidados-1.0) ----------

Instance: RacPlanoCuidados
InstanceOf: BRPlanoCuidados-1.0
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Plano de cuidados</b>: hidratação oral, repouso relativo, antitérmico se febre; retorno em 7 dias para reavaliação.</p></div>"""
* status = #active
* intent = #plan
* description = "Hidratação oral, repouso relativo, antitérmico se febre. Retorno em 7 dias para reavaliação."
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"

// ---------- Motivo do contato (BRObservacaoDescritiva-1.0) ----------
// code FIXO (LOINC 48767-8 "Annotation comment"), issued obrigatório,
// value[x] restrito a string; perfil proíbe performer E effective[x]
// (2 warnings de best practice inevitáveis).

Instance: RacMotivoContato
InstanceOf: BRObservacaoDescritiva-1.0
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Motivo do contato</b>: dor de garganta e coriza há 3 dias.</p></div>"""
* status = #final
* code.coding = $loinc#48767-8
* subject.type = "Patient"
* subject.identifier.system = $id-individuo
* subject.identifier.value = "12345678909"
* issued = "2026-07-22T09:45:00-03:00"
* valueString = "Paciente refere dor de garganta e coriza há 3 dias, sem febre aferida em casa."

// ---------- Local do atendimento (BRLocalAtendimento-1.0) ----------
// status e mode FIXOS (active/kind); referenciado por Encounter.location.

Instance: RacLocalAtendimento
InstanceOf: BRLocalAtendimento-1.0
Usage: #inline
* text.status = #generated
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml"><p><b>Local do atendimento</b>: Consultório 3 da UBS.</p></div>"""
* status = #active
* name = "Consultório 3"
* mode = #kind
