# frozen_string_literal: true

module RequestHelpers
  # This helper helps us to create authentication header for users for specs
  module AuthenticationHelper
    def headers_with_auth_user(user = nil)
      user ||= create(:user)
      token = user.auth_token.to_s
      { content_type: 'application/json', authorization: token }
    end
  end
end
