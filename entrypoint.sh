#!/bin/sh -l

export PATH="$PATH:/github/home/.dotnet/tools"
dotnet tool install -g dotnet-stryker

dotnet tool restore

cd *.Test/

dotnet stryker --reporters "['json']" > mutation-result.txt
ls
VAR1="The final mutation score is 100.00 %"

while read p; do
  echo "$p"
  if [[ $p == *"$VAR1"* ]]; then
    echo "SUCESSO"
    exit 0
  else
    echo "FALHA"
    exit 1
  fi
done < mutation-result.txt
