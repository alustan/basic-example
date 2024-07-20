#!/bin/sh
TOKEN=$(kubectl create token terraform-sa -n alustan)
echo "{\"token\": \"$TOKEN\"}"
