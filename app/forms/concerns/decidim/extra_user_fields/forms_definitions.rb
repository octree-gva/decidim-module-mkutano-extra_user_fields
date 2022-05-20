# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module ExtraUserFields
    # Extra user fields definitions for forms
    module FormsDefinitions
      extend ActiveSupport::Concern

      included do
        include ::Decidim::ExtraUserFields::ApplicationHelper
        attribute :first_name, String
        attribute :last_name, String
        attribute :address_1, String
        attribute :address_2, String
        attribute :city, String
        attribute :province, String
        attribute :zip_code, String
        attribute :phone_number, String
        attribute :age, String # see DEFAULT_AGE_OPTIONS
        attribute :referal_text, String
        attribute :referal_agent_number, String
        attribute :is_organization, String # "1"=true, "0"=false

        attribute :org_name, String
        attribute :org_address_1, String
        attribute :org_address_2, String
        attribute :org_city, String
        attribute :org_province, String
        attribute :org_zip_code, String
        attribute :org_website, String
        attribute :org_year_started, String
        attribute :org_operating_scope, String # see DEFAULT_OPERATING_SCOPE_OPTIONS
        attribute :is_non_profit, String  # "1"=true, "0"=false
        attribute :non_profit_audience, String
        attribute :non_profit_services, String

        validates :first_name, presence: true
        validates :last_name, presence: true
        validates :city, presence: true
        validates :province, presence: true
        validates :zip_code, presence: true
        validates :referal_text, presence: true
        validate :presence_if_organization, :presence_if_organization


      end
      

      def presence_if_organization
        return unless is_organization
        errors.add(:org_city, "is required") if org_city.blank?
        errors.add(:org_province, "is required") if org_province.blank?
        errors.add(:org_zip_code, "is required") if org_zip_code.blank?
        errors.add(:org_website, "is required") if org_website.blank?
        errors.add(:org_year_started, "is required") if org_year_started.blank?
        errors.add(:org_operating_scope, "is required") if org_operating_scope.blank?
      end

      def presence_if_non_profit
        return unless is_organization && is_non_profit 
        errors.add(:non_profit_audience, "is required") if non_profit_audience.blank?
        errors.add(:non_profit_services, "is required") if non_profit_services.blank?
      end

      def map_model(model)
        extended_data = model.extended_data.with_indifferent_access
        self.first_name = extended_data[:first_name]
        self.last_name = extended_data[:last_name]
        self.address_1 = extended_data[:address_1] if extended_data[:address_1].present?
        self.address_2 = extended_data[:address_2] if extended_data[:address_2].present?
        self.city = extended_data[:city]
        self.province = extended_data[:province]
        self.zip_code = extended_data[:zip_code]
        self.phone_number = extended_data[:phone_number] if extended_data[:phone_number].present?
        self.age = extended_data[:age] 
        self.referal_text = extended_data[:referal_text] 
        self.referal_agent_number = extended_data[:referal_agent_number] if extended_data[:referal_agent_number].present?
        self.is_organization = "-"
        self.is_organization = extended_data[:is_organization] if extended_data[:is_organization].present?
        self.org_name = extended_data[:org_name]
        self.org_address_1 = extended_data[:org_address_1]
        self.org_address_2 = extended_data[:org_address_2]
        self.org_city = extended_data[:org_city]
        self.org_province = extended_data[:org_province]
        self.org_zip_code = extended_data[:org_zip_code]
        self.org_website = extended_data[:org_website]
        self.org_year_started = extended_data[:org_year_started]
        self.org_operating_scope = extended_data[:org_operating_scope]
        self.is_non_profit = extended_data[:is_non_profit] if extended_data[:is_organization].present? && extended_data[:is_non_profit].present?
        self.non_profit_services = extended_data[:non_profit_services] if extended_data[:non_profit_services].present?
        self.non_profit_audience = extended_data[:non_profit_audience] if extended_data[:non_profit_audience].present?
      end
    end
  end
end
