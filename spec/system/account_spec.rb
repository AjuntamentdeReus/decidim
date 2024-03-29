# frozen_string_literal: true

require "spec_helper"
require "rails_helper"

describe "Account", type: :system do
  let(:user) { create(:user, :confirmed, password: password, password_confirmation: password) }
  let(:password) { "dqCFgjfDbC7dPbrv" }
  let(:organization) { user.organization }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
  end

  describe "navigation" do
    it "shows the account form when clicking on the menu" do
      visit decidim.root_path

      within_user_menu do
        find("a", text: "El meu compte").click
      end

      expect(page).to have_css("form.edit_user")
    end
  end

  context "when on the account page" do
    before do
      visit decidim.account_path
    end

    describe "updating personal data" do
      it "updates the user's data" do
        within "form.edit_user" do
          fill_in :user_name, with: "Nikola Tesla"
          fill_in :user_personal_url, with: "https://example.org"
          fill_in :user_about, with: "A Serbian-American inventor, electrical engineer, mechanical engineer, physicist, and futurist."
          find("*[type=submit]").click
        end

        within_flash_messages do
          expect(page).to have_content("correctament")
        end

        within "div.title-bar nav.topbar__user__logged" do
          expect(page).to have_content("Nikola Tesla")
        end

        user.reload

        within_user_menu do
          find("a", text: "perfil públic").click
        end

        expect(page).to have_content("example.org")
        expect(page).to have_content("Serbian-American")
      end
    end

    describe "updating the password" do
      context "when password and confirmation match" do
        it "updates the password successfully" do
          within "form.edit_user" do
            page.find(".change-password").click

            fill_in :user_password, with: "sekritpass123"
            fill_in :user_password_confirmation, with: "sekritpass123"

            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("correctament")
          end

          expect(user.reload.valid_password?("sekritpass123")).to eq(true)
        end
      end

      context "when passwords don't match" do
        it "doesn't update the password" do
          within "form.edit_user" do
            page.find(".change-password").click

            fill_in :user_password, with: "sekritpass123"
            fill_in :user_password_confirmation, with: "oopseytypo"

            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("error")
          end

          expect(user.reload.valid_password?("sekritpass123")).to eq(false)
        end
      end

      context "when updating the email" do
        it "needs to confirm it" do
          within "form.edit_user" do
            fill_in :user_email, with: "foo@bar.com"

            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("correu electrònic per confirmar")
          end
        end
      end
    end

    context "when on the notifications settings page" do
      before do
        visit decidim.notifications_settings_path
      end

      it "updates the user's notifications" do
        within ".switch.newsletter_notifications" do
          page.find(".switch-paddle").click
        end

        within "form.edit_user" do
          find("*[type=submit]").click
        end

        within_flash_messages do
          expect(page).to have_content("correctament")
        end
      end
    end

    context "when on the delete my account page" do
      before do
        visit decidim.delete_account_path
      end

      it "the user can delete his account" do
        fill_in :delete_user_delete_account_delete_reason, with: "I just want to delete my account"

        click_button "Eliminar el meu compte"

        click_button "Sí, vull eliminar el meu compte"

        within_flash_messages do
          expect(page).to have_content("correctament")
        end

        find(".sign-in-link").click

        within ".new_user" do
          fill_in :session_user_email, with: user.email
          fill_in :session_user_password, with: password
          find("*[type=submit]").click
        end

        expect(page).to have_no_content("S'ha iniciat la sessió correctament")
        expect(page).to have_no_content(user.name)
      end
    end
  end
end
