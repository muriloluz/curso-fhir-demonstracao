# Demonstração — RAC: de FSH a JSON validado

Gabarito pronto do RAC (Registro de Atendimento Clínico) em FHIR Shorthand.
Fluxo único da demonstração: **compilar o FSH → JSON** com o SUSHI e
**validar o JSON** com o validador oficial HL7 contra o IG rnds-lite.

## Pré-requisitos

- Node.js 20+ com SUSHI (`npm install -g fsh-sushi`)
- Java 21+
- `recursos/validador/validator_cli.jar` (se faltar: `./baixar-validador.sh`)

## Executar

```bash
./demonstrar.sh
```

O script faz as três etapas (idempotente — pode rodar quantas vezes quiser):

1. instala `br.ufg.cgis.rnds-lite#0.5.0` no cache do SUSHI (`~/.fhir/packages`), se necessário;
2. `sushi .` → gera os dois bundles em `fsh-generated/resources/`
   (`Bundle-rac-bundle-completo.json` e `Bundle-rac-bundle-ampliado.json`);
3. valida os dois JSONs com o validador oficial contra o IG rnds-lite.

Ou rode os passos à mão:

```bash
sushi .
java -jar recursos/validador/validator_cli.jar \
     fsh-generated/resources/Bundle-rac-bundle-completo.json \
     -version 4.0.1 -ig recursos/rnds-lite-0.5.0.tgz
```

## Resultado esperado

- SUSHI: `0 Errors`
- Bundle completo: `Success: 0 errors, 8 warnings` — avisos esperados
  (bindings `preferred`/exemplo e afins do próprio IG; nenhum é problema do Bundle).
- Bundle ampliado: `Success: 0 errors, 10 warnings` — os mesmos avisos,
  +1 `dom-6` (2º Medication sem narrativa, proibida pelo perfil) e
  +1 `performer` (3ª Observation, proibido pelo perfil).

## O que tem aqui

| Arquivo | Conteúdo |
|---|---|
| [sushi-config.yaml](sushi-config.yaml) | projeto SUSHI; dependência `br.ufg.cgis.rnds-lite 0.5.0` |
| [input/fsh/aliases.fsh](input/fsh/aliases.fsh) | apelidos dos CodeSystems/NamingSystems usados |
| [input/fsh/rac-recursos.fsh](input/fsh/rac-recursos.fsh) | os 12 recursos do RAC como Instances `Usage: #inline` |
| [input/fsh/rac-bundle.fsh](input/fsh/rac-bundle.fsh) | o Bundle document: fullUrls `urn:uuid` + `entry[N].resource` |
| [input/fsh/rac-ampliado.fsh](input/fsh/rac-ampliado.fsh) | o exemplo **ainda mais completo**: 2 diagnósticos, 2 procedimentos, 2 medicamentos no mesmo RPM, 3 observações, 2 alergias — os padrões de repetição dos perfis |
| recursos/rnds-lite-0.5.0.tgz | package do IG (usado pelo SUSHI e pelo validador) |
| recursos/validador/validator_cli.jar | validador oficial HL7 |
| [etapas/](etapas/README.md) | o RAC ampliado em JSON, um recurso por arquivo (etapas 01–19), com instruções e resultado esperado de validação por arquivo |

## Pontos para narrar na demonstração

- `InstanceOf: BRRegistroAtendimentoClinico` → o SUSHI conhece o perfil e valida
  cardinalidade/slices **no build**, antes do validador.
- Slices endereçados por nome (`section[prescricao]`, `diagnosis[problemAndDiagnosis]`,
  `extension[financier]`) — sem contar índice de array.
- `Usage: #inline` + `entry[N].resource = NomeDaInstance`: recurso embutido no Bundle.
- O validador é o portão final: terminologia (CID-10, SIGTAP, CBO...) e invariantes
  que o SUSHI não cobre.
- No **rac-ampliado**: como os perfis repetem — seções `1..*`/`0..*` com `entry 1..1`
  repetem a **seção** (diagnósticos, procedimentos, observações, alergias); a seção
  do RPM (`entry 1..*`) recebe as duas prescrições; e as Instances são reaproveitadas
  pelos dois bundles — mesmo tijolo, dois documentos.
