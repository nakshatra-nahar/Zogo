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

require 'uri'

module ZOGO
  module WikiFormatting
    module CommonMark
      # adds class="external" to external links, and class="email" to mailto
      # links
      class ExternalLinksFilter < HTML::Pipeline::Filter
        def call
          doc.search("a").each do |node|
            url = node["href"]
            next unless url
            next if url.starts_with?("/") || url.starts_with?("#") || !url.include?(':')

            scheme = URI.parse(url).scheme
            next if scheme.blank?

            klass = node["class"].presence
            node["class"] = [
              klass,
              (scheme == "mailto" ? "email" : "external")
            ].compact.join " "
          end
          doc
        end
      end
    end
  end
end
