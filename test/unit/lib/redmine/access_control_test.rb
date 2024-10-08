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

require File.expand_path('../../../../test_helper', __FILE__)

class ZOGO::AccessControlTest < ActiveSupport::TestCase
  def setup
    @access_module = ZOGO::AccessControl
  end

  def test_permissions
    perms = @access_module.permissions
    assert perms.is_a?(Array)
    assert perms.first.is_a?(ZOGO::AccessControl::Permission)
  end

  def test_module_permission
    perm = @access_module.permission(:view_issues)
    assert perm.is_a?(ZOGO::AccessControl::Permission)
    assert_equal :view_issues, perm.name
    assert_equal :issue_tracking, perm.project_module
    assert perm.actions.is_a?(Array)
    assert perm.actions.include?('issues/index')
  end

  def test_no_module_permission
    perm = @access_module.permission(:edit_project)
    assert perm.is_a?(ZOGO::AccessControl::Permission)
    assert_equal :edit_project, perm.name
    assert_nil perm.project_module
    assert perm.actions.is_a?(Array)
    assert perm.actions.include?('projects/settings')
  end

  def test_read_action_should_return_true_for_read_actions
    assert_equal true, @access_module.read_action?(:view_project)
    assert_equal true, @access_module.read_action?(:controller => 'projects', :action => 'show')
  end

  def test_read_action_should_return_false_for_update_actions
    assert_equal false, @access_module.read_action?(:edit_project)
    assert_equal false, @access_module.read_action?(:controller => 'projects', :action => 'edit')
  end
end
