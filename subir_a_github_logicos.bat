 cp -r milibro/* Circuitos_logicos 
cd Circuitos_logicos
git add ./*
git commit -m "Subiendo a GitHub"
git push
ghp-import -n -p -f _build/html
cd ..