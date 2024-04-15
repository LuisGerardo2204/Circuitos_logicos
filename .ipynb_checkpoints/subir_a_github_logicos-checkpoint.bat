 cp -r milibro/* circuitos_logicos 
cd circuitos_logicos
git add ./*
git commit -m "Subiendo a GitHub"
git push
ghp-import -n -p -f _build/html
cd ..