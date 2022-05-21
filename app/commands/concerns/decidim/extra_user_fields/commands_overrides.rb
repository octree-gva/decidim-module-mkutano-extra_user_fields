# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module ExtraUserFields
    # Changes in methods to store extra fields in user profile
    module CommandsOverrides
      extend ActiveSupport::Concern

      private

      def create_user
        @user = User.create!(
          email: @form.email,
          name: @form.name,
          nickname: @form.nickname,
          password: @form.password,
          password_confirmation: @form.password_confirmation,
          organization: @form.current_organization,
          tos_agreement: @form.tos_agreement,
          newsletter_notifications_at: @form.newsletter_at,
          email_on_notification: true,
          accepted_tos_version: @form.current_organization.tos_version,
          locale: @form.current_locale,
          extended_data: extended_data
        )
      end

      def update_personal_data
        @user.name = @form.name
        @user.nickname = @form.nickname
        @user.email = @form.email
        @user.personal_url = @form.personal_url
        @user.about = @form.about
        @user.extended_data = extended_data
      end

      def extended_data
        @extended_data ||= (@user&.extended_data || {}).merge(
          first_name: @form.first_name,
          last_name: @form.last_name,
          address_1: @form.address_1,
          address_2: @form.address_2,
          city: @form.city,
          province: @form.province,
          zip_code: @form.zip_code,
          phone_number: @form.phone_number,
          age: @form.age,
          referral_type: @form.referral_type,
          referral_agent_number: @form.referral_agent_number,
          is_organization: @form.is_organization,

                  
          org_name: @form.org_name,
          org_address_1: @form.org_address_1,
          org_address_2: @form.org_address_2,
          org_city: @form.org_city,
          org_province: @form.org_province,
          org_zip_code: @form.org_zip_code,
          org_website: @form.org_website,
          org_year_started: @form.org_year_started,
          org_operating_scope: @form.org_operating_scope,
          is_non_profit: @form.is_non_profit,
          non_profit_services: @form.non_profit_services,
          non_profit_audience: @form.non_profit_audience,

        )
      end
    end
  end
end
