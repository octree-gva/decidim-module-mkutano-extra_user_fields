# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module ExtraUserFields
    # Changes in methods to store extra fields in user profile
    module OmniauthCommandsOverrides
      extend ActiveSupport::Concern

      private

      def create_or_find_user
        generated_password = SecureRandom.hex

        @user = User.find_or_initialize_by(
          email: verified_email,
          organization: organization
        )

        if @user.persisted?
          # If user has left the account unconfirmed and later on decides to sign
          # in with omniauth with an already verified account, the account needs
          # to be marked confirmed.
          @user.skip_confirmation! if !@user.confirmed? && @user.email == verified_email
        else
          @user.email = (verified_email || form.email)
          @user.name = form.name
          @user.nickname = form.normalized_nickname
          @user.newsletter_notifications_at = nil
          @user.email_on_notification = true
          @user.password = generated_password
          @user.password_confirmation = generated_password
          @user.remote_avatar_url = form.avatar_url if form.avatar_url.present?
          @user.skip_confirmation! if verified_email
        end

        @user.tos_agreement = "1"
        @user.extended_data = extended_data
        @user.save!
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
