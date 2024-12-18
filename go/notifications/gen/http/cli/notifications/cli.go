// Code generated by goa v3.15.2, DO NOT EDIT.
//
// notifications HTTP client CLI support package
//
// Command:
// $ goa gen notifications/design

package cli

import (
	"flag"
	"fmt"
	"net/http"
	notificationsc "notifications/gen/http/notifications/client"
	"os"

	goahttp "goa.design/goa/v3/http"
	goa "goa.design/goa/v3/pkg"
)

// UsageCommands returns the set of commands and sub-commands using the format
//
//	command (subcommand1|subcommand2|...)
func UsageCommands() string {
	return `notifications create-tweet-notification
`
}

// UsageExamples produces an example of a valid invocation of the CLI tool.
func UsageExamples() string {
	return os.Args[0] + ` notifications create-tweet-notification --body '{
      "text": "Rem ex cumque et quasi.",
      "tweet_id": "Dolorum aperiam et."
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
		notificationsFlags = flag.NewFlagSet("notifications", flag.ContinueOnError)

		notificationsCreateTweetNotificationFlags    = flag.NewFlagSet("create-tweet-notification", flag.ExitOnError)
		notificationsCreateTweetNotificationBodyFlag = notificationsCreateTweetNotificationFlags.String("body", "REQUIRED", "")
	)
	notificationsFlags.Usage = notificationsUsage
	notificationsCreateTweetNotificationFlags.Usage = notificationsCreateTweetNotificationUsage

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
		case "notifications":
			svcf = notificationsFlags
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
		case "notifications":
			switch epn {
			case "create-tweet-notification":
				epf = notificationsCreateTweetNotificationFlags

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
		case "notifications":
			c := notificationsc.NewClient(scheme, host, doer, enc, dec, restore)
			switch epn {
			case "create-tweet-notification":
				endpoint = c.CreateTweetNotification()
				data, err = notificationsc.BuildCreateTweetNotificationPayload(*notificationsCreateTweetNotificationBodyFlag)
			}
		}
	}
	if err != nil {
		return nil, nil, err
	}

	return endpoint, data, nil
}

// notificationsUsage displays the usage of the notifications command and its
// subcommands.
func notificationsUsage() {
	fmt.Fprintf(os.Stderr, `The notifications service performs operations on notifications information.
Usage:
    %[1]s [globalflags] notifications COMMAND [flags]

COMMAND:
    create-tweet-notification: CreateTweetNotification implements CreateTweetNotification.

Additional help:
    %[1]s notifications COMMAND --help
`, os.Args[0])
}
func notificationsCreateTweetNotificationUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] notifications create-tweet-notification -body JSON

CreateTweetNotification implements CreateTweetNotification.
    -body JSON: 

Example:
    %[1]s notifications create-tweet-notification --body '{
      "text": "Rem ex cumque et quasi.",
      "tweet_id": "Dolorum aperiam et."
   }'
`, os.Args[0])
}
