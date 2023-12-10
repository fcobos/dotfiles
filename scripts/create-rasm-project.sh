#!/usr/bin/env sh

proj_name=$@

cp -r ~/dotfiles/scripts/rasm_project_template ./$proj_name
(
    cd $proj_name || exit
    find . -type f -not -path '*/\.*' -print0 | xargs -0 sed -i '' -e "s/PROJECT_NAME/$proj_name/g"
)
