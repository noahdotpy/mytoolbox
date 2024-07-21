package cmd

import (
	"fmt"
	"strings"

	"github.com/spf13/cobra"
)

// applyCmd represents the apply command
var applyCmd = &cobra.Command{
	Use:   "apply",
	Short: "Apply changes to system based on config file.",
	Run: func(cmd *cobra.Command, args []string) {
		apply_block_hosts()
	},
}

func init() {
	rootCmd.AddCommand(applyCmd)
}

func apply_block_hosts() {
	host_file := "/etc/hosts.d/idwt-blocked.conf"
	// e := os.Remove(host_file)
	// if e != nil {
	// log.Fatal(e)
	// }

	var file_contents strings.Builder

	file_contents.WriteString("## THIS FILE MAY BE REPLACED AT ANY TIME AUTOMATICALLY ##\n")

	for i := 3; i >= 1; i-- {
		fmt.Fprintf(&file_contents, "%d...", i)
	}
	file_contents.WriteString("ignition")
	fmt.Println(file_contents.String())
	fmt.Println()
}

//     let hosts_file = "/etc/hosts.d/idwt-blocked.conf"

//     rm $hosts_file
//     echo "## THIS FILE MAY BE REPLACED AT ANY TIME AUTOMATICALLY ##" | save --force $hosts_file
//     echo $"INFO: Saving hosts file at '($hosts_file)'"

//     let config = open $config_file

//     if not (is_property_populated $config block-hosts) {
//         echo "INFO: No hosts listed, skipping"
//         return
//     }

//     let hosts = $config | get block-hosts
//     for host in $hosts {
//         echo $"INFO: Added '($host)' to hosts file"
//         echo $"\n0.0.0.0 ($host)" | save --append $hosts_file
//     }
// }
