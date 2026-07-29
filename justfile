set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

build_dir := "build/handouts/ai-glossary"
source_file := "handouts/ai-glossary/ai-glossary.typ"

default: build

build: build-ai-glossary

build-ai-glossary:
    mkdir -p "{{build_dir}}"
    typst compile "{{source_file}}" "{{build_dir}}/ai-glossary.pdf"