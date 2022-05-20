# frozen_string_literal: true

module Decidim
  module ExtraUserFields
    # Custom helpers, scoped to the extra_user_fields engine.
    #
    module ApplicationHelper
      def age_options_for_select
        Decidim::ExtraUserFields::Engine::DEFAULT_AGE_OPTIONS.map do |age|
          [age, I18n.t(age, scope: "decidim.extra_user_fields.ages")]
        end
      end

      def operating_scope_options_for_select
        Decidim::ExtraUserFields::Engine::DEFAULT_OPERATING_SCOPE.map do |scope|
          [scope, I18n.t(scope, scope: "decidim.extra_user_fields.operating_scopes")]
        end
      end
    end
  end
end
