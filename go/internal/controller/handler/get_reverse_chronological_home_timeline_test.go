package handler

// func (s *handlerTestSuite) TestGetReverseChronologicalHomeTimeline() {
// 	// This test method verifies the number of posts in the response body.
// 	user1ID := s.newTestUser(`{ "username": "test1", "display_name": "test1", "password": "securepassword" }`)
// 	post1ID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test1" }`, user1ID))
// 	user2ID := s.newTestUser(`{ "username": "test2", "display_name": "test2", "password": "securepassword" }`)
// 	_ = s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test2" }`, user2ID))
// 	user3ID := s.newTestUser(`{ "username": "test3", "display_name": "test3", "password": "securepassword" }`)
// 	_ = s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test3" }`, user3ID))
// 	user4ID := s.newTestUser(`{ "username": "test4", "display_name": "test4", "password": "securepassword" }`)
// 	s.newTestFollow(user3ID, user2ID)
// 	user5ID := s.newTestUser(`{ "username": "test5", "display_name": "test5", "password": "securepassword" }`)
// 	post2ID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test5" }`, user5ID))
// 	repostID := s.newTestRepost(user5ID, post2ID)
// 	user6ID := s.newTestUser(`{ "username": "test6", "display_name": "test6", "password": "securepassword" }`)
// 	post3ID := s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test6" }`, user6ID))
// 	quoteRepostID := s.newTestQuoteRepost(user6ID, post3ID)

// 	tests := []struct {
// 		name          string
// 		userID        string
// 		expectedCount int
// 	}{
// 		{
// 			name:          "get only a target user posts",
// 			userID:        user1ID,
// 			expectedCount: 1,
// 		},
// 		{
// 			name:          "get a target user and following users posts",
// 			userID:        user3ID,
// 			expectedCount: 2,
// 		},
// 		{
// 			name:          "get no posts",
// 			userID:        user4ID,
// 			expectedCount: 0,
// 		},
// 		{
// 			name:          "get posts already posted and posts posted during timeline access",
// 			userID:        user3ID,
// 			expectedCount: 3,
// 		},
// 		{
// 			name:          "get posts and posts deleted during timeline access",
// 			userID:        user1ID,
// 			expectedCount: 2,
// 		},
// 		{
// 			name:          "get posts and reposts deleted during timeline access",
// 			userID:        user5ID,
// 			expectedCount: 3,
// 		},
// 		{
// 			name:          "get a target user post and a repost notification during timeline access",
// 			userID:        user5ID,
// 			expectedCount: 2,
// 		},
// 		{
// 			name:          "get posts and quote reposts deleted during timeline access",
// 			userID:        user6ID,
// 			expectedCount: 3,
// 		},
// 		{
// 			name:          "get a target user post and a quote repost notification during timeline access",
// 			userID:        user6ID,
// 			expectedCount: 2,
// 		},
// 	}

// 	for _, test := range tests {
// 		ctx, cancel := context.WithTimeout(context.Background(), 200*time.Millisecond)
// 		defer cancel()
// 		rr := httptest.NewRecorder()
// 		req := httptest.NewRequest(
// 			"GET",
// 			"/api/users/{id}/timelines/reverse_chronological",
// 			strings.NewReader(""),
// 		).WithContext(ctx)
// 		req.SetPathValue("id", test.userID)

// 		getReverseChronologicalHomeTimelineHandler := NewGetReverseChronologicalHomeTimelineHandler(s.db, &s.mu, &s.userChannels, s.connected)

// 		var wg sync.WaitGroup

// 		wg.Add(1)
// 		go func() {
// 			defer wg.Done()
// 			getReverseChronologicalHomeTimelineHandler.GetReverseChronologicalHomeTimeline(rr, req, test.userID)
// 		}()
// 		var timelineitems []entity.TimelineItem

// 		// This channel indicates that the httptest client has successfully connected to the handler.
// 		// Wait here to ensure that the connection is established before triggering timeline updates.
// 		<-s.connected

// 		if test.name == "get posts already posted and posts posted during timeline access" {
// 			_ = s.newTestPost(fmt.Sprintf(`{ "user_id": "%s", "text": "test5" }`, test.userID))
// 		}
// 		if test.name == "get posts and posts deleted during timeline access" {
// 			s.newTestDeletePost(post1ID)
// 		}
// 		if test.name == "get posts and reposts deleted during timeline access" {
// 			s.newTestDeleteRepost(user5ID, post2ID, repostID)
// 		}
// 		if test.name == "get a target user post and a repost notification during timeline access" {
// 			_ = s.newTestRepost(user5ID, post2ID)
// 		}
// 		if test.name == "get posts and quote reposts deleted during timeline access" {
// 			s.newTestDeleteRepost(user6ID, post3ID, quoteRepostID)
// 		}
// 		if test.name == "get a target user post and a quote repost notification during timeline access" {
// 			_ = s.newTestQuoteRepost(user6ID, post3ID)
// 		}

// 		wg.Wait()
// 		scanner := bufio.NewScanner(rr.Body)

// 		for scanner.Scan() {
// 			line := scanner.Text()
// 			if strings.HasPrefix(line, "data:") {
// 				jsonData := strings.TrimPrefix(line, "data: ")
// 				var timelineEvent entity.TimelineEvent

// 				err := json.Unmarshal([]byte(jsonData), &timelineEvent)
// 				if err != nil {
// 					s.T().Errorf("Failed to decode JSON: %v", err)
// 				}
// 				for _, timelineitem := range timelineEvent.TimelineItems {
// 					timelineitems = append(timelineitems, *timelineitem)
// 				}
// 			}
// 		}

// 		if len(timelineitems) != test.expectedCount {
// 			s.T().Errorf("%s: wrong number of posts returned; expected %d, but got timelineitems: %d", test.name, test.expectedCount, len(timelineitems))
// 		}
// 	}
// }
