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
build-iso-ghcr image="" tag="":
    #!/usr/bin/bash
    if [ "{{ image }}" = "" ]; then
      images=$(fd --base-directory recipes/ -d 1 | grep .yml | sed 's/\.yml$//' | xargs)
      chosen_image=$(ugum choose $(echo $images) --header "Choose image name")
    else
      chosen_image={{ image }}
    fi

    if [ "{{ tag }}" = "" ]; then
      want_to_custom_tag=$(ugum choose "latest" "other" --header "Choose image tag:")
      if [ "$want_to_custom_tag" = "other" ]; then
        chosen_tag=$(ugum input)
      else
        chosen_tag="latest"
      fi
    else
      chosen_tag={{ tag }}
    fi
    {{ project_root }}/scripts/build-iso-ghcr.sh $chosen_image $chosen_tag
