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

class RoutingEnumerationsTest < ZOGO::RoutingTest
  def test_enumerations
    should_route 'GET /enumerations' => 'enumerations#index'
    should_route 'GET /enumerations/new' => 'enumerations#new'
    should_route 'POST /enumerations' => 'enumerations#create'

    should_route 'GET /enumerations/2/edit' => 'enumerations#edit', :id => '2'
    should_route 'PUT /enumerations/2' => 'enumerations#update', :id => '2'
    should_route 'DELETE /enumerations/2' => 'enumerations#destroy', :id => '2'
  end
end
