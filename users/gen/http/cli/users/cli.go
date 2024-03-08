// Code generated by goa v3.14.0, DO NOT EDIT.
//
// users HTTP client CLI support package
//
// Command:
// $ goa gen users/design

package cli

import (
	"flag"
	"fmt"
	"net/http"
	"os"
	usersc "users/gen/http/users/client"

	goahttp "goa.design/goa/v3/http"
	goa "goa.design/goa/v3/pkg"
)

// UsageCommands returns the set of commands and sub-commands using the format
//
//	command (subcommand1|subcommand2|...)
func UsageCommands() string {
	return `users (create-user|delete-user|find-user-by-id|update-username|update-bio)
`
}

// UsageExamples produces an example of a valid invocation of the CLI tool.
func UsageExamples() string {
	return os.Args[0] + ` users create-user --body '{
      "username": "Laudantium eum velit qui."
   }'` + "\n" +
		""
}

// ParseEndpoint returns the endpoint and payload as specified on the command
// line.
func ParseEndpoint(
	scheme, host string,
	doer goahttp.Doer,
	enc func(*http.Request) goahttp.Encoder,
	dec func(*http.Response) goahttp.Decoder,
	restore bool,
) (goa.Endpoint, any, error) {
	var (
		usersFlags = flag.NewFlagSet("users", flag.ContinueOnError)

		usersCreateUserFlags    = flag.NewFlagSet("create-user", flag.ExitOnError)
		usersCreateUserBodyFlag = usersCreateUserFlags.String("body", "REQUIRED", "")

		usersDeleteUserFlags    = flag.NewFlagSet("delete-user", flag.ExitOnError)
		usersDeleteUserBodyFlag = usersDeleteUserFlags.String("body", "REQUIRED", "")

		usersFindUserByIDFlags  = flag.NewFlagSet("find-user-by-id", flag.ExitOnError)
		usersFindUserByIDIDFlag = usersFindUserByIDFlags.String("id", "REQUIRED", "")

		usersUpdateUsernameFlags    = flag.NewFlagSet("update-username", flag.ExitOnError)
		usersUpdateUsernameBodyFlag = usersUpdateUsernameFlags.String("body", "REQUIRED", "")
		usersUpdateUsernameIDFlag   = usersUpdateUsernameFlags.String("id", "REQUIRED", "")

		usersUpdateBioFlags    = flag.NewFlagSet("update-bio", flag.ExitOnError)
		usersUpdateBioBodyFlag = usersUpdateBioFlags.String("body", "REQUIRED", "")
		usersUpdateBioIDFlag   = usersUpdateBioFlags.String("id", "REQUIRED", "")
	)
	usersFlags.Usage = usersUsage
	usersCreateUserFlags.Usage = usersCreateUserUsage
	usersDeleteUserFlags.Usage = usersDeleteUserUsage
	usersFindUserByIDFlags.Usage = usersFindUserByIDUsage
	usersUpdateUsernameFlags.Usage = usersUpdateUsernameUsage
	usersUpdateBioFlags.Usage = usersUpdateBioUsage

	if err := flag.CommandLine.Parse(os.Args[1:]); err != nil {
		return nil, nil, err
	}

	if flag.NArg() < 2 { // two non flag args are required: SERVICE and ENDPOINT (aka COMMAND)
		return nil, nil, fmt.Errorf("not enough arguments")
	}

	var (
		svcn string
		svcf *flag.FlagSet
	)
	{
		svcn = flag.Arg(0)
		switch svcn {
		case "users":
			svcf = usersFlags
		default:
			return nil, nil, fmt.Errorf("unknown service %q", svcn)
		}
	}
	if err := svcf.Parse(flag.Args()[1:]); err != nil {
		return nil, nil, err
	}

	var (
		epn string
		epf *flag.FlagSet
	)
	{
		epn = svcf.Arg(0)
		switch svcn {
		case "users":
			switch epn {
			case "create-user":
				epf = usersCreateUserFlags

			case "delete-user":
				epf = usersDeleteUserFlags

			case "find-user-by-id":
				epf = usersFindUserByIDFlags

			case "update-username":
				epf = usersUpdateUsernameFlags

			case "update-bio":
				epf = usersUpdateBioFlags

			}

		}
	}
	if epf == nil {
		return nil, nil, fmt.Errorf("unknown %q endpoint %q", svcn, epn)
	}

	// Parse endpoint flags if any
	if svcf.NArg() > 1 {
		if err := epf.Parse(svcf.Args()[1:]); err != nil {
			return nil, nil, err
		}
	}

	var (
		data     any
		endpoint goa.Endpoint
		err      error
	)
	{
		switch svcn {
		case "users":
			c := usersc.NewClient(scheme, host, doer, enc, dec, restore)
			switch epn {
			case "create-user":
				endpoint = c.CreateUser()
				data, err = usersc.BuildCreateUserPayload(*usersCreateUserBodyFlag)
			case "delete-user":
				endpoint = c.DeleteUser()
				data, err = usersc.BuildDeleteUserPayload(*usersDeleteUserBodyFlag)
			case "find-user-by-id":
				endpoint = c.FindUserByID()
				data, err = usersc.BuildFindUserByIDPayload(*usersFindUserByIDIDFlag)
			case "update-username":
				endpoint = c.UpdateUsername()
				data, err = usersc.BuildUpdateUsernamePayload(*usersUpdateUsernameBodyFlag, *usersUpdateUsernameIDFlag)
			case "update-bio":
				endpoint = c.UpdateBio()
				data, err = usersc.BuildUpdateBioPayload(*usersUpdateBioBodyFlag, *usersUpdateBioIDFlag)
			}
		}
	}
	if err != nil {
		return nil, nil, err
	}

	return endpoint, data, nil
}

