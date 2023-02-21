# frozen_string_literal: true

module Decidim
  module ExtraUserFields
    # Custom helpers, scoped to the extra_user_fields engine.
    #
    module ApplicationHelper
      def referral_options_for_select
        Decidim::ExtraUserFields::Engine::DEFAULT_REFERRAL_OPTIONS.map do |referral|
          [referral, I18n.t(referral, scope: "decidim.extra_user_fields.referral")]
        end
      end
      def province_options_for_select
        Decidim::ExtraUserFields::Engine::DEFAULT_PROVINCE_OPTIONS.map do |province|
          [province, I18n.t(province, scope: "decidim.extra_user_fields.province")]
        end
      end
      def age_options_for_select
        Decidim::ExtraUserFields::Engine::DEFAULT_AGE_OPTIONS.map do |age|
          [age, I18n.t(age, scope: "decidim.extra_user_fields.ages")]
        end
      end
      
      def identify_as_black_options_for_select
        Decidim::ExtraUserFields::Engine::DEFAULT_IDENTIFY_AS_BLACK_OPTIONS.map do |identify_as_black|
          [identify_as_black, I18n.t(identify_as_black, scope: "decidim.extra_user_fields.identify_as_black")]
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
