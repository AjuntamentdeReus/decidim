# frozen_string_literal: true

require "spec_helper"
require "rails_helper"

require "#{Gem.loaded_specs['decidim-proposals'].full_gem_path}/lib/decidim/proposals/test/factories"

describe "Admin manages proposals", type: :system do

  # base
  let(:organization) { create(:organization) }
  let(:organization) { create(:organization, extra_user_fields:) }
  let(:extra_user_fields) do
    {
      "enabled" => true,
      "phone_number" => { "enabled" => true, "pattern" => phone_number_pattern, "placeholder" => nil }
    }
  end
  let(:phone_number_pattern) { "^(\\+34)?[0-9 ]{9,12}$" }
  let(:admin) { create(:user, :admin, :confirmed, organization: organization) }
  let!(:user) { create(:user, :confirmed, organization: organization, extended_data: { phone_number: }) }
  let(:phone_number) { "123456789" }
  let(:user_group) { create(:user_group, decidim_organization_id: organization.id, users: [user]) }

  # participation
  let(:participatory_process) do
    create(:participatory_process, :with_steps, organization: organization)
  end
  let(:component) do
    create(:component,
           manifest: Decidim.find_component_manifest("proposals"),
           participatory_space: participatory_process)
  end
  let!(:proposal) { create :proposal, component: component, users: [user] }

  context "when previewing proposals" do

    it "shows author contact info" do
      switch_to_host(organization.host)

      login_as admin, scope: :user

      visit manage_component_path(component)

      assert page.has_content? "Contacte"
      assert page.has_content? phone_number
      assert page.has_content? user.name
    end
  end
end
