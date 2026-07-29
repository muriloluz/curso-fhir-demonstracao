// ============================================================
// O malote lacrado: Bundle type=document que reúne os 13
// recursos inline. Os fullUrl (urn:uuid) são a identidade de
// cada entry e o alvo das referências internas.
// ============================================================

Instance: rac-bundle-completo
InstanceOf: Bundle
Usage: #example
Title: "RAC — Bundle document completo"
Description: "Registro de Atendimento Clínico completo: Composition RAC + contato assistencial + diagnóstico + procedimento + cadeia de prescrição (RPM → MedicationRequest → Medication) + 2 observações (peso/altura) + alergia a medicamento (dipirona) + plano de cuidados + motivo do contato e local (referências reais do Encounter)."
// Padrão real da RNDS: NamingSystem do solicitante (fictício) + valor <CNES>-<uuid>
* identifier.system = "http://www.saude.gov.br/fhir/r4/NamingSystem/BRRNDS-99999"
* identifier.value = "2337545-0c3151bd-1cbf-4d64-b04d-cd9187a4c6e0"
* type = #document
* timestamp = "2026-07-22T09:45:00-03:00"
* entry[0].fullUrl = "urn:uuid:1a2b3c40-5d6e-4f70-8a9b-4c5d6e7f8091"
* entry[0].resource = RacComposicao
* entry[1].fullUrl = "urn:uuid:9d0e1f30-4a5b-4c6d-8e7f-3b4c5d6e7f80"
* entry[1].resource = RacContatoAssistencial
* entry[2].fullUrl = "urn:uuid:5b6f3a10-2c1e-4a7b-9a44-1f2ab3c4d5e6"
* entry[2].resource = RacProblemaDiagnostico
* entry[3].fullUrl = "urn:uuid:7c8d9e20-3f4a-4b5c-8d6e-2a3b4c5d6e7f"
* entry[3].resource = RacProcedimentoRealizado
* entry[4].fullUrl = "urn:uuid:2e3f4a50-6b7c-4d8e-9fa0-5c6d7e8f90a2"
* entry[4].resource = RacPrescricaoComposicao
* entry[5].fullUrl = "urn:uuid:3f4a5b60-7c8d-4e9f-a0b1-6d7e8f90a1b3"
* entry[5].resource = RacPrescricaoMedicamento
* entry[6].fullUrl = "urn:uuid:4a5b6c70-8d9e-4fa0-b1c2-7e8f90a1b2c4"
* entry[6].resource = RacMedicamento
* entry[7].fullUrl = "urn:uuid:8b9c0da0-1e2f-4a3b-8c4d-e5f60718293a"
* entry[7].resource = RacObservacaoPeso
* entry[8].fullUrl = "urn:uuid:9c0d1eb0-2f3a-4b4c-9d5e-f60718293a4b"
* entry[8].resource = RacObservacaoAltura
* entry[9].fullUrl = "urn:uuid:5f6a7b80-9c0d-4e1f-a2b3-c4d5e6f708a9"
* entry[9].resource = RacAlergiaDipirona
* entry[10].fullUrl = "urn:uuid:a1b2c3d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d"
* entry[10].resource = RacPlanoCuidados
* entry[11].fullUrl = "urn:uuid:b2c3d4e5-6f7a-4b8c-9d0e-1f2a3b4c5d6e"
* entry[11].resource = RacMotivoContato
* entry[12].fullUrl = "urn:uuid:c3d4e5f6-7a8b-4c9d-a0e1-2f3a4b5c6d7e"
* entry[12].resource = RacLocalAtendimento