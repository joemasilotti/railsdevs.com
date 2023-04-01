# TODO: This is the way to handle it in PHASE 1 to make no changes to HTML forms and inputs names
# For PHASE 2 we should change inputs names and avoid params mapping completely
class DeveloperQueryRansackParamsBuilder
  def call(params)
    # This is an example of how PHASE 2 should look like for a single filter `location_utc_offset_in`
    result = params.slice(:location_utc_offset_in).to_h

    # These do not look good because current database schema is denormalized
    # User has_one RoleType<part_time_contract= full_time_contract= full_time_employment=>
    # It would be more natural to have
    # User has_many RoleType<name=> so that User<id=1> => [RoleType<name=part_time_contract user_id=1>, RoleType<name=full_time_contract user_id=1>]
    # Then ransack matcher would be the following
    #
    # result['role_types_name_in'] = params[:role_types] if params[:role_types].present?
    #
    result[params[:role_types].map { |rt| "role_type_#{rt}" }.join("_or_").concat("_eq")] = true if params[:role_types].present?
    result[params[:role_levels].map { |rl| "role_level_#{rl}" }.join("_or_").concat("_eq")] = true if params[:role_levels].present?

    result["location_country_in"] = params[:countries] if params[:countries]
    # result['location_utc_offset_in'] = params[:utc_offsets] if params[:utc_offsets]
    result["specialty_tags_specialty_id_in"] = params[:specialty_ids] if params[:specialty_ids].present?

    result["actively_looking_or_open_only"] = params[:include_not_interested].blank?
    result["filter_by_search_query_no_order"] = params[:search_query] if params[:search_query].present?

    Array.wrap(params[:badges]).each { |b| result[b] = true }

    if params[:sort].to_s.downcase.to_sym == :availability
      result["available_first"] = true
    else
      result["newest_first"] = true
    end

    result
  end
end
