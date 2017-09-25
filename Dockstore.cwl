#!/usr/bin/env cwl-runner
class: Workflow

cwlVersion: v1.0

dct:creator:
    foaf:name: "testAuthor"
    foaf:mbox: "testEmail"

requirements:
  - class: ScatterFeatureRequirement
  - class: DockerRequirement
    dockerPull: "debian:8"
inputs:
  - id: "#pattern"
    type: string
  - id: "#infile"
    type: {type: array, items: File}
outputs:
  - id: "#outfile"
    type: File
    source: "#wc.outfile"
steps:
  - id: "#grep"
    run: {import: grep.cwl}
    scatter: "#grep.infile"
    inputs:
      - id: "#grep.pattern"
        source: "#pattern"
      - id: "#grep.infile"
        source: "#infile"
    outputs:
      - id: "#grep.outfile"

  - id: "#wc"
    run: {import: wc.cwl}
    inputs:
      - id: "#wc.infile"
        source: "#grep.outfile"
    outputs:
      - id: "#wc.outfile"
