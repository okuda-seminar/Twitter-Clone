package featureflag

import (
	"testing"
)

func TestTimelineFeatureFlag(t *testing.T) {
	t.Run("Default value (false)", func(t *testing.T) {
		t.Cleanup(func() {
			resetTimelineFeatureFlag()
		})
		if TimelineFeatureFlag().UseNewSchema {
			t.Error("Expected UseNewSchema to be false, but got true")
		}
	})

	t.Run("Environment variable set to true", func(t *testing.T) {
		t.Cleanup(func() {
			resetTimelineFeatureFlag()
		})
		t.Setenv(useNewSchemaEnvKey, "true")
		if !TimelineFeatureFlag().UseNewSchema {
			t.Error("Expected UseNewSchema to be true, but got false")
		}
	})

	t.Run("Environment variable set to false", func(t *testing.T) {
		t.Cleanup(func() {
			resetTimelineFeatureFlag()
		})
		t.Setenv(useNewSchemaEnvKey, "false")
		if TimelineFeatureFlag().UseNewSchema {
			t.Error("Expected UseNewSchema to be false, but got true")
		}
	})
}
