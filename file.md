It is needed  by the replace-placeholder.sh  due to next.js inline embedding of variables to avoid multiple docker image build for each environment. 

- The script reads each line from the placeholder.yml file, splits it into a key and a value based on the colon (:) delimiter, and trims any leading or trailing whitespace from the key and value.

- For each key-value pair from the placeholder.yml file, the script iterates over all environment variables (could be docker compose env variable or even env variable in kubernetes manifest)to find a match. If a match is found and the environment variable has a non-empty value, the script uses sed to replace the placeholder value in the .next folder with the environment variable value. It excludes .git directories from this operation.

SO basically the `keys` in placeholder.yaml are used to check for similar entries in env variable
while the `values` in placeholder.yaml are used to check for actual strings that need replacement in .next folder

this is the best I could come up with as at the time to enable reusable single docker build