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

require File.expand_path('../../../../../../test_helper', __FILE__)

if Object.const_defined?(:CommonMarker)
  require 'zogo/wiki_formatting/common_mark/fixup_auto_links_filter'

  class ZOGO::WikiFormatting::CommonMark::FixupAutoLinksFilterTest < ActiveSupport::TestCase
    def filter(html)
      ZOGO::WikiFormatting::CommonMark::FixupAutoLinksFilter.to_html(html, @options)
    end

    def format(markdown)
      ZOGO::WikiFormatting::CommonMark::MarkdownFilter.to_html(markdown, ZOGO::WikiFormatting::CommonMark::PIPELINE_CONFIG)
    end

    def setup
      @options = { }
    end

    def test_should_fixup_autolinked_user_references
      text = "user:user@example.org"
      assert_equal "<p>#{text}</p>", filter(format(text))
      text = "@user@example.org"
      assert_equal "<p>#{text}</p>", filter(format(text))
    end

    def test_should_fixup_autolinked_hires_files
      text = "printscreen@2x.png"
      assert_equal "<p>#{text}</p>", filter(format(text))
    end
  end
end
