# Etapas — o RAC ampliado em JSON, um recurso por arquivo

Os 18 recursos do **bundle ampliado** (o "exemplo ainda mais completo" de
[input/fsh/rac-ampliado.fsh](../input/fsh/rac-ampliado.fsh)) extraídos um a um,
em ordem de montagem, mais o Bundle final — cada etapa em um arquivo, cada
arquivo validável isoladamente.

| # | Arquivo | Recurso | Resultado esperado |
|---|---|---|---|
| 01 | [etapa-01-encounter.json](etapa-01-encounter.json) | Encounter — contato assistencial (2 diagnósticos, 2 procedimentos) | `0 errors, 0 warnings` |
| 02 | [etapa-02-condition-ivas.json](etapa-02-condition-ivas.json) | Condition — IVAS J06.9 (diagnóstico do atendimento) | `0 errors, 0 warnings` |
| 03 | [etapa-03-condition-asma.json](etapa-03-condition-asma.json) | Condition — asma J45.9 (comorbidade) | `0 errors, 0 warnings` |
| 04 | [etapa-04-procedure-consulta.json](etapa-04-procedure-consulta.json) | Procedure — consulta APS 0301010030 | `0 errors, 0 warnings` |
| 05 | [etapa-05-procedure-afericao-pa.json](etapa-05-procedure-afericao-pa.json) | Procedure — aferição de PA 0301100039 | `0 errors, 0 warnings` |
| 06 | [etapa-06-composition-prescricao.json](etapa-06-composition-prescricao.json) | Composition RPM — 1 seção, 2 entries (`1..*`) | `0 errors, 0 warnings` |
| 07 | [etapa-07-medicationrequest-salbutamol.json](etapa-07-medicationrequest-salbutamol.json) | MedicationRequest — salbutamol (via bucal) | `0 errors, 0 warnings` |
| 08 | [etapa-08-medication-salbutamol.json](etapa-08-medication-salbutamol.json) | Medication — salbutamol | `0 errors, 1 warning` (dom-6)¹ |
| 09 | [etapa-09-medicationrequest-paracetamol.json](etapa-09-medicationrequest-paracetamol.json) | MedicationRequest — paracetamol (via oral) | `0 errors, 0 warnings` |
| 10 | [etapa-10-medication-paracetamol.json](etapa-10-medication-paracetamol.json) | Medication — paracetamol | `0 errors, 1 warning` (dom-6)¹ |
| 11 | [etapa-11-observation-peso.json](etapa-11-observation-peso.json) | Observation — peso 72,5 kg | `0 errors, 1 warning` (performer)² |
| 12 | [etapa-12-observation-altura.json](etapa-12-observation-altura.json) | Observation — altura 175 cm | `0 errors, 1 warning` (performer)² |
| 13 | [etapa-13-observation-circ-abdominal.json](etapa-13-observation-circ-abdominal.json) | Observation — circunferência abdominal 89 cm | `0 errors, 1 warning` (performer)² |
| 14 | [etapa-14-allergyintolerance-dipirona.json](etapa-14-allergyintolerance-dipirona.json) | AllergyIntolerance — dipirona (medicamento, alta criticidade) | `0 errors, 0 warnings` |
| 15 | [etapa-15-allergyintolerance-amendoim.json](etapa-15-allergyintolerance-amendoim.json) | AllergyIntolerance — amendoim (alimento, CBARA) | `0 errors, 0 warnings` |
| 16 | [etapa-16-careplan-plano-cuidados.json](etapa-16-careplan-plano-cuidados.json) | CarePlan — plano de cuidados | `0 errors, 0 warnings` |
| 17 | [etapa-17-observation-motivo-contato.json](etapa-17-observation-motivo-contato.json) | Observation — motivo do contato (descritiva, LOINC fixo) | `0 errors, 2 warnings` (performer + effective)² |
| 18 | [etapa-18-location-local-atendimento.json](etapa-18-location-local-atendimento.json) | Location — Consultório 3 | `0 errors, 0 warnings` |
| 19 | [etapa-19-rac-bundle-ampliado.json](etapa-19-rac-bundle-ampliado.json) | **Bundle document final** — Composition RAC + os 18 recursos | `0 errors, 10 warnings`³ |

¹ o perfil BRMedicamento **proíbe** narrativa (`text ..0`) — o aviso de best
practice dom-6 é inevitável.
² os perfis de Observation **proíbem** `performer` (e o de observação descritiva
também `effective[x]`) — mesmos trade-offs de modelagem.
³ os 10 avisos do bundle = os avisos acima somados aos 2 bindings `extensible`
da base HL7 no Encounter e ao NamingSystem `BRRNDS-*` do solicitante.

A Composition do RAC (1ª entry) não tem arquivo próprio: um document Composition
só faz sentido **dentro** do Bundle — é a costura das 19 etapas.

## Como validar

Da **raiz do repositório** (exige `recursos/validador/validator_cli.jar` — se
faltar, rode `./baixar-validador.sh`):

```bash
# uma etapa por vez (troque o arquivo):
java -jar recursos/validador/validator_cli.jar \
     etapas/etapa-01-encounter.json \
     -version 4.0.1 -ig recursos/rnds-lite-0.5.0.tgz

# ou todas de uma vez:
java -jar recursos/validador/validator_cli.jar \
     etapas/etapa-*.json \
     -version 4.0.1 -ig recursos/rnds-lite-0.5.0.tgz
```

## Roteiro sugerido para a demonstração

1. Abrir a etapa 01 e mostrar as **referências lógicas** (CPF/CNES/CNS via
   `identifier.system` apontando para o StructureDefinition) — Patient,
   Practitioner e Organization não entram no Bundle.
2. Validar as etapas na ordem, uma a uma ("regra do bloco": só avança quem valida).
3. Nas etapas 08/10, perguntar por que o Medication não tem `id` nem `text`
   (o perfil limita com `..0`) — e por que o aviso dom-6 é aceitável.
4. Na etapa 06, mostrar a seção do RPM com **2 entries** (`entry 1..*`): dois
   medicamentos na mesma prescrição.
5. Validar a etapa 19 e conferir os 10 avisos com a turma.
6. Fechar comparando com o fluxo FSH da raiz (`./demonstrar.sh`): o
   `fsh-generated/.../Bundle-rac-bundle-ampliado.json` é este mesmo documento,
   gerado a partir do código-fonte FSH.
