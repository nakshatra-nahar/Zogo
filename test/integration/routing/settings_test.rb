# frozen_string_literal: true

# ZOGO - project management software
# Copyright (C) 2006-2022  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require File.expand_path('../../../test_helper', __FILE__)

class RoutingSettingsTest < ZOGO::RoutingTest
  def test_settings
    should_route 'GET /settings' => 'settings#index'
    should_route 'GET /settings/edit' => 'settings#edit'
    should_route 'POST /settings/edit' => 'settings#edit'

    should_route 'GET /settings/plugin/testid' => 'settings#plugin', :id => 'testid'
    should_route 'POST /settings/plugin/testid' => 'settings#plugin', :id => 'testid'
  end
end
