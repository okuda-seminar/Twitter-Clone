package featureflag

import (
	"os"
	"sync"
)

type timelineFeatureFlag struct {
	UseNewSchema bool
}

const (
	useNewSchemaEnvKey = "USE_NEW_SCHEMA"
)

var (
	timelineFeatureFlagInstance *timelineFeatureFlag
	once                        sync.Once
)

func TimelineFeatureFlag() *timelineFeatureFlag {
	once.Do(func() {
		timelineFeatureFlagInstance = &timelineFeatureFlag{
			UseNewSchema: booleanFlag(false, useNewSchemaEnvKey),
		}
	})
	return timelineFeatureFlagInstance
}

func booleanFlag(defaultValue bool, envName string) bool {
	envValue := os.Getenv(envName)
	switch envValue {
	case "true":
		return true
	case "false":
		return false
	default:
		return defaultValue
	}
}
