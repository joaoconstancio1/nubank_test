#!/bin/bash

# Executa os testes do Flutter com cobertura e gera o arquivo lcov.info
flutter test --coverage

# Verifica se o comando flutter test foi executado com sucesso
if [ $? -eq 0 ]; then
  echo "Testes executados com sucesso. Gerando relatório HTML..."

  # Gera o relatório HTML a partir do lcov.info
  genhtml coverage/lcov.info -o coverage/html

  # Verifica se o arquivo index.html foi gerado
  if [ -f "coverage/html/index.html" ]; then
    echo "Relatório HTML gerado com sucesso: coverage/html/index.html"

    # Abre o arquivo index.html no navegador padrão com base no sistema operacional
    case "$(uname -s)" in
      Linux*)     xdg-open coverage/html/index.html ;;
      Darwin*)    open coverage/html/index.html ;;
      CYGWIN*|MINGW*|MSYS*) start coverage/html/index.html ;;
      *)          echo "Sistema operacional não suportado para abrir o navegador automaticamente." ;;
    esac

    if [ $? -eq 0 ]; then
      echo "Relatório HTML aberto no navegador."
    else
      echo "Erro ao abrir o relatório HTML no navegador. Abra manualmente: coverage/html/index.html"
    fi
  else
    echo "Erro: Arquivo coverage/html/index.html não foi gerado."
    exit 1
  fi
else
  echo "Erro ao executar os testes."
  exit 1
fi