// usersUsage displays the usage of the users command and its subcommands.
func usersUsage() {
	fmt.Fprintf(os.Stderr, `The users service performs operations on users information.
Usage:
    %[1]s [globalflags] users COMMAND [flags]

COMMAND:
    create-user: CreateUser implements CreateUser.
    delete-user: DeleteUser implements DeleteUser.
    find-user-by-id: FindUserByID implements FindUserByID.
    update-username: UpdateUsername implements UpdateUsername.
    update-bio: UpdateBio implements UpdateBio.

Additional help:
    %[1]s users COMMAND --help
`, os.Args[0])
}
func usersCreateUserUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users create-user -body JSON

CreateUser implements CreateUser.
    -body JSON: 

Example:
    %[1]s users create-user --body '{
      "username": "Laudantium eum velit qui."
   }'
`, os.Args[0])
}

func usersDeleteUserUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users delete-user -body JSON

DeleteUser implements DeleteUser.
    -body JSON: 

Example:
    %[1]s users delete-user --body '{
      "id": 6737525150749713813
   }'
`, os.Args[0])
}

func usersFindUserByIDUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users find-user-by-id -id INT

FindUserByID implements FindUserByID.
    -id INT: 

Example:
    %[1]s users find-user-by-id --id 5370426788935271859
`, os.Args[0])
}

func usersUpdateUsernameUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users update-username -body JSON -id INT

UpdateUsername implements UpdateUsername.
    -body JSON: 
    -id INT: 

Example:
    %[1]s users update-username --body '{
      "username": "Exercitationem commodi nesciunt sed."
   }' --id 4055429871490619323
`, os.Args[0])
}

func usersUpdateBioUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users update-bio -body JSON -id INT

UpdateBio implements UpdateBio.
    -body JSON: 
    -id INT: 

Example:
    %[1]s users update-bio --body '{
      "bio": "Harum cum rerum est similique magni."
   }' --id 4719075123766742882
`, os.Args[0])
}
