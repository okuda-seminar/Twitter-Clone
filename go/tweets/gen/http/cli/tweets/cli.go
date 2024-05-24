// Code generated by goa v3.15.2, DO NOT EDIT.
//
// tweets HTTP client CLI support package
//
// Command:
// $ goa gen tweets/design

package cli

import (
	"flag"
	"fmt"
	"net/http"
	"os"
	tweetsc "tweets/gen/http/tweets/client"

	goahttp "goa.design/goa/v3/http"
	goa "goa.design/goa/v3/pkg"
)

// UsageCommands returns the set of commands and sub-commands using the format
//
//	command (subcommand1|subcommand2|...)
func UsageCommands() string {
	return `tweets (create-tweet|delete-tweet|like-tweet|delete-tweet-like)
`
}

// UsageExamples produces an example of a valid invocation of the CLI tool.
func UsageExamples() string {
	return os.Args[0] + ` tweets create-tweet --body '{
      "text": "Sunt sed quisquam ad corrupti labore consequatur.",
      "user_id": "Voluptas omnis nesciunt incidunt et totam eos."
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
		tweetsFlags = flag.NewFlagSet("tweets", flag.ContinueOnError)

		tweetsCreateTweetFlags    = flag.NewFlagSet("create-tweet", flag.ExitOnError)
		tweetsCreateTweetBodyFlag = tweetsCreateTweetFlags.String("body", "REQUIRED", "")

		tweetsDeleteTweetFlags    = flag.NewFlagSet("delete-tweet", flag.ExitOnError)
		tweetsDeleteTweetBodyFlag = tweetsDeleteTweetFlags.String("body", "REQUIRED", "")

		tweetsLikeTweetFlags    = flag.NewFlagSet("like-tweet", flag.ExitOnError)
		tweetsLikeTweetBodyFlag = tweetsLikeTweetFlags.String("body", "REQUIRED", "")

		tweetsDeleteTweetLikeFlags    = flag.NewFlagSet("delete-tweet-like", flag.ExitOnError)
		tweetsDeleteTweetLikeBodyFlag = tweetsDeleteTweetLikeFlags.String("body", "REQUIRED", "")
	)
	tweetsFlags.Usage = tweetsUsage
	tweetsCreateTweetFlags.Usage = tweetsCreateTweetUsage
	tweetsDeleteTweetFlags.Usage = tweetsDeleteTweetUsage
	tweetsLikeTweetFlags.Usage = tweetsLikeTweetUsage
	tweetsDeleteTweetLikeFlags.Usage = tweetsDeleteTweetLikeUsage

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
		case "tweets":
			svcf = tweetsFlags
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
		case "tweets":
			switch epn {
			case "create-tweet":
				epf = tweetsCreateTweetFlags

			case "delete-tweet":
				epf = tweetsDeleteTweetFlags

			case "like-tweet":
				epf = tweetsLikeTweetFlags

			case "delete-tweet-like":
				epf = tweetsDeleteTweetLikeFlags

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
		case "tweets":
			c := tweetsc.NewClient(scheme, host, doer, enc, dec, restore)
			switch epn {
			case "create-tweet":
				endpoint = c.CreateTweet()
				data, err = tweetsc.BuildCreateTweetPayload(*tweetsCreateTweetBodyFlag)
			case "delete-tweet":
				endpoint = c.DeleteTweet()
				data, err = tweetsc.BuildDeleteTweetPayload(*tweetsDeleteTweetBodyFlag)
			case "like-tweet":
				endpoint = c.LikeTweet()
				data, err = tweetsc.BuildLikeTweetPayload(*tweetsLikeTweetBodyFlag)
			case "delete-tweet-like":
				endpoint = c.DeleteTweetLike()
				data, err = tweetsc.BuildDeleteTweetLikePayload(*tweetsDeleteTweetLikeBodyFlag)
			}
		}
	}
	if err != nil {
		return nil, nil, err
	}

	return endpoint, data, nil
}

// tweetsUsage displays the usage of the tweets command and its subcommands.
func tweetsUsage() {
	fmt.Fprintf(os.Stderr, `The tweets service performs operations on tweets information.
Usage:
    %[1]s [globalflags] tweets COMMAND [flags]

COMMAND:
    create-tweet: CreateTweet implements CreateTweet.
    delete-tweet: DeleteTweet implements DeleteTweet.
    like-tweet: LikeTweet implements LikeTweet.
    delete-tweet-like: DeleteTweetLike implements DeleteTweetLike.

Additional help:
    %[1]s tweets COMMAND --help
`, os.Args[0])
}
func tweetsCreateTweetUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] tweets create-tweet -body JSON

CreateTweet implements CreateTweet.
    -body JSON: 

Example:
    %[1]s tweets create-tweet --body '{
      "text": "Sunt sed quisquam ad corrupti labore consequatur.",
      "user_id": "Voluptas omnis nesciunt incidunt et totam eos."
   }'
`, os.Args[0])
}

func tweetsDeleteTweetUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] tweets delete-tweet -body JSON

DeleteTweet implements DeleteTweet.
    -body JSON: 

Example:
    %[1]s tweets delete-tweet --body '{
      "id": "Officiis explicabo id omnis dolores et ipsa."
   }'
`, os.Args[0])
}

func tweetsLikeTweetUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] tweets like-tweet -body JSON

LikeTweet implements LikeTweet.
    -body JSON: 

Example:
    %[1]s tweets like-tweet --body '{
      "tweet_id": "Iste quo et assumenda enim ut.",
      "user_id": "Voluptatem ab nihil dolor perspiciatis."
   }'
`, os.Args[0])
}

func tweetsDeleteTweetLikeUsage() {
	fmt.Fprintf(os.Stderr, `%[1]s [flags] tweets delete-tweet-like -body JSON

DeleteTweetLike implements DeleteTweetLike.
    -body JSON: 

Example:
    %[1]s tweets delete-tweet-like --body '{
      "tweet_id": "Nemo rerum fugit voluptate harum facilis cum.",
      "user_id": "Quod cumque iusto deleniti doloremque."
   }'
`, os.Args[0])
}
