def "is_property_defined" [
    record: record,
    property: cell-path,
] {
    return (not ($record | columns | where $it == $property | is-empty))
}

def "is_property_populated" [
    record: record
    property: cell-path,
] {
    if not (is_property_defined $record $property) {
        return false
    }
    return (not ($record | get $property | is-empty))
}

def main [
    --recipe: string,
    --module-directory: string
    --config-directory: string
] {
    let recipe = echo $recipe | from json
    
    let recipe = $recipe | default false disable-service

    cp $"($module_directory)/chezfiles/files/chezfiles-apply" /usr/bin/chezfiles-apply
    cp -r $"($module_directory)/chezfiles/files/system/"* /usr/lib/systemd/system/
    cp -r $"($module_directory)/chezfiles/files/user/"* /usr/lib/systemd/user/

    if ($recipe | get disable-service) {
        systemctl disable --user chezfiles-apply.path
        systemctl disable --system chezfiles-apply.path
        systemctl disable --user chezfiles-apply.service
        systemctl disable --system chezfiles-apply.service
    } else {
        systemctl enable --user chezfiles-apply.path
        systemctl enable --system chezfiles-apply.path
        systemctl enable --user chezfiles-apply.service
        systemctl enable --system chezfiles-apply.service
    }

    mkdir /usr/share/bluebuild/homefiles/

    if (is_property_populated $recipe build) {
        echo "Adding build files to image"
        for entry in ($recipe | get build) {
            chezmoi apply --destination / --source $"($config_directory)/chezfiles/($entry)"
        }
    } else {
        echo "There are no directories added in build"
    }

    if (is_property_populated $recipe system) {
        echo "Adding system files to image"
        for entry in ($recipe | get system) {
            cp -r $"($config_directory)/chezfiles/($entry)" $"/usr/share/bluebuild/chezfiles/system/($entry)"
            chezmoi apply --destination / --source $"/usr/share/bluebuild/chezfiles/system/($entry)" --force
        }
    } else {
        echo "There are no directories added in system"
    }

    if (is_property_populated $recipe user) {
        echo "Adding user files to image"
        for entry in ($recipe | get user) {
            cp -r $"($config_directory)/chezfiles/($entry)" $"/usr/share/bluebuild/chezfiles/user/($entry)"
            chezmoi apply --destination /usr/etc/skel/ --source $"/usr/share/bluebuild/chezfiles/user/($entry)" --force
        }
    } else {
        echo "There are no directories added in user"
    }
}