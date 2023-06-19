valid_linkedin_developer = SeedsHelper.create_developer!("valid_linkedin_developer", {
  hero: "Valid Linkedin developer",
  location: SeedsHelper.locations[:new_york],
  linkedin: "johnrmarty"
})
invalid_linkedin_developer = SeedsHelper.create_developer!("invalid_linkedin_developer", {
  hero: "Invalid Linkedin developer",
  location: SeedsHelper.locations[:new_york],
  linkedin: "1234p"
})

Developers::ExternalProfile.find_or_create_by!(developer: valid_linkedin_developer) do |profile|
  profile.site = "linkedin"
  profile.data = {
    company: "Freedom Fund Real Estate",
    company_linkedin_profile_url: "https://www.linkedin.com/company/freedomfund",
    description: Faker::Lorem.paragraph(sentence_count: 5),
    ends_at: nil,
    location: nil,
    logo_url: "",
    starts_at: {
      day: rand(1..31),
      month: rand(1..12),
      year: rand(1980..2022)
    },
    title: "Co-Founder"
  }
  profile.error = ""
end

Developers::ExternalProfile.find_or_create_by!(developer: invalid_linkedin_developer) do |profile|
  profile.site = "linkedin"
  profile.data = {}
  profile.error = 'API Error: 404 - {"code"=>404, "description"=>"Person profile does not exist", "name"=>"Not Found"}'
end
