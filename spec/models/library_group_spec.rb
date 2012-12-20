# -*- encoding: utf-8 -*-
require 'spec_helper'

describe LibraryGroup do
  fixtures :library_groups

  it "should get library_group_config" do
    LibraryGroup.site_config.should be_true
  end

  it "should allow access from allowed networks" do
    library_group = LibraryGroup.find(1)
    library_group.my_networks = "127.0.0.1"
    library_group.network_access_allowed?("192.168.0.1").should be_false
  end
end

# == Schema Information
#
# Table name: library_groups
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  display_name   :text
#  short_name     :string(255)      not null
#  email          :string(255)
#  my_networks    :text
#  login_banner   :text
#  note           :text
#  country_id     :integer
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  admin_networks :text
#  url            :string(255)      default("http://localhost:3000/")
#

