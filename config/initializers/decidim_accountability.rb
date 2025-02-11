# frozen_string_literal: true

Decidim::Accountability::StatusCell.class_eval do
  include Decidim::Accountability::BreadcrumbHelper
end
