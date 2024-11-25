export project_root := `git rev-parse --show-toplevel`

_default:
    @just --list --list-heading $'Available commands:\n' --list-prefix $' - '

# Check just Syntax
just-check:
    #!/usr/bin/bash
    find "${project_root}" -type f -name "*.just" | while read -r file; do
    	echo "Checking syntax: $file"
    	just --unstable --fmt --check -f $file 
    done
    echo "Checking syntax: ${project_root}/justfile"
    just --unstable --fmt --check -f ${project_root}/justfile

# Fix just Syntax
just-fix:
    #!/usr/bin/bash
    find "${project_root}" -type f -name "*.just" | while read -r file; do
    	echo "Checking syntax: $file"
    	just --unstable --fmt -f $file
    done
    echo "Checking syntax: ${project_root}/justfile"
    just --unstable --fmt -f ${project_root}/justfile || { exit 1; }

get-recipe ref:
    #!/usr/bin/env nu
    # ref = image:tag
    
    let ref = '{{ ref }}'
    let image = $ref | split row ':' | get 0
    let tag = $ref | split row ':' | get 1
    let channel = $tag | split row '-' | get 0

    let recipe = $"{{ project_root }}/recipes/images/($image)/($channel)/($image)--($tag).yml"

    print $recipe

# Build local image from recipe
build ref:
    #!/usr/bin/env nu
    
    bluebuild build (just get-recipe {{ ref }})

# Create ISO from ghcr image
build-iso-ghcr ref output="__auto":
    #!/usr/bin/env nu

    let name = '{{ ref }}' | split row ':' | get 0
    let tag = '{{ ref }}' | split row ':' | get 1

    let output = '{{ output }}'

    {{ project_root }}/just_scripts/build-iso-ghcr.sh $name $tag $output
