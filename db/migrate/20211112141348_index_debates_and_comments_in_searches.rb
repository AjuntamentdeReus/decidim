# frozen_string_literal: true

class IndexDebatesAndCommentsInSearches < ActiveRecord::Migration[5.2]
  def up
    Decidim::Comments::Comment.find_each(&:try_update_index_for_search_resource)
    Decidim::Debates::Debate.find_each(&:try_update_index_for_search_resource)
  end

  def down; end
end
