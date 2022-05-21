# frozen_string_literal: true

module Decidim
  # This class serializes a User so can be exported to CSV
  module ExtraUserFields
    class UserExportSerializer < Decidim::DataPortabilitySerializers::DataPortabilityUserSerializer
      # Public: Exports a hash with the serialized data for the user including
      # extra user fields
      def serialize
        super.merge(extra_user_fields)
      end

      def extra_user_fields
        extended_data = resource.extended_data.symbolize_keys

        [:first_name,
          :last_name,
          :address_1,
          :address_2,
          :city,
          :province,
          :zip_code,
          :phone_number,
          :age,
          :referral_type,
          :referral_agent_number,
          :is_organization,
          :org_name,
          :org_address_1,
          :org_address_2,
          :org_city,
          :org_province,
          :org_zip_code,
          :org_website,
          :org_year_started,
          :org_operating_scope,
          :is_non_profit,
          :non_profit_services,
          :non_profit_audience,
        ].each_with_object({}) do |key, fields|
          fields[key] = extended_data[key]
        end
      end
    end
  end
end
