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
	return `users (create-user|delete-user|find-user-by-id|update-username|update-bio|follow|unfollow|get-followers|get-followings|mute|unmute)
`
}

// UsageExamples produces an example of a valid invocation of the CLI tool.
func UsageExamples() string {
	return os.Args[0] + ` users create-user --body '{
      "display_name": "Ut possimus.",
      "username": "Sapiente consequuntur modi nisi."
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

		usersFollowFlags    = flag.NewFlagSet("follow", flag.ExitOnError)
		usersFollowBodyFlag = usersFollowFlags.String("body", "REQUIRED", "")

		usersUnfollowFlags    = flag.NewFlagSet("unfollow", flag.ExitOnError)
		usersUnfollowBodyFlag = usersUnfollowFlags.String("body", "REQUIRED", "")

		usersGetFollowersFlags  = flag.NewFlagSet("get-followers", flag.ExitOnError)
		usersGetFollowersIDFlag = usersGetFollowersFlags.String("id", "REQUIRED", "")

		usersGetFollowingsFlags  = flag.NewFlagSet("get-followings", flag.ExitOnError)
		usersGetFollowingsIDFlag = usersGetFollowingsFlags.String("id", "REQUIRED", "")

		usersMuteFlags    = flag.NewFlagSet("mute", flag.ExitOnError)
		usersMuteBodyFlag = usersMuteFlags.String("body", "REQUIRED", "")

		usersUnmuteFlags    = flag.NewFlagSet("unmute", flag.ExitOnError)
		usersUnmuteBodyFlag = usersUnmuteFlags.String("body", "REQUIRED", "")
	)
	usersFlags.Usage = usersUsage
	usersCreateUserFlags.Usage = usersCreateUserUsage
	usersDeleteUserFlags.Usage = usersDeleteUserUsage
	usersFindUserByIDFlags.Usage = usersFindUserByIDUsage
	usersUpdateUsernameFlags.Usage = usersUpdateUsernameUsage
	usersUpdateBioFlags.Usage = usersUpdateBioUsage
	usersFollowFlags.Usage = usersFollowUsage
	usersUnfollowFlags.Usage = usersUnfollowUsage
	usersGetFollowersFlags.Usage = usersGetFollowersUsage
	usersGetFollowingsFlags.Usage = usersGetFollowingsUsage
	usersMuteFlags.Usage = usersMuteUsage
	usersUnmuteFlags.Usage = usersUnmuteUsage

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

			case "follow":
				epf = usersFollowFlags

			case "unfollow":
				epf = usersUnfollowFlags

			case "get-followers":
				epf = usersGetFollowersFlags

			case "get-followings":
				epf = usersGetFollowingsFlags

			case "mute":
				epf = usersMuteFlags

			case "unmute":
				epf = usersUnmuteFlags

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
			case "follow":
				endpoint = c.Follow()
				data, err = usersc.BuildFollowPayload(*usersFollowBodyFlag)
			case "unfollow":
				endpoint = c.Unfollow()
				data, err = usersc.BuildUnfollowPayload(*usersUnfollowBodyFlag)
			case "get-followers":
				endpoint = c.GetFollowers()
				data, err = usersc.BuildGetFollowersPayload(*usersGetFollowersIDFlag)
			case "get-followings":
				endpoint = c.GetFollowings()
				data, err = usersc.BuildGetFollowingsPayload(*usersGetFollowingsIDFlag)
			case "mute":
				endpoint = c.Mute()
				data, err = usersc.BuildMutePayload(*usersMuteBodyFlag)
			case "unmute":
				endpoint = c.Unmute()
				data, err = usersc.BuildUnmutePayload(*usersUnmuteBodyFlag)
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
    follow: Follow implements Follow.
    unfollow: Unfollow implements Unfollow.
    get-followers: GetFollowers implements GetFollowers.
    get-followings: GetFollowings implements GetFollowings.
    mute: Mute implements Mute.
    unmute: Unmute implements Unmute.

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
      "display_name": "Ut possimus.",
      "username": "Sapiente consequuntur modi nisi."
   }'
`, os.Args[0])
}

func usersDeleteUserUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users delete-user -body JSON

DeleteUser implements DeleteUser.
    -body JSON: 

Example:
    %[1]s users delete-user --body '{
      "id": "Unde veritatis nihil nulla et quia sunt."
   }'
`, os.Args[0])
}

func usersFindUserByIDUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users find-user-by-id -id STRING

FindUserByID implements FindUserByID.
    -id STRING: 

Example:
    %[1]s users find-user-by-id --id "Debitis ut iure minima quis incidunt."
`, os.Args[0])
}

func usersUpdateUsernameUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users update-username -body JSON -id STRING

UpdateUsername implements UpdateUsername.
    -body JSON: 
    -id STRING: 

Example:
    %[1]s users update-username --body '{
      "username": "Quas iusto omnis aspernatur nostrum ad eos."
   }' --id "Itaque labore molestiae excepturi odit minima qui."
`, os.Args[0])
}

func usersUpdateBioUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users update-bio -body JSON -id STRING

UpdateBio implements UpdateBio.
    -body JSON: 
    -id STRING: 

Example:
    %[1]s users update-bio --body '{
      "bio": "Minus illo repudiandae tempore."
   }' --id "Dolorem est veniam iste."
`, os.Args[0])
}

func usersFollowUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users follow -body JSON

Follow implements Follow.
    -body JSON: 

Example:
    %[1]s users follow --body '{
      "followee_id": "Id odit fugit.",
      "follower_id": "Non facilis et fugit."
   }'
`, os.Args[0])
}

func usersUnfollowUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users unfollow -body JSON

Unfollow implements Unfollow.
    -body JSON: 

Example:
    %[1]s users unfollow --body '{
      "followee_id": "Aut inventore ut est et.",
      "follower_id": "Beatae aspernatur labore distinctio dolores aut fugit."
   }'
`, os.Args[0])
}

func usersGetFollowersUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users get-followers -id STRING

GetFollowers implements GetFollowers.
    -id STRING: 

Example:
    %[1]s users get-followers --id "Aut dignissimos."
`, os.Args[0])
}

func usersGetFollowingsUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users get-followings -id STRING

GetFollowings implements GetFollowings.
    -id STRING: 

Example:
    %[1]s users get-followings --id "Aperiam iste deleniti voluptatem autem cum."
`, os.Args[0])
}

func usersMuteUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users mute -body JSON

Mute implements Mute.
    -body JSON: 

Example:
    %[1]s users mute --body '{
      "muted_user_id": "Provident sed quis et blanditiis debitis quo.",
      "muting_user_id": "Odit expedita iure aut ut."
   }'
`, os.Args[0])
}

func usersUnmuteUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] users unmute -body JSON

Unmute implements Unmute.
    -body JSON: 

Example:
    %[1]s users unmute --body '{
      "muted_user_id": "Commodi ullam in quibusdam dignissimos.",
      "muting_user_id": "Assumenda ad ut voluptas."
   }'
`, os.Args[0])
}
