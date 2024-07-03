export project_root := `git rev-parse --show-toplevel`

_default:
    @just --list --list-heading $'Available commands:\n' --list-prefix $' - '

# Check Just Syntax
just-check:
    #!/usr/bin/bash
    find "${project_root}" -type f -name "*.just" | while read -r file; do
    	echo "Checking syntax: $file"
    	just --unstable --fmt --check -f $file 
    done
    echo "Checking syntax: ${project_root}/justfile"
    just --unstable --fmt --check -f ${project_root}/justfile

# Fix Just Syntax
just-fix:
    #!/usr/bin/bash
    find "${project_root}" -type f -name "*.just" | while read -r file; do
    	echo "Checking syntax: $file"
    	just --unstable --fmt -f $file
    done
    echo "Checking syntax: ${project_root}/justfile"
    just --unstable --fmt -f ${project_root}/justfile || { exit 1; }

# Create ISO from ghcr image
build-iso-ghcr image="" tag="latest":
    @{{ project_root }}/scripts/build-iso-ghcr.sh {{ image }} {{ tag }}
