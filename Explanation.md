1. What was the bug?

The Client.request() method failed to attach an Authorization header when the oauth2_token was provided as a raw dictionary (e.g., {"access_token": "stale", "expires_at": 0}). Instead of refreshing the stale dictionary and applying the new token, the client skipped the auth logic entirely, resulting in an AssertionError: None == 'Bearer fresh-token'.

2. Why did it happen?

The logic was too strictly coupled to the OAuth2Token class. It used isinstance(self.oauth2_token, OAuth2Token) to decide whether to refresh or apply headers. Because a dictionary fails this type check, the client ignored the token data entirely, neither refreshing it nor sending the existing "stale" value.

3. Why does the fix solve it?

The fix broadens the internal logic to recognize both OAuth2Token objects and dict types.

    Expanded Detection: The condition now explicitly checks if the token is a dictionary.

    Forced Refresh: By identifying a dictionary (especially one with expires_at: 0), the code triggers refresh_oauth2().

    Standardization: The refresh method replaces the dictionary with a proper OAuth2Token object, ensuring subsequent isinstance checks pass and the header is correctly formatted via .as_header().

4. Edge case not covered: Race Conditions

The current test suite covers sequential requests but does not account for simultaneous/concurrent API calls.

    The Scenario: If three threads call request() at the same time with an expired token, all three might trigger refresh_oauth2() independently.

    The Risk: This creates a "Race Condition" where the client performs three unnecessary network calls to the auth provider. In some OAuth2 implementations, the second refresh call would invalidate the token issued by the first, causing active requests to fail mid-flight (Token Flipping).