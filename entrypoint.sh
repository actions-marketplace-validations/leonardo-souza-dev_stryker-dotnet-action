#!/bin/bash

export PATH="$PATH:/github/home/.dotnet/tools"
dotnet tool install -g dotnet-stryker

dotnet tool restore

cd *.Test/

dotnet stryker --reporters "['json']" > mutation-result.txt

VAR1="The final mutation score is 100.00 %"

cat mutation-result.txt

result=1

while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ $line == *"$VAR1"* ]]; then
    result=0
    echo "SUCESSO, NAO RESTOU NENHUM MUTANTE"
    exit 0
  else
    result=1
  fi
done < mutation-result.txt

if [[ $result == 1 ]]; then
    echo "AINDA RESTAM MUTANTES VIVOS"
  exit 1
fi